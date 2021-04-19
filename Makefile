.DEFAULT_GOAL := doc/html/index.html
VENV_DIR := tools/venv
BIN_DIR := $(VENV_DIR)/bin
PYTHON := $(BIN_DIR)/python
PIP := $(BIN_DIR)/pip
PYLODE := $(BIN_DIR)/pylode

$(PIP):
	python3 -m venv $(VENV_DIR)
	$(PIP) install --upgrade pip

$(PYLODE): | $(PIP)
	$(PIP) install pylode

doc/html/index.html: edtfo.ttl tools/diagram.sed | $(PYLODE)
	riot -q --validate $<
	$(PYLODE) -c false -i $< | sed -f tools/diagram.sed > $@

# check that : prefix matches filename
check_prefixes:
	for f in cases/*/*.ttl ; do \
	a=$$(ls "$$f") ; \
	b=$$(grep '@prefix :' "$$f" | cut -c 12- | rev | cut -c 5- | rev) ; \
	[ "$$a" == "$$b" ] || \
	{ echo "$$a has an incorrect : prefix" ; exit 1 ; } ; done

check_turtle_syntax:
	riot -q --validate cases/*/*.ttl

check_cases: check_prefixes check_turtle_syntax

watch:
	ls edtfo.ttl | entr make -s

serve: | $(PYTHON)
	$(PYTHON) -m http.server -b 127.0.0.1 -d doc/html

clean:
	rm -rf $(VENV_DIR) doc/html/index.html

.PHONY: check_prefixes check_turtle_syntax watch serve clean
