SHELL=/bin/bash
UNAME := $(shell uname)

.PHONY: main

ifeq ($(UNAME), Linux)
main: config/git install/py install/nerdfonts install/fzf install/nvim install/docker install/compose
install/nvim:
	sudo apt-get install fuse libfuse2 git python3-pip ack-grep -y
	wget --quiet https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage --output-document nvima
	chmod +x nvima
	sudo mv nvima /usr/bin/nvim
	pip3 install neovim
	pip2 install neovim
install/py:
	sudo apt-get install -y python3-pip
	sudo apt-get install -y python-pip
install/nerdfonts:
	sudo apt-get install -y fonts-powerline
	mkdir -p ~/.local/share/fonts
	cd ~/.local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
install/fzf:
	cd ~ && git clone --depth 1 https://github.com/junegunn/fzf.git
	~/fzf/install
install/docker:
	sudo apt-get remove docker docker-engine docker.io
	sudo apt-get update
	sudo apt-get install \
	  apt-transport-https \
	  ca-certificates \
	  curl \
	  gnupg2 \
	  software-properties-common
	curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
	sudo add-apt-repository \
		   "deb [arch=amd64] https://download.docker.com/linux/debian \
		   stretch \
		   stable"
	sudo apt-get update
	sudo apt-get install docker-ce
install/compose:
	sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(shell uname -s)-$(shell uname -m)" -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose
config/git:
	git config --global user.email "salah@bernstein.io"
	git config --global user.name "Salah Saleh"
else
install/nvim:
	brew install neovim
install/fzf:
	brew install fzf
endif
