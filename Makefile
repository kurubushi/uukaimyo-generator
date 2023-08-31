.PHONY: fmt prepare all install uninstall clean check

prefix = $(HOME)/.local
exec_prefix = $(prefix)
bindir = $(exec_prefix)/bin

INSTALL = install
INSTALL_PROGRAM = $(INSTALL) -Dm 755
INSTALL_DATA = $(INSTALL) -Dm 644

APP_HS_FILES = $(shell find app -type f -name "*.hs")
SRC_HS_FILES = $(shell find src -type f -name "*.hs")
GHC_VERSION = 9.2.8
CABAL_VERSION = 3.6.2.0

fmt:
	cabal-fmt -i *.cabal
	stylish-haskell -ri $(APP_HS_FILES) $(SRC_HS_FILES)

prepare:
	ghcup install ghc $(GHC_VERSION)
	ghcup install cabal $(CABAL_VERSION)

uukaimyogen: $(APP_HS_FILES) $(SRC_HS_FILES)
	cabal update
	cabal build -w ghc-$(GHC_VERSION)
	cabal install \
		--enable-executable-static \
		--enable-executable-stripping \
		--installdir=. \
		--install-method=copy \
		--overwrite-policy=always \
		exe:uukaimyogen

all: install

install: uukaimyogen
	$(INSTALL_PROGRAM) uukaimyogen $(bindir)/uukaimyogen

uninstall:
	rm -f $(bindir)/uukaimyogen

clean:
	rm -f uukaimyogen

check:
	cabal test
