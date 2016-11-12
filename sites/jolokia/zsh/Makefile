.PHONY: help setup

help: ### show this help
	@cat $(MAKEFILE_LIST) | perl -nle 'm/\A([^\t][^:]+?):.*?### *(.*)\z/ and printf "%-10s %s\n", $$1, $$2'

setup: ### setup .zshrc
	ln -sf $(CURDIR)/zshrc ~/.zshrc
