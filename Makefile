.DEFAULT_GOAL := all
VENV_DIR := tools/venv
ROBOT_REPO := https://github.com/ontodev/robot
ROBOT_DIR := tools/robot
PYTHON := $(VENV_DIR)/bin/python
PIP := $(VENV_DIR)/bin/pip
PYLODE := $(VENV_DIR)/bin/pylode
ROBOT := $(ROBOT_DIR)/bin/robot

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

# check that : prefix matches filename
check_prefixes:
	./tools/check-prefixes

check_turtle_syntax:
	riot -q --validate cases/*/*.ttl

check_cases: check_prefixes check_turtle_syntax

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

clean:
	rm -rf $(VENV_DIR) $(ROBOT_DIR) \
	doc/html/index.html doc/html/report.html doc/html/validation.txt

.PHONY: \
check_prefixes \
check_turtle_syntax \
check_cases \
all \
watch \
serve \
publish \
clean
