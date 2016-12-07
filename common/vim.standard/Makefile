.PHONY: help install colorschemes

help: ### show this help
	@cat $(MAKEFILE_LIST) | perl -nle 'm/\A([^\t][^:]+?):.*?### *(.*)\z/ and printf "%-10s %s\n", $$1, $$2'

VIMDIR=~/.vim
COLORSDIR=$(VIMDIR)/colors

$(VIMDIR):
	test -d $@ || mkdir $@

$(COLORSDIR): $(VIMDIR)
	test -d $@ || mkdir $@

$(COLORSDIR)/molokai.vim: $(COLORSDIR)
	wget -q -O $@ https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim

colorschemes: $(COLORSDIR)/molokai.vim

install: $(VIMDIR) colorschemes ### setup vim config
	ln -sf $(CURDIR)/vimrc ~/.vimrc
	test -d $(VIMDIR) || mkdir $(VIMDIR)
	ln -snf $(CURDIR)/syntax $(VIMDIR)/syntax
	ln -snf $(CURDIR)/after $(VIMDIR)/after
