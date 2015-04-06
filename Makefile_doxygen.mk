
.PHONY: doxygen

PACKAGE_DOCNAME = $(PACKAGE_TARNAME)-$(PACKAGE_VERSION)-doc

if ENS_BUILD_DOC

doxygen-clean:
	rm -rf doc/html/ doc/latex/ doc/man/ doc/xml/ $(PACKAGE_DOCNAME).tar*

doxygen: doxygen-clean
	$(ens_doxygen) $(srcdir)/doc/Doxyfile
	cp $(srcdir)/doc/img/* doc/html/ || true
	cp $(srcdir)/doc/img/* doc/latex/ || true
	rm -rf $(PACKAGE_DOCNAME).tar*
	mkdir -p $(PACKAGE_DOCNAME)/doc
	cp -R doc/html/ doc/latex/ doc/man/ doc/xml $(PACKAGE_DOCNAME)/doc
	tar cf $(PACKAGE_DOCNAME).tar $(PACKAGE_DOCNAME)/
	bzip2 -9 $(PACKAGE_DOCNAME).tar
	rm -rf $(PACKAGE_DOCNAME)/

else

doxygen-clean:

doxygen:
	@echo "Documentation not built. Run ./configure --help"

endif

