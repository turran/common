if ENS_BUILD_DOC
if ENS_BUILD_ENDER

ender: doxygen
	xsltproc --param lib "'enesim'" --param version 0 --param case "'underscore'" ../ender/tools/fromdoxygen.xslt doc/xml/Enesim_8h.xml > out.xml

endif
endif
