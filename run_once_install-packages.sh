#!/bin/sh

# exist checks if a command exist in shell
exist() {
  command -v "$1" >/dev/null 2>&1
}

# log writes message to stdout with a timestamp in blue
log() {
  printf "\033[33;34m [%s] %s\n" "$(date)" "$1"
}

if [ -n "$CODESPACES" ]; then
  log "Exit. Skip run_once_install for codespaces."
  exit
fi

log "Running run_once_install-packages.sh once..."

# Install Homebrew
# https://brew.sh/
if exist brew; then
  log "Updating Homebrew..."
  brew update
else
  log "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install zsh
# https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH#how-to-install-zsh-on-many-platforms
brew install zsh --quiet

# Install Oh My Zsh
# https://ohmyz.sh/#install
if ! [ -d ~/.oh-my-zsh ]; then
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

source ~/.zshrc

# Install zsh-autosuggestions
# https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions 2>/dev/null

# Install zsh-syntax-highlighting
# https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md#oh-my-zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting 2>/dev/null

# Install starship
brew install starship --quiet

source ~/.zshrc

# Install fzf
# https://github.com/junegunn/fzf#using-homebrew
brew install fzf

# Install fd
# https://github.com/sharkdp/fd#on-macos
brew install fd --quiet

# Install bat
# https://github.com/sharkdp/bat#on-macos-or-linux-via-homebrew
brew install bat --quiet

# Install ripgrep
# https://github.com/BurntSushi/ripgrep#installation
brew install ripgrep --quiet

# Install rich
# https://github.com/Textualize/rich-cli#macos
brew install rich --quiet

# Install ydiff
# https://github.com/ymattw/ydiff#install-with-homebrew
brew install ydiff --quiet

# Install lsd
# https://github.com/lsd-rs/lsd
brew install lsd --quiet

# Install pass
# https://www.passwordstore.org/
brew install pass --quiet

# Install nvim
# https://formulae.brew.sh/formula/neovim
brew install neovim --quiet

# Install Mise on place
brew install mise --quiet

# Install git delta
brew install git-delta --quiet

# Install git extras
brew install git-extras --quiet

brew install fastfetch --quiet

# Install jetbreains mono nerd font
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono-nerd-font

# Install Fira Code
# https://github.com/tonsky/FiraCode/wiki/Installing
# brew tap homebrew/cask-fonts
# brew install --cask font-fira-code

# Install tldr
# https://github.com/tldr-pages/tldr#how-do-i-use-it
brew install tldr --quiet

log "Done. Please restart your shell."
