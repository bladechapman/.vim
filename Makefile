YELLOW=\033[1;33m
NC=\033[0m # No Color

.PHONY: setup

setup:	
	@echo "${YELLOW}>> Linking vim dotfiles${NC}";
	ln -sf ~/.vim/.vimrc ~/.vimrc;
	ln -sf ~/.vim/.gvimrc ~/.gvimrc;
	@echo "${YELLOW}>> Creating backup directories${NC}";
	mkdir ~/.vim/swap
	mkdir ~/.vim/undo
	mkdir ~/.vim/backup
	@echo "${YELLOW}>> Make sure fzf is installed for fzf.vim${NC}"
	@echo "${YELLOW}>> Make sure to select a powerline font for vim-airline (only if you intend on using the terminal a lot)${NC}";
	@echo "${YELLOW}>> MacVim or vimR (neovim) is recommended (for font separation from your terminal)${NC}"
	@echo "${YELLOW}>> If using vimR, make sure to install python support for YouCompleteMe${NC}"
	git submodule foreach git pull origin master
clean:
	@echo "${YELLOW}>> Removing swap directory${NC}"
	rm -rf ~/.vim/swap
	@echo "${YELLOW}>> Removing undo directory${NC}"
	rm -rf ~/.vim/undo
	@echo "${YELLOW}>> Removing backup directory${NC}"
	rm -rf ~/.vim/backup

