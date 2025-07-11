prefix = /usr/local
bindir = $(prefix)/bin
datarootdir = $(prefix)/share
player = $(shell logname)

all:
	gcc pacman.c     -o pacman     -DDATAROOTDIR=\"$(datarootdir)\"  $(CFLAGS) $(LDFLAGS) -lncurses
	gcc pacmanedit.c -o pacmanedit -DDATAROOTDIR=\"$(datarootdir)\"  $(CFLAGS) $(LDFLAGS) -lncurses

install: all
	sudo mkdir -p $(bindir)
	sudo cp pacman $(bindir)
	sudo cp pacmanedit $(bindir)
	sudo mkdir -p $(datarootdir)/pacman
	sudo cp -fR Levels/ $(datarootdir)/pacman/
	sudo chown root:$(player) $(bindir)/pacman
	sudo chown -R root:$(player) $(datarootdir)/pacman
	sudo chmod 750 $(bindir)/pacman
	sudo chmod 750 $(bindir)/pacmanedit
	sudo chmod -R 750 $(datarootdir)/pacman/

uninstall:
	sudo rm -f $(bindir)/pacman
	sudo rm -f $(bindir)/pacmanedit
	if [[ -e $(datarootdir)/pacman/ ]]; then sudo rm -rf $(datarootdir)/pacman/; fi

clean:
	rm -f pacman
	rm -f pacmanedit
