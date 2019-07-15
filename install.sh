chsh -s /bin/zsh

# enter in git config
read -p "Enter git email: " git_email
read -p "Enter git display name: " git_display_name
read -p "Continue with $git_email ? (Y/N)" confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1

# set git config file
cat <<EOF > ./dotfiles/git/gitconfig
[user]
  email = $git_email
  name = $git_display_name
[color]
  diff = true
  ui = true
[push]
  default = simple
[core]
  excludesfile = ./dotfiles/git/gitignore
[init]
  templatedir = ./.git_template
[rebase]
  autoStash = true
[core]
  pager = diff-so-fancy | less --tabs=4 -RFX
[pager]
  diff = diff-so-fancy | less --tabs=1,5 -RFX
  show = diff-so-fancy | less --tabs=1,5 -RFX
[color "diff-highlight"]
  oldNormal = red bold
  oldHighlight = red bold 52
  newNormal = green bold
  newHighlight = green bold 22
[color "diff"]
  meta = yellow
  frag = magenta bold
  commit = yellow bold
  old = red bold
  new = green bold
  whitespace = red reverse
[color]
  ui = true
[merge]
  tool = nvimdiff4
[mergetool "nvimdiff4"]
  cmd = nvim -d \$LOCAL \$REMOTE \$MERGED -c '\$wincmd w' -c 'wincmd J'
; [mergetool "nfugitive"]
;   cmd = nvim -f -c "Gdiff" "\$MERGED"
[diff]
  tool = nvimdiff2
[difftool "nvimdiff2"]
  cmd = nvim -d \$LOCAL \$REMOTE
EOF

# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install Homebrew apps and utils
brew tap Homebrew/bundle
brew bundle

mkdir -p "$HOME/.config"

# link files
ln -s ./dotfiles/vim ~/.config/nvim
ln -s ./dotfiles/git/gitignore ~/.gitignore
ln -s ./dotfiles/ssh/config ~/.ssh/config

