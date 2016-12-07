.PHONY: help install

help: ### show this help
	@cat $(MAKEFILE_LIST) | perl -nle 'm/\A([^\t][^:]+?):.*?### *(.*)\z/ and printf "%-10s %s\n", $$1, $$2'

VIMRC=~/.vimrc
VIMDIR=~/.vim
COLORSDIR=$(VIMDIR)/colors
SYNTAXDIR=$(VIMDIR)/syntax
AFTERDIR=$(VIMDIR)/after
AFTERSYNTAXDIR=$(AFTERDIR)/syntax
AFTERSYNTAXSCHEMEDIR=$(AFTERSYNTAXDIR)/scheme

$(VIMRC):
	ln -sf $(CURDIR)/vimrc $@

$(VIMDIR):
	test -d $@ || mkdir $@

$(COLORSDIR): $(VIMDIR)
	test -d $@ || mkdir $@
$(COLORSDIR)/molokai.vim: $(COLORSDIR)
	wget -q -O $@ https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim

$(SYNTAXDIR): $(VIMDIR)
	test -d $@ || mkdir $@

$(AFTERDIR): $(VIMDIR)
	test -d $@ || mkdir $@
$(AFTERSYNTAXDIR): $(AFTERDIR)
	test -d $@ || mkdir $@
$(AFTERSYNTAXSCHEMEDIR): $(AFTERSYNTAXDIR)
	test -d $@ || mkdir $@
$(AFTERSYNTAXSCHEMEDIR)/gauche.vim: $(AFTERSYNTAXSCHEMEDIR)
	ln -sf $(CURDIR)/after/syntax/gauche.vim $@
$(AFTERSYNTAXSCHEMEDIR)/gauche-keywords.vim: $(AFTERSYNTAXSCHEMEDIR)
	ln -sf $(CURDIR)/after/syntax/gauche-keywords.vim $@

FILES=\
	  $(VIMRC) \
	  $(COLORSDIR)/molokai.vim \
	  $(AFTERSYNTAXSCHEMEDIR)/gauche.vim \
	  $(AFTERSYNTAXSCHEMEDIR)/gauche-keywords.vim \

install: $(FILES) ### setup vim config
