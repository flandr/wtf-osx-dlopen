CC ?= gcc

PLATFORM := $(shell uname -s)
ifeq ($(PLATFORM),Linux)
DYLIB = so
else
DYLIB = dylib
endif

all: libfoo.$(DYLIB) libfakefoo.$(DYLIB) main

%.o: %.c
	@echo + cc $@
	@$(CC) -fPIC -o $@ -c $^

libfoo.$(DYLIB): foo.o
	@echo + ld $@
	@$(CC) -shared -o $@ $^

libfakefoo.$(DYLIB): fakefoo.o
	@echo + ld $@
	@$(CC) -shared -o $@ $^

main: main.c
	@echo + cc $@
	@$(CC) -o $@ $^ -ldl

clean:
	@echo + clean
	@rm -f *.o *.$(DYLIB) main
