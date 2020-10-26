YELLOW=\033[1;33m
NC=\033[0m # No Color

.PHONY: setup

setup:	
	@echo "${YELLOW}>> Linking vim dotfiles${NC}";
	ln -sf ~/.vim/src/vimrc ~/.vimrc;
	@echo "${YELLOW}>> Linking init.vim${NC}";
	ln -sf ~/.vim/src/vimrc ~/.vim/init.vim;
	@echo "${YELLOW}>> Creating backup directories${NC}";
	mkdir ~/.vim/swap
	mkdir ~/.vim/undo
	mkdir ~/.vim/backup
	@echo "${YELLOW}>> Installing plugins${NC}";
	vim +PlugInstall +qall
	@echo "${YELLOW}>> Installing ripgrep via brew (assumes macOS)${NC}";
	brew install ripgrep
	@echo "${YELLOW}>> Configuring fzf to use ripgrep (assumes zsh)${NC}";
	touch ~/.zshrc
	# echo "\n# Configure fzf to use ripgrep by default" >> ~/.zshrc
	# echo "export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'" >> ~/.zshrc
	# source ~/.zshrc
clean:
	@echo "${YELLOW}>> Removing swap directory${NC}";
	rm -rf ~/.vim/swap
	@echo "${YELLOW}>> Removing undo directory${NC}";
	rm -rf ~/.vim/undo
	@echo "${YELLOW}>> Removing backup directory${NC}";
	rm -rf ~/.vim/backup
	@echo "${YELLOW}>> Removing plugins${NC}";
	rm -rf ~/.vim/plugged
	@echo "${YELLOW}>> Removing plugged${NC}";
	rm -rf ~/.vim/autoload/plug.vim
	@echo "${YELLOW}>> Removing init.vim${NC}";
	rm ~/.vim/init.vim
	@echo "${YELLOW}>> WARNING: fzf configuration in ~/.zshrc needs to be removed manually${NC}";
