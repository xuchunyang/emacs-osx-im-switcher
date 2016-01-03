# The root path of Emacs repository
ROOT ?= $(HOME)/wip/emacs

CC      = clang
LD      = clang
CFLAGS  = -ggdb3 -Wall -fPIC
LDFLAGS = -framework Carbon -framework Foundation

all: osx-im.so

%.so: %.o
	$(LD) -shared $(LDFLAGS) -o $@ $<

%.o: %.m
	$(CC) $(CFLAGS) -I$(ROOT)/src -fPIC -c $<
