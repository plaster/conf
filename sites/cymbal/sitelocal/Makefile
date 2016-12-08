.PHONY: help install always

help: ### show this help
	@cat $(MAKEFILE_LIST) | perl -nle 'm/\A([^\t][^:]+?):.*?### *(.*)\z/ and printf "%-10s %s\n", $$1, $$2'

~/.zshrc-prompt-color: always
	ln -sf $(CURDIR)/zshrc-prompt-color $@

FILES=\
	~/.zshrc-prompt-color \

install: $(FILES) ### setup sitelocal files
