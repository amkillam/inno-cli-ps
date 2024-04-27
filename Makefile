CC=fpc
CFLAGS=-Fisrc -FUbuild -Xt -XS -Cn -Ur -FEbuild -Sh -I./src/include/pascalscript/Source/ -I./src -O3 -Fusrc/include/pascalscript/Source/ -v0 -ve
AR=ar
F=InnoCli
FPCVER=$(shell fpc -iV)
ifdef OS
	RMDIR = del /Q /S
	MKBUILDDIR = if not exist build mkdir build
	LIB=inno-cli.lib
	ifndef ($(ARCH))
		ARCH=$(shell fpc -iSP)
	endif
	ifndef ($(TARGET_OS))
		ifeq ($(ARCH),i386)
			TARGET_OS=win32
		else
			TARGET_OS=win64
		endif
	endif
	ifndef ($(FPCLIB))
		FPCLIB=C:\FPC\$(FPCVER)\units\$(ARCH)-$(TARGET_OS)
	endif
	FPC_RTL_LIBS=$(FPCLIB)\rtl\sysinitpas.o \
	$(FPCLIB)\rtl\system.o \
	$(FPCLIB)\rtl\cmem.o \
	$(FPCLIB)\rtl\fpintres.o \
	$(FPCLIB)\rtl\objpas.o \
	$(FPCLIB)\rtl\classes.o \
	$(FPCLIB)\rtl\sysutils.o \
	$(FPCLIB)\rtl\rtlconsts.o \
	$(FPCLIB)\rtl\types.o \
	$(FPCLIB)\rtl\typinfo.o \
	$(FPCLIB)\rtl\windows.o \
	$(FPCLIB)\rtl\sysconst.o \
	$(FPCLIB)\rtl\windirs.o \
	$(FPCLIB)\rtl\math.o \
	$(FPCLIB)\rtl-objpas\variants.o \
	$(FPCLIB)\winunits-base\activex.o \
	$(FPCLIB)\rtl-objpas\varutils.o \
	$(FPCLIB)\rtl\ctypes.o \
	$(FPCLIB)\winunits-base\comobj.o \
	$(FPCLIB)\winunits-base\comconst.o \
	$(FPCLIB)\winunits-base\ole2.o \
	$(FPCLIB)\fcl-registry\registry.o \
	$(FPCLIB)\fcl-base\inifiles.o \
	$(FPCLIB)\fcl-base\contnrs.o
else
	RMDIR = rm -rf
	MKBUILDDIR = mkdir -p build
	LIB=libinno-cli.a
	ifndef ($(ARCH))
		ARCH=$(shell fpc -iTP)
	endif
	ifndef ($(TARGET_OS))
		TARGET_OS=$(shell uname -s | tr '[:upper:]' '[:lower:]')
	endif
	ifndef ($(FPCLIB))
		FPCLIB=/usr/lib/fpc/$(FPCVER)/units/$(ARCH)-$(TARGET_OS)
	endif
	ifndef ($(GCCLIB))
		GCCLIB=/usr/lib/gcc/$(shell gcc -dumpmachine)/$(shell gcc -dumpversion)
	endif
	ifndef ($(LIBDIR))
		ifeq ((ARCH),i386)
			LIBDIR=/usr/lib
		else
			LIBDIR=/usr/lib64
		endif
	endif
	FPC_RTL_LIBS=$(LIBDIR)/crti.o \
	$(LIBDIR)/crtn.o \
	$(GCCLIB)/crtbeginS.o \
	$(FPCLIB)/rtl/si_dll.o \
	$(FPCLIB)/rtl/system.o \
	$(FPCLIB)/rtl/cmem.o \
	$(FPCLIB)/rtl/objpas.o \
	$(FPCLIB)/rtl/classes.o \
	$(FPCLIB)/rtl/sysutils.o \
	$(FPCLIB)/rtl/types.o \
	$(FPCLIB)/rtl/typinfo.o \
	$(FPCLIB)/rtl/rtlconsts.o \
	$(FPCLIB)/rtl/linux.o \
	$(FPCLIB)/rtl/unix.o \
	$(FPCLIB)/rtl/errors.o \
	$(FPCLIB)/rtl/sysconst.o \
	$(FPCLIB)/rtl/unixtype.o \
	$(FPCLIB)/rtl/baseunix.o \
	$(FPCLIB)/rtl/unixutil.o \
	$(FPCLIB)/rtl/math.o \
	$(FPCLIB)/rtl-objpas/variants.o \
	$(FPCLIB)/rtl-objpas/varutils.o
endif

LOCAL_OBJS = build/InnoCli.o build/GenerateExec.o build/uPSUtils.o build/uPSRuntime.o

all: clean compile link
.NOTPARALLEL:

clean:
	$(RMDIR) build
compile:
	$(MKBUILDDIR)
	$(CC) $(CFLAGS) src/$(F).pas
link:

	$(AR) rcs build/$(LIB) $(LOCAL_OBJS) $(FPC_RTL_LIBS)
