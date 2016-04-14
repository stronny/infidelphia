SHELL=/usr/bin/env bash
ME := infidelphia
LIBS := version dsl util main release release_distro daemon_update daemon_import
PREFIX ?= /usr/local
BIN := ${PREFIX}/bin
LIB := ${PREFIX}/lib
SHARE := ${PREFIX}/share
DEB := ${PWD}/deb

.PHONY: all install uninstall deb

all: install

install:
	install -d ${BIN} ${LIB}/${ME} ${SHARE}/${ME}
	install -m 0755 -t ${BIN} bin/${ME}
	cd lib/${ME} && install -m 0644 -t ${LIB}/${ME} ${LIBS}
	install -m 0644 -t ${SHARE}/${ME} LICENSE README.txt

uninstall:
	rm ${BIN}/${ME}
	cd ${SHARE}/${ME} && rm LICENSE README.txt
	cd ${LIB}/${ME} && rm ${LIBS}
	rmdir --ignore-fail-on-non-empty ${LIB}/${ME} ${LIB} ${SHARE}/${ME} ${SHARE} ${BIN} ${PREFIX}

deb:
	env
	PREFIX=${DEB}/usr $(MAKE)
	install -d ${DEB}/DEBIAN ${DEB}/etc/bash_completion.d
	source lib/${ME}/version && export VERSION && envsubst < control > ${DEB}/DEBIAN/control
	install -m 0644 bash_completion ${DEB}/etc/bash_completion.d/${ME}
	dpkg-deb --build ${DEB} .
	rm ${DEB}/DEBIAN/control ${DEB}/etc/bash_completion.d/${ME}
	rmdir --ignore-fail-on-non-empty ${DEB}/DEBIAN ${DEB}/etc/bash_completion.d ${DEB}/etc
	PREFIX=${DEB}/usr $(MAKE) uninstall
	rmdir --ignore-fail-on-non-empty ${DEB}
