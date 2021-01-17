.PHONY: help install FORCE

help: ### show this help
	@cat $(MAKEFILE_LIST) | perl -nle 'm/\A([^\t][^:]+?):.*?### *(.*)\z/ and printf "%-10s %s\n", $$1, $$2'

MAKEQ=$(MAKE) --no-print-directory

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

$(VIMRC): FORCE
	ln -sf $(CURDIR)/vimrc $@

$(VIMDIR):
	test -d $@ || mkdir $@

$(AUTOLOADDIR):
	$(MAKEQ) $(VIMDIR)
	test -d $@ || mkdir $@

$(BUNDLEDIR):
	$(MAKEQ) $(VIMDIR)
	test -d $@ || mkdir $@

$(BUNDLEDIR)/pathogen:
	$(MAKEQ) $(BUNDLEDIR)
	git clone https://github.com/tpope/vim-pathogen.git $@

$(BUNDLEDIR)/syntastic:
	$(MAKEQ) $(BUNDLEDIR)
	git clone --depth=1 https://github.com/vim-syntastic/syntastic.git $@

$(BUNDLEDIR)/ale:
	$(MAKEQ) $(BUNDLEDIR)
	git clone --depth 1 https://github.com/dense-analysis/ale.git $@

$(BUNDLEDIR)/rust.vim:
	$(MAKE) $(BUNDLEDIR)
	git clone --depth=1 https://github.com/rust-lang/rust.vim.git $@

$(BUNDLEDIR)/elm-vim:
	$(MAKE) $(BUNDLEDIR)
	git clone --depth=1 https://github.com/ElmCast/elm-vim.git $@

$(COLORSDIR):
	$(MAKEQ) $(VIMDIR)
	test -d $@ || mkdir $@
$(COLORSDIR)/inkpot.vim:
	$(MAKEQ) $(COLORSDIR)
	wget -q -O $@ 'https://raw.githubusercontent.com/ciaranm/inkpot/master/colors/inkpot.vim'
$(COLORSDIR)/jellybeans.vim:
	$(MAKEQ) $(COLORSDIR)
	wget -q -O $@ 'https://raw.githubusercontent.com/nanotech/jellybeans.vim/master/colors/jellybeans.vim'
$(COLORSDIR)/molokai.vim:
	$(MAKEQ) $(COLORSDIR)
	wget -q -O $@ 'https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim'
$(COLORSDIR)/mirodark.vim:
	$(MAKEQ) $(COLORSDIR)
	wget -q -O $@ 'https://github.com/djjcast/mirodark/raw/master/colors/mirodark.vim'
$(COLORSDIR)/wombat256mod.vim:
	$(MAKEQ) $(COLORSDIR)
	wget -q -O $@ 'http://www.vim.org/scripts/download_script.php?src_id=13400'
$(COLORSDIR)/zenburn.vim:
	$(MAKEQ) $(COLORSDIR)
	wget -q -O $@ 'http://www.vim.org/scripts/download_script.php?src_id=15530'

$(SYNTAXDIR):
	$(MAKEQ) $(VIMDIR)
	test -d $@ || mkdir $@

$(AFTERDIR):
	$(MAKEQ) $(VIMDIR)
	test -d $@ || mkdir $@
$(AFTERSYNTAXDIR):
	$(MAKEQ) $(AFTERDIR)
	test -d $@ || mkdir $@
$(AFTERSYNTAXSCHEMEDIR):
	$(MAKEQ) $(AFTERSYNTAXDIR)
	test -d $@ || mkdir $@
$(AFTERSYNTAXSCHEMEDIR)/gauche.vim: FORCE
	$(MAKEQ) $(AFTERSYNTAXSCHEMEDIR)
	ln -sf $(CURDIR)/after/syntax/scheme/gauche.vim $@
$(AFTERSYNTAXSCHEMEDIR)/gauche-keywords.vim: FORCE
	$(MAKEQ) $(AFTERSYNTAXSCHEMEDIR)
	ln -sf $(CURDIR)/after/syntax/scheme/gauche-keywords.vim $@

$(BUNDLEDIR)/syntastic/plugin/syntastic.vim: FORCE
	$(MAKEQ) $(BUNDLEDIR)/syntastic
	cd $(BUNDLEDIR)/syntastic && git pull

$(BUNDLEDIR)/ale/plugin/ale.vim: FORCE
	$(MAKEQ) $(BUNDLEDIR)/ale
	cd $(BUNDLEDIR)/ale && git pull

$(BUNDLEDIR)/rust.vim/plugin/rust.vim: FORCE
	$(MAKEQ) $(BUNDLEDIR)/rust.vim
	cd $(BUNDLEDIR)/rust.vim && git pull

$(BUNDLEDIR)/elm-vim/plugin/elm.vim: FORCE
	$(MAKEQ) $(BUNDLEDIR)/elm-vim
	cd $(BUNDLEDIR)/elm-vim && git pull

$(SYNCHKDIR):
	$(MAKEQ) $(VIMDIR)
	test -d $@ || mkdir $@
$(SYNCHKSCHEMEDIR):
	$(MAKEQ) $(SYNCHKDIR)
	test -d $@ || mkdir $@
$(SYNCHKSCHEMEDIR)/gauche.vim: FORCE
	$(MAKEQ) $(SYNCHKSCHEMEDIR)
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
	  $(BUNDLEDIR)/ale/plugin/ale.vim \
	  $(BUNDLEDIR)/syntastic/plugin/syntastic.vim \
	  $(BUNDLEDIR)/rust.vim/plugin/rust.vim \
	  $(SYNCHKSCHEMEDIR)/gauche.vim \

install: $(FILES) ### setup vim config
