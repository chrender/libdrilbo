
include ../../config.mk

ifneq ($(ENABLE_GDB_SYMBOLS),)
override CFLAGS += -g
endif

ifneq ($(ENABLE_OPTIMIZATION),)
override CFLAGS += -O2
endif


.PHONY : clean

all: libdrilbo_locales.o


libdrilbo_locales.o: libdrilbo_locales.c
	$(CC) $(CFLAGS) -I$(FIZMO_INC_DIR) -c libdrilbo_locales.c

clean:
	rm -f *.o

