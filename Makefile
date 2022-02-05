.DEFAULT_GOAL := all
SHELL := /usr/bin/env bash
.SHELLFLAGS := -o pipefail -O globstar -c
ROBOT_REPO := https://github.com/ontodev/robot
ROBOT_DIR := tools/robot
ROBOT := $(ROBOT_DIR)/bin/robot
HERMIT_HOST := http://www.hermit-reasoner.com/download/1.3.8
HERMIT_DIR := tools/hermit
HERMIT := $(HERMIT_DIR)/bin/hermit
UNSTAR_HOST := https://raw.githubusercontent.com/rybesh/unstar/main/dist
UNSTAR_DIR := tools/unstar
UNSTAR := $(UNSTAR_DIR)/unstar
VENV_DIR := tools/venv
PYTHON := $(VENV_DIR)/bin/python
PYLODE := $(VENV_DIR)/bin/pylode
RDFPIPE := $(VENV_DIR)/bin/rdfpipe
EDTFO := https://periodo.github.io/edtf-ontology
RPO := http://josd.github.io/eye/reasoning/rpo
CASES := $(dir $(shell find cases/level-? -name edtf.ttl))
LEVEL_0 := $(dir $(shell find cases/level-0 -name edtf.ttl))
LEVEL_1 := $(dir $(shell find cases/level-1 -name edtf.ttl))
LEVEL_2 := $(dir $(shell find cases/level-2 -name edtf.ttl))
RULESETS := \
	rdfs-domain \
	rdfs-range \
	rdfs-subClassOf \
	owl-hasValue

# Tools ########################################################################

$(PYTHON):
	python3 -m venv $(VENV_DIR)
	$(PYTHON) -m pip install --upgrade pip

$(RDFPIPE): | $(PYTHON)
	$(PYTHON) -m pip install rdflib

$(PYLODE): | $(PYTHON)
	$(PYTHON) -m pip install pyLODE==2.13.2

$(ROBOT):
	mkdir -p $(ROBOT_DIR)/bin
	curl -L $(ROBOT_REPO)/releases/download/v1.8.1/robot.jar \
	> $(ROBOT_DIR)/bin/robot.jar
	curl -L $(ROBOT_REPO)/raw/master/bin/robot > $@
	chmod +x $@

$(HERMIT):
	mkdir -p $(HERMIT_DIR)/bin
	curl -L $(HERMIT_HOST)/HermiT.zip \
	> $(HERMIT_DIR)/hermit.zip
	unzip $(HERMIT_DIR)/hermit.zip -d $(HERMIT_DIR)/bin
	rm $(HERMIT_DIR)/hermit.zip
	echo "#! /bin/sh" > $@
	echo "DIR=\$$(dirname \$$0)" >> $@
	echo "exec java -jar \"\$$DIR/HermiT.jar\" \"\$$@\"" >> $@
	chmod +x $@

$(UNSTAR):
	curl $(UNSTAR_HOST)/unstar.tgz | tar -C tools -xzf -

# Ontology docs ################################################################

doc/html/index.html: edtfo.ttl tools/diagram.sed | $(PYLODE)
	riot -q --validate $<
	$(PYLODE) -c false -i $< -o $@
	sed -f tools/diagram.sed -i "" $@

doc/html/report.html: edtfo.ttl tools/report-profile.txt | $(ROBOT)
	riot -q --validate $<
	$(ROBOT) report --input $< --output $@ \
	--profile tools/report-profile.txt

merged.ttl: edtfo.ttl | $(ROBOT)
	riot -q --validate $<
	$(ROBOT) merge --input $< --output $@

doc/html/validation.txt: merged.ttl | $(ROBOT)
	$(ROBOT) validate-profile --input $< --output $@ --profile Full

# Utils ########################################################################

cache/%.n3:
	mkdir -p cache
	curl -L $(RPO)/$*.n3 > $@

ruleset_urls := $(foreach ruleset,$(RULESETS),$(RPO)/$(ruleset).n3)
cached_rulesets := $(foreach ruleset,$(RULESETS),cache/$(ruleset).n3)

rules/derived/regexes.n3: rules/regexes.n3
	mkdir -p rules/derived
	eye --quiet $^ --pass-only-new > $@

joinwith = $(subst $(eval) ,$1,$2)

rulepath = $(call joinwith,/,$(wordlist 1,2,$(subst /, , $1)))

# Cases ########################################################################

