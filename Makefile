SHELL=/bin/bash
UNAME := $(shell uname)

.PHONY: main start

main: start

ifeq ($(UNAME), Linux)
install/nvim:
	sudo apt-get install fuse libfuse2 git python3-pip ack-grep -y
	wget --quiet https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage --output-document nvima
	chmod +x nvima
	sudo mv nvima /usr/bin/nvim
	# sudo apt-get install -y neovim
	# pip3 install neovim
	# pip2 install neovim
install/py:
	sudo apt-get install -y python3-pip
	sudo apt-get install -y python-pip
install/nerdf:
	sudo apt-get install -y fonts-powerline
	mkdir -p ~/.local/share/fonts
	cd ~/.local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
install/fzf:
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/
	~/.fzf/install
else
install/nvim:
	brew install neovim
install/fzf:
	brew install fzf
endif
