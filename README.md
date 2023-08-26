# UUKaimyo generator

## install

Download a binary file from [releases](https://github.com/kurubushi/uukaimyo-generator/releases) or build with GHCup.

## build

Install [GHCup](https://www.haskell.org/ghcup/) and then build `uukaimyogen` and install it to `$HOME/.cabal/bin/uukaimyogen`:

```bash
# install ghc and cabal with GHCup to build the command line tool
make prepare

# install the command line tool to $HOME/.local/bin
make install

# remove the command line tool
make uninstall
```

## usages

```
$ uukaimyogen
畏柱院謄誘恵営徒科糧掛埼措居士

$ uukaimyogen -s
UUID: 3dfb5785-ba3a-4b68-88ff-72f623bebdb1
依酔院超享対旅妊斜負岸架疾居士

$ uuidgen | uukaimyougen -c
一紙院渡墨宝裸礁乳無日潤凡居士

$ uukaimyogen -f
悪道院塾街項詰誰習殉丁撃怒大姉
```
