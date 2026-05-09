#!/usr/bin/env bash

if [ -z "$DOTFILES_DIR" ]; then
  echo "Set \$DOTFILES_DIR"
  exit 1
fi

for file in $(ls "$DOFILES_DIR" | grep -v 'setup.sh'); do
  ln -sf "$DOTFILES_DIR/$file" "$HOME/.$file"
  echo "Linking $HOME/.$file"
done

ln -sf "$DOTFILES_DIR/ghostty" "$HOME/.config/ghostty"
ln -sf "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
