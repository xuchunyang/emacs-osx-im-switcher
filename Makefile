# The root path of Emacs repository
ROOT = $(HOME)/wip/emacs

CC      = gcc
LD      = gcc
CFLAGS  = -ggdb3 -Wall
LDFLAGS =

all: osx-im.so

%.so: %.o
	$(LD) -shared $(LDFLAGS) -o $@ $<

%.o: %.m
	$(CC) $(CFLAGS) -I$(ROOT)/src -fPIC -c $<
