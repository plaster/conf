.PHONY: help setup

help: ### show this help
	@cat $(MAKEFILE_LIST) | perl -nle 'm/\A([^\t][^:]+?):.*?### *(.*)\z/ and printf "%-10s %s\n", $$1, $$2'

setup: ### setup .vimrc
	ln -sf $(CURDIR)/vimrc ~/.vimrc
	test -d ~/.vim || mkdir ~/.vim
	ln -snf $(CURDIR)/syntax ~/.vim/syntax
