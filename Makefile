CC=fpc
CFLAGS=
F=src/inno-cli

all: clear compile

clear:
	rm -rf $(F)
compile:
	$(CC) $(CFLAGS) $(F).pas

