CC=fpc
CFLAGS=-Fisrc  -FUbuild -Xt -Xs -Cn -FEbuild -I./src/include/pascalscript/Source/ -I./src -O3 -Fusrc/include/pascalscript/Source/ -v0 -ve 
AR=ar
F=src/InnoCli
LIB=libinno-cli
OBJS:=$(wildcard build/*.o)
ifdef OS
	RMDIR = del /Q /S
	MKBUILDDIR = if not exist build mkdir build
else
	RMDIR = rm -rf
	MKBUILDDIR = mkdir -p build
endif

all: clean compile link
.NOTPARALLEL:

clean:
	$(RMDIR) build
compile:
	$(MKBUILDDIR)
	$(CC) $(CFLAGS) $(F).pas
link:
	$(AR) rcs build/$(LIB).a $(OBJS)

