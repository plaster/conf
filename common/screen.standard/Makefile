.PHONY: help install

help: ### show this help
	@cat $(MAKEFILE_LIST) | perl -nle 'm/\A([^\t][^:]+?):.*?### *(.*)\z/ and printf "%-10s %s\n", $$1, $$2'

install: ### setup screen config
	ln -sf $(CURDIR)/screenrc ~/.screenrc
