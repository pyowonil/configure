PERL := perl
PREFIX := /usr/local/bin
TARGET := configure

all: build

build: $(TARGET)

$(TARGET): configure.pl
	cp configure.pl $(TARGET)
	chmod +x $(TARGET)

clean:
	rm $(TARGET)

install: build
	cp $(TARGET) $(PREFIX)/$(TARGET)

uninstall:
	rm $(PREFIX)/$(TARGET)

.PHONY: FORCE
FORCE:
