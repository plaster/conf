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

$(COLORSDIR):
	$(MAKE) $(VIMDIR)
	test -d $@ || mkdir $@
$(COLORSDIR)/inkpot.vim:
	$(MAKE) $(COLORSDIR)
	wget -q -O $@ 'https://raw.githubusercontent.com/ciaranm/inkpot/master/colors/inkpot.vim'
$(COLORSDIR)/jellybeans.vim:
	$(MAKE) $(COLORSDIR)
	wget -q -O $@ 'https://raw.githubusercontent.com/nanotech/jellybeans.vim/master/colors/jellybeans.vim'
$(COLORSDIR)/molokai.vim:
	$(MAKE) $(COLORSDIR)
	wget -q -O $@ 'https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim'
$(COLORSDIR)/mirodark.vim:
	$(MAKE) $(COLORSDIR)
	wget -q -O $@ 'https://github.com/djjcast/mirodark/raw/master/colors/mirodark.vim'
$(COLORSDIR)/zenburn.vim:
	$(MAKE) $(COLORSDIR)
	wget -q -O $@ 'http://www.vim.org/scripts/download_script.php?src_id=15530'

$(SYNTAXDIR):
	$(MAKE) $(VIMDIR)
	test -d $@ || mkdir $@

$(AFTERDIR):
	$(MAKE) $(VIMDIR)
	test -d $@ || mkdir $@
$(AFTERSYNTAXDIR):
	$(MAKE) $(AFTERDIR)
	test -d $@ || mkdir $@
$(AFTERSYNTAXSCHEMEDIR):
	$(MAKE) $(AFTERSYNTAXDIR)
	test -d $@ || mkdir $@
$(AFTERSYNTAXSCHEMEDIR)/gauche.vim: always
	$(MAKE) $(AFTERSYNTAXSCHEMEDIR)
	ln -sf $(CURDIR)/after/syntax/scheme/gauche.vim $@
$(AFTERSYNTAXSCHEMEDIR)/gauche-keywords.vim: always
	$(MAKE) $(AFTERSYNTAXSCHEMEDIR)
	ln -sf $(CURDIR)/after/syntax/scheme/gauche-keywords.vim $@

FILES=\
	  $(VIMRC) \
	  $(COLORSDIR)/inkpot.vim \
	  $(COLORSDIR)/jellybeans.vim \
	  $(COLORSDIR)/molokai.vim \
	  $(COLORSDIR)/mirodark.vim \
	  $(COLORSDIR)/zenburn.vim \
	  $(AFTERSYNTAXSCHEMEDIR)/gauche.vim \
	  $(AFTERSYNTAXSCHEMEDIR)/gauche-keywords.vim \

install: $(FILES) ### setup vim config
