.PHONY: help install always

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
	wget -q -O $@ 'https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim'
$(COLORSDIR)/zenburn.vim: $(COLORSDIR)
	wget -q -O $@ 'http://www.vim.org/scripts/download_script.php?src_id=15530'

$(SYNTAXDIR): $(VIMDIR)
	test -d $@ || mkdir $@

$(AFTERDIR): $(VIMDIR)
	test -d $@ || mkdir $@
$(AFTERSYNTAXDIR): $(AFTERDIR)
	test -d $@ || mkdir $@
$(AFTERSYNTAXSCHEMEDIR): $(AFTERSYNTAXDIR)
	test -d $@ || mkdir $@
$(AFTERSYNTAXSCHEMEDIR)/gauche.vim: $(AFTERSYNTAXSCHEMEDIR) always
	ln -sf $(CURDIR)/after/syntax/gauche.vim $@
$(AFTERSYNTAXSCHEMEDIR)/gauche-keywords.vim: $(AFTERSYNTAXSCHEMEDIR) always
	ln -sf $(CURDIR)/after/syntax/gauche-keywords.vim $@

FILES=\
	  $(VIMRC) \
	  $(COLORSDIR)/molokai.vim \
	  $(COLORSDIR)/zenburn.vim \
	  $(AFTERSYNTAXSCHEMEDIR)/gauche.vim \
	  $(AFTERSYNTAXSCHEMEDIR)/gauche-keywords.vim \

install: $(FILES) ### setup vim config
