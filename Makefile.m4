
`#' vim: ft=make noexpandtab
divert(-1)
define(`liba', `lib$1.a')
define(`libsoa', `lib$1.so')
define(`linka', `-l$1')
define(`chka', `chk$1')
define(`testa', `test_$1')
divert(0)
BINDIR := bin
OBJDIR := obj

OBJECTS := $(OBJDIR)/src/template.o
OBJECTS_TESTS := \
	$(OBJDIR)/tests/check.o \
	$(OBJDIR)/tests/chka(template).o

MD=mkdir -v -p

CFLAGS := -Wall -Werror

testa(template): LDFLAGS += $(shell pkg-config --libs check) -L$(BINDIR)/static/ linka(template)
testa(template): CFLAGS += -DCHECK -g

all: $(BINDIR)/static/liba(template) $(BINDIR)/shared/libsoa(template) testa(template)

testa(template): $(BINDIR)/static/liba(template) $(OBJECTS_TESTS)
	$(MD) $(dir $@)
	$(CC) -o $@ $^ $(LDFLAGS)

$(BINDIR)/static/liba(template): $(OBJECTS)
	$(MD) $(dir $@)
	$(AR) rcs $@ $^

$(BINDIR)/shared/libsoa(template): $(OBJECTS)
	$(MD) $(dir $@)
	$(CC) -shared -o $@ $^

$(OBJDIR)/%.o: %.c
	$(MD) $(dir $@)
	$(CC) -c -o $@ $(CFLAGS) $<

.PHONY: clean

clean:
	rm -rf $(OBJDIR); \
	rm -f testa(template); \
	rm -rf $(BINDIR)

