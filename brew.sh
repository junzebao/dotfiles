/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
/opt/homebrew/bin/brew shellenv zsh
echo >> /Users/junze/.zprofile & echo 'eval "$(/opt/homebrew/bin/brew shellenv zsh)"' >> /Users/junze/.zprofile & eval "$(/opt/homebrew/bin/brew shellenv zsh)"
brew install neovim
brew install zoxide

brew install zsh-autosuggestions
echo "source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc

brew install starship
echo 'eval "\$(starship init zsh)"' >> ~/.zshrc

brew tap michel-kraemer/zsh-patina && brew install zsh-patina
echo 'eval "\$($(brew --prefix)/bin/zsh-patina activate)"' >> ~/.zshrc

brew install fzf
echo 'source <(fzf --zsh)' >> ~/.zshrc

