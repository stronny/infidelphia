ME := infidelphia
LIBS := dsl util
PREFIX ?= /usr/local
BIN := ${PREFIX}/bin
LIB := ${PREFIX}/lib/${ME}
SHARE := ${PREFIX}/share/${ME}

.PHONY: all install uninstall

all: install

install:
	install -d ${BIN} ${LIB} ${SHARE}
	install -m 0755 -t ${BIN} src/${ME}
	(cd src/lib && install -m 0644 -t ${LIB} ${LIBS})
	install -m 0644 -t ${SHARE} LICENSE README.txt

uninstall:
	rm ${BIN}/${ME}
	rm ${SHARE}/LICENSE ${SHARE}/README.txt
	(cd ${LIB} && rm ${LIBS})
	rmdir ${LIB} ${SHARE}
