SHELL=/bin/bash
UNAME := $(shell uname)

.PHONY: main

ifeq ($(UNAME), Linux)

main: install/other install/stackdriver install/tmux config/git install/py install/nerdfonts \
	install/fzf install/nvim install/docker install/compose config/docker install/heroku \
	install/postgresql
install/dev:
	-cd ~ && git clone git@github.com:bernstein-io/lightdev.git
	cd ~/lightdev && make
monitor:
	chmod u+x monitor.sh
	sudo cp monitor.sh /usr/local/bin/
	sudo cp monitor.service /etc/systemd/system/
	sudo systemctl start monitor
install/other:
	sudo apt-get install -y mailutils ruby-full
install/heroku:
	curl https://cli-assets.heroku.com/install-ubuntu.sh | sh
install/postgresql:
	sudo apt-get install postgresql
install/light-dev:
	cd ~ && git clone git@github.com:bernstein-io/lightdev.git
install/stackdriver:
	curl -sSO https://dl.google.com/cloudagents/install-monitoring-agent.sh
	sudo bash install-monitoring-agent.sh
	curl -sSO https://dl.google.com/cloudagents/install-logging-agent.sh
	sudo bash install-logging-agent.sh
	rm install-logging-agent.sh
	rm install-monitoring-agent.sh
install/tmux:
	sudo apt-get install -y tmux
	tmux new -s main -d
	ln -s .config/.tmux.conf ~/.tmux.config
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
	sudo apt-get install silversearcher-ag
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
config/docker:
	-sudo groupadd docker
	sudo usermod -aG docker $(USER)
	sudo systemctl restart docker
config/git:
	git config --global user.email "salah@bernstein.io"
	git config --global user.name "Salah Saleh"
	git config --global pull.rebase true
	git config --global pull.rebase true
	git config --global core.ignorecase false
	git config --global push.followTags true
	git config --global push.default current
	git config --global alias.lg "log --graph --abbrev-commit --oneline --decorate --format=format:'%C(bold blue)%h%C(reset) %C(bold green)%ar%C(reset)%C(auto)%d%C(reset) %C(white)%s%C(reset)%C(dim white) %an%C(reset)' --all"
	git config --global core.editor "nvim"

else

install/nvim:
	brew install neovim
	brew tap caskroom/fonts
	brew cask install font-hack-nerd-font
install/fzf:
	brew install fzf

endif
