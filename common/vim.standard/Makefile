.PHONY: help install

help: ### show this help
	@cat $(MAKEFILE_LIST) | perl -nle 'm/\A([^\t][^:]+?):.*?### *(.*)\z/ and printf "%-10s %s\n", $$1, $$2'

install: ### setup vim config
	ln -sf $(CURDIR)/vimrc ~/.vimrc
	test -d ~/.vim || mkdir ~/.vim
	ln -snf $(CURDIR)/syntax ~/.vim/syntax
	ln -snf $(CURDIR)/after ~/.vim/after
