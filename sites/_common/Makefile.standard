.PHONY: help setup

help: ### show this help
	@cat $(MAKEFILE_LIST) | perl -nle 'm/\A([^\t][^:]+?):.*?### *(.*)\z/ and printf "%-10s %s\n", $$1, $$2'


setup: ### recursively setup configs
	make -C vim $@
	make -C zsh $@
