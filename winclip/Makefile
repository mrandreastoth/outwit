NAME=winclip
SSH=plink

winclip.exe: winclip.c getopt.c imageload.cpp lang.h
	cl /EHsc winclip.c getopt.c imageload.cpp user32.lib shell32.lib gdi32.lib WindowsCodecs.lib

lang.h: lang.pl
	/usr/bin/perl $? '/cygdrive/c/Program Files (x86)/Microsoft SDKs/Windows/v7.0A/include/WinNT.h' >$@


drop2txt.exe: drop2txt.c
	cl drop2txt.c user32.lib shell32.lib

doc: $(NAME).ps $(NAME).txt $(NAME).pdf $(NAME).html

$(NAME).ps: $(NAME).1
	groff -man -Tps <$? > $@

$(NAME).txt: $(NAME).1
	groff -man -Tascii <$? | col -b > $@

$(NAME).pdf: $(NAME).ps
	ps2pdf $? $@

$(NAME).html: $(NAME).1
	groff -mhtml -Thtml -man <$? | sed -e 's/&minus;/-/g;s/&bull;/\&#8226;/g' >$@
#	man2html $? | sed '1d;s,<A HREF="http.*</A>,,;s/^,$$/man2html,/' > $@

zip:
	z -a winclip winclip.c winclip.exe winclip.man winclip.1 makefile
