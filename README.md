# Dotfiles

## Symlinks

Run the following commands to create symbolic links for the configuration files:

```zsh
echo "Removing existing config files and creating symlinks..." && \
rm -f ~/.zshrc ~/.zsh-nvm.zsh ~/.config/tmux ~/.config/ghostty && \
echo "Creating symlinks..." && \
ln -s ~/dotfiles/.zshrc ~/.zshrc && \
ln -s ~/dotfiles/.zsh-nvm.zsh ~/.zsh-nvm.zsh && \
ln -s ~/dotfiles/.config/tmux ~/.config/tmux && \
ln -s ~/dotfiles/.config/ghostty ~/.config/ghostty
```
