.PHONY: help install always

help: ### show this help
	@cat $(MAKEFILE_LIST) | perl -nle 'm/\A([^\t][^:]+?):.*?### *(.*)\z/ and printf "%-10s %s\n", $$1, $$2'

SCREENRC=~/.screenrc
SCREEN256BIN=/opt/screen256/bin/screen

$(SCREENRC): always
	ln -sf $(CURDIR)/screenrc $@

$(SCREEN256BIN):
	sudo $(CURDIR)/setup.screen256bin

FILES=\
	$(SCREENRC) \
	$(SCREEN256BIN) \

install: $(FILES) ### setup screen config
