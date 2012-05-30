am__tar = tar chof - "$$tardir"
SCRIPTS := $(shell echo openstack-*)

all:


install:
	install -m755 $(SCRIPTS) "$(DESTDIR)/usr/bin"


uninstall:
	for script in $(SCRIPTS); do rm -f "$(DESTDIR)/usr/bin/$${script}"; done


dist: dist-gzip


dist-gzip:
	tardir=$(shell basename "$(PWD)") && cd .. && $(am__tar) | gzip -c > "$${tardir}.tar.gz"
