#
# $Id: makefile,v 1.5 2004-11-19 15:09:43 dds Exp $
#

VERSION=1.23
BINARY=outwit-bin-$(VERSION).zip
BINDIR=outwit-bin-$(VERSION)
SOURCE=outwit-src-$(VERSION).zip
SRCDIR=outwit-src-$(VERSION)
WEB=/dds/pubs/web/home/sw/outwit
ZIP=zip
PROGS=docprop odbc readlink winclip winreg readlog

all:
	cd winclip ; nmake ; make doc
	cd odbc ;  nmake ; make doc
	cd docprop ; nmake /f docprop.mak CFG="docprop - Win32 Release" ; make doc
	cd winreg ; nmake /f winreg.mak CFG="winreg - Win32 Release" ; make doc
	cd readlink ; nmake ; make doc
	cd readlog ; nmake ; make doc

clearweb:
	rm -rf $(WEB)
	mkdir $(WEB)

web: clearweb exezip sourcezip
	sed "s/VERSION/$(VERSION)/g" websrc/index.html >$(WEB)/index.html
	cp websrc/outwit.jpg $(WEB)
	for i in $(PROGS) ; do \
		cp $$i/$$i.html $(WEB) ; \
		cp $$i/$$i.pdf $(WEB) ; \
	done
	cp ChangeLog.txt $(WEB)
	cp $(BINARY) $(WEB)/$(BINARY)
	cp $(SOURCE) $(WEB)/$(SOURCE)

install:
	cp docprop/release/docprop.exe /usr/bin
	cp odbc/odbc.exe /usr/bin
	cp readlink/readlink.exe /usr/bin
	cp readlog/readlog.exe /usr/bin
	cp winclip/winclip.exe /usr/bin
	cp winreg/release/winreg.exe /usr/bin

exezip:
	rm -f $(BINARY)
	-cmd /c rd /s/q $(BINDIR)
	mkdir $(BINDIR)
	mkdir $(BINDIR)/doc $(BINDIR)/bin
	mkdir $(BINDIR)/doc/txt $(BINDIR)/doc/html $(BINDIR)/doc/pdf
	cp docprop/release/docprop.exe \
	 odbc/odbc.exe readlink/readlink.exe winclip/winclip.exe \
	 winreg/release/winreg.exe readlog/readlog.exe \
	 $(BINDIR)/bin
	cp ChangeLog.txt $(BINDIR)
	for i in $(PROGS) ; do \
		cp $$i/$$i.txt $(BINDIR)/doc/txt ; \
		cp $$i/$$i.html $(BINDIR)/doc/html ; \
		cp $$i/$$i.pdf $(BINDIR)/doc/pdf ; \
	done
	zip -r $(BINARY) $(BINDIR)
	-cmd /c rd /s/q $(BINDIR)

sourcezip:
	rm -f $(SOURCE)
	-cmd /c rd /s/q $(SRCDIR)
	mkdir $(SRCDIR)
	sh -c "tar -cf - {docprop,odbc,readlink,winclip,winreg,readlog}/makefile */*.[1ch] */*.mak */*.cpp ChangeLog.txt | tar -C $(SRCDIR) -xf -"
	zip -r $(SOURCE) $(SRCDIR)
	-cmd /c rd /s/q $(SRCDIR)
