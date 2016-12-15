.PHONY: help install always

help: ### show this help
	@cat $(MAKEFILE_LIST) | perl -nle 'm/\A([^\t][^:]+?):.*?### *(.*)\z/ and printf "%-10s %s\n", $$1, $$2'

VIMRC=~/.vimrc
VIMDIR=~/.vim
AUTOLOADDIR=$(VIMDIR)/autoload
SYNCHKDIR=$(VIMDIR)/syntax_checkers
SYNCHKSCHEMEDIR=$(SYNCHKDIR)/scheme
BUNDLEDIR=$(VIMDIR)/bundle
COLORSDIR=$(VIMDIR)/colors
SYNTAXDIR=$(VIMDIR)/syntax
AFTERDIR=$(VIMDIR)/after
AFTERSYNTAXDIR=$(AFTERDIR)/syntax
AFTERSYNTAXSCHEMEDIR=$(AFTERSYNTAXDIR)/scheme

$(VIMRC): always
	ln -sf $(CURDIR)/vimrc $@

$(VIMDIR):
	test -d $@ || mkdir $@

$(AUTOLOADDIR):
	$(MAKE) $(VIMDIR)
	test -d $@ || mkdir $@

$(BUNDLEDIR):
	$(MAKE) $(VIMDIR)
	test -d $@ || mkdir $@

$(BUNDLEDIR)/pathogen:
	$(MAKE) $(BUNDLEDIR)
	git clone https://github.com/tpope/vim-pathogen.git $@

$(BUNDLEDIR)/syntastic:
	$(MAKE) $(BUNDLEDIR)
	git clone --depth=1 https://github.com/vim-syntastic/syntastic.git $@

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
$(COLORSDIR)/wombat256mod.vim:
	$(MAKE) $(COLORSDIR)
	wget -q -O $@ 'http://www.vim.org/scripts/download_script.php?src_id=13400'
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

$(AUTOLOADDIR)/pathogen.vim: always
	$(MAKE) $(AUTOLOADDIR)
	$(MAKE) $(BUNDLEDIR)/pathogen
	cd $(BUNDLEDIR)/pathogen && git pull
	ln -sf $(BUNDLEDIR)/pathogen/autoload/pathogen.vim $@

$(BUNDLEDIR)/syntastic/plugin/syntastic.vim: always
	$(MAKE) $(BUNDLEDIR)/syntastic
	cd $(BUNDLEDIR)/syntastic && git pull

$(SYNCHKDIR):
	$(MAKE) $(VIMDIR)
	test -d $@ || mkdir $@
$(SYNCHKSCHEMEDIR):
	$(MAKE) $(SYNCHKDIR)
	test -d $@ || mkdir $@
$(SYNCHKSCHEMEDIR)/gauche.vim: always
	$(MAKE) $(SYNCHKSCHEMEDIR)
	ln -sf $(CURDIR)/syntax_checkers/scheme/gauche.vim $@

FILES=\
	  $(VIMRC) \
	  $(COLORSDIR)/inkpot.vim \
	  $(COLORSDIR)/jellybeans.vim \
	  $(COLORSDIR)/molokai.vim \
	  $(COLORSDIR)/mirodark.vim \
	  $(COLORSDIR)/wombat256mod.vim \
	  $(COLORSDIR)/zenburn.vim \
	  $(AFTERSYNTAXSCHEMEDIR)/gauche.vim \
	  $(AFTERSYNTAXSCHEMEDIR)/gauche-keywords.vim \
	  $(AUTOLOADDIR)/pathogen.vim \
	  $(BUNDLEDIR)/syntastic/plugin/syntastic.vim \
	  $(SYNCHKSCHEMEDIR)/gauche.vim \

install: $(FILES) ### setup vim config
