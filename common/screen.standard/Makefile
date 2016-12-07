.PHONY: help install always

help: ### show this help
	@cat $(MAKEFILE_LIST) | perl -nle 'm/\A([^\t][^:]+?):.*?### *(.*)\z/ and printf "%-10s %s\n", $$1, $$2'

SCREENRC=~/.screenrc

$(SCREENRC): always
	ln -sf $(CURDIR)/screenrc $@

FILES=\
	$(SCREENRC) \

install: $(FILES) ### setup screen config
