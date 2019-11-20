PROGS = find xargs

all: $(PROGS:%=build-%)

install: $(PROGS:%=install-%)

clean: $(PROGS:%=clean-%)
	$(RM) pwcache.o

build-%: %
	@$(MAKE) -C $<

install-%: %
	@$(MAKE) -C $< install DESTDIR='$(shell test -n '$(DESTDIR)' && realpath '$(DESTDIR)')'

clean-%: %
	@$(MAKE) -C $< clean

pwcache.o: pwcache.c
	$(CC) $(CFLAGS) $(shell pkg-config --cflags --libs libbsd-overlay) -D_PW_BUF_LEN=1024 -D_GR_BUF_LEN=2624 -c $< -o $@
