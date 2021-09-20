.DEFAULT_GOAL := all
VENV_DIR := tools/venv
ROBOT_REPO := https://github.com/ontodev/robot
ROBOT_DIR := tools/robot
PYTHON := $(VENV_DIR)/bin/python
PIP := $(VENV_DIR)/bin/pip
PYLODE := $(VENV_DIR)/bin/pylode
ROBOT := $(ROBOT_DIR)/bin/robot
EDTFO := https://periodo.github.io/edtf-ontology
RPO := http://josd.github.io/eye/reasoning/rpo
CASES := $(shell find cases -maxdepth 3 -mindepth 3 -type d)
RULESETS := \
	rdfs-domain \
	rdfs-range

$(PYTHON):
	python3 -m venv $(VENV_DIR)

$(PIP): | $(PYTHON)
	$(PIP) install --upgrade pip

$(PYLODE): | $(PIP)
	$(PIP) install pylode

$(ROBOT):
	mkdir -p $(ROBOT_DIR)/bin
	curl -L $(ROBOT_REPO)/releases/download/v1.8.1/robot.jar \
	> $(ROBOT_DIR)/bin/robot.jar
	curl -L $(ROBOT_REPO)/raw/master/bin/robot > $@
	chmod +x $@

doc/html/index.html: edtfo.ttl tools/diagram.sed | $(PYLODE)
	riot -q --validate $<
	$(PYLODE) -c false -i $< | sed -f tools/diagram.sed > $@

doc/html/report.html: edtfo.ttl tools/report-profile.txt | $(ROBOT)
	riot -q --validate $<
	$(ROBOT) report --input $< --output $@ \
	--profile tools/report-profile.txt

merged.ttl: edtfo.ttl | $(ROBOT)
	riot -q --validate $<
	$(ROBOT) merge --input $< --output $@

doc/html/validation.txt: merged.ttl | $(ROBOT)
	$(ROBOT) validate-profile --input $< --output $@ --profile Full

cache/%.n3:
	mkdir -p cache
	curl -L $(RPO)/$*.n3 > $@

ruleset_urls := $(foreach ruleset,$(RULESETS),$(RPO)/$(ruleset).n3)
cached_rulesets := $(foreach ruleset,$(RULESETS),cache/$(ruleset).n3)

rules/derived/regexes.n3: rules/regexes.n3
	mkdir -p rules/derived
	eye --quiet $^ --pass-only-new 2> /dev/null > $@

.SECONDEXPANSION:
cases/%/owltime-raw.ttl: \
rules/regexes.n3 \
rules/derived/regexes.n3 \
rules/common.n3 \
rules/$$(dir $$*)rules.n3 \
cases/%/edtf.ttl \
| $(cached_rulesets)
	eye \
	--wcache $(RPO) cache \
	$(ruleset_urls) \
	$^ \
	--pass-only-new \
	2> /dev/null \
	> $@

cases/%/owltime.ttl: cases/%/owltime-raw.ttl tools/cleanup-inferences.rq
	arq --data=$< --query=$(word 2,$^) \
	| riot --syntax=ttl --formatted=ttl --base=$(EDTFO)/ - \
	| ./tools/cleanup-prefixes $(EDTFO) \
	> $@

cases_owltime := $(foreach case,$(CASES),$(case)/owltime.ttl)

# check that : prefix matches filename
check_prefixes: $(cases_owltime)
	./tools/check-prefixes

check_turtle_syntax: $(cases_owltime)
	riot -q --validate cases/level-?/*/*/*.ttl

check_invalid_cases:
	./tools/check-invalid-cases

check_cases: check_prefixes check_turtle_syntax check_invalid_cases

all: \
doc/html/report.html \
doc/html/validation.txt \
doc/html/index.html \
check_cases

watch:
	ls edtfo.ttl | entr make -s doc/html/report.html

serve: | $(PYTHON)
	$(PYTHON) -m http.server -b 127.0.0.1 -d doc/html

publish: all
	./tools/publish

clean_cases:
	rm -f $(cases_owltime)
	rm -f $(subst owltime,owltime-raw,$(cases_owltime))

clean: clean_cases
	rm -rf $(VENV_DIR) $(ROBOT_DIR) cache \
	doc/html/index.html doc/html/report.html doc/html/validation.txt \

.PRECIOUS: cache/%.n3

.PHONY: \
check_prefixes \
check_turtle_syntax \
check_cases \
all \
watch \
serve \
publish \
clean \
clean_cases