cases/level-1/interval/qualified-%/owltime-raw.ttl: \
rules/regexes.n3 \
rules/derived/regexes.n3 \
rules/common.n3 \
rules/level-1/qualification/rules.n3 \
rules/level-1/interval/rules.n3 \
cases/level-1/interval/qualified-%/edtf.ttl \
| $(cached_rulesets)
	eye \
	--quiet \
	--nope \
	--wcache $(RPO) cache \
	$(ruleset_urls) \
	$^ \
	--pass \
	> $@

cases/level-2/interval/qualified-%/owltime-raw.ttl: \
rules/regexes.n3 \
rules/derived/regexes.n3 \
rules/common.n3 \
rules/level-2/qualification/rules.n3 \
rules/level-2/interval/rules.n3 \
cases/level-2/interval/qualified-%/edtf.ttl \
| $(cached_rulesets)
	eye \
	--quiet \
	--nope \
	--wcache $(RPO) cache \
	$(ruleset_urls) \
	$^ \
	--pass \
	> $@

cases/level-2/interval/unspecified-%/owltime-raw.ttl: \
rules/regexes.n3 \
rules/derived/regexes.n3 \
rules/common.n3 \
rules/level-2/unspecified/rules.n3 \
rules/level-2/interval/rules.n3 \
cases/level-2/interval/unspecified-%/edtf.ttl \
| $(cached_rulesets)
	eye \
	--quiet \
	--nope \
	--wcache $(RPO) cache \
	$(ruleset_urls) \
	$^ \
	--pass \
	> $@

.SECONDEXPANSION:
cases/%/owltime-raw.ttl: \
rules/regexes.n3 \
rules/derived/regexes.n3 \
rules/common.n3 \
rules/$$(call rulepath,$$*)/rules.n3 \
cases/%/edtf.ttl \
| $(cached_rulesets)
	eye \
	--quiet \
	--nope \
	--skolem-genid "$*" \
	--wcache $(RPO) cache \
	$(ruleset_urls) \
	$^ \
	--pass \
	> $@

cases/%/owltime.ttl: \
cases/%/owltime-raw.ttl \
tools/cleanup-inferences.rq \
| $(UNSTAR) $(RDFPIPE)
	arq --data=$< --query=$(word 2,$^) \
	| $(UNSTAR) - \
	| $(RDFPIPE) -i turtle -o longturtle - \
	| ./tools/unuuid/unuuid.py \
	| sed -E "s|http://josd.github.io|https://periodo.github.io/edtf-ontology|" \
	| sed -E "s|[[:space:]]{4}|  |g" \
	> $@
	./tools/check-triple-count $@

cases_owltime := $(foreach case,$(CASES),$(case)owltime.ttl)
level0_owltime := $(foreach case,$(LEVEL_0),$(case)owltime.ttl)
level1_owltime := $(foreach case,$(LEVEL_1),$(case)owltime.ttl)
level2_owltime := $(foreach case,$(LEVEL_2),$(case)owltime.ttl)

# Phony targets ################################################################

# check that : prefix matches filename
check_prefixes: $(cases_owltime)
	./tools/check-prefixes

check_turtle_syntax: $(cases_owltime)
	riot -q --validate cases/level-?/**/*.ttl

check_invalid_cases:
	./tools/check-invalid-cases

check_cases: check_prefixes check_turtle_syntax check_invalid_cases

all: \
doc/html/report.html \
doc/html/validation.txt \
doc/html/index.html \
check_cases

level0: $(level0_owltime)
level1: $(level1_owltime)
level2: $(level2_owltime)

watch:
	ls edtfo.ttl | entr make -s doc/html/report.html

serve: | $(PYTHON)
	$(PYTHON) -m http.server -b 127.0.0.1 -d doc/html

publish: all
	./tools/publish

clean_cases:
	rm -f $(cases_owltime)
	rm -f $(subst owltime.ttl,owltime-raw.ttl,$(cases_owltime))

clean: clean_cases
	rm -rf $(VENV_DIR) $(ROBOT_DIR) $(HERMIT_DIR) \
	rm -rf rules/derived cache \
	doc/html/index.html doc/html/report.html doc/html/validation.txt \

.PRECIOUS: \
cache/%.n3 \
cases/%/owltime.ttl \
cases/level-1/qualification/%/owltime.ttl \
cases/level-1/interval/qualified-%/owltime.ttl \
cases/level-2/qualification/%/owltime.ttl \
cases/level-2/interval/qualified-%/owltime.ttl

.PHONY: \
check_prefixes \
check_turtle_syntax \
check_cases \
check_invalid_cases \
all \
level0 \
level1 \
level2 \
watch \
serve \
publish \
clean \
clean_cases
