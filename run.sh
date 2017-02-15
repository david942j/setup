#!/bin/bash
cd $HOME
filedir="$HOME/setup/files"
usage() {
  echo "$0 <basic|tools|adv>"
  echo "Remember to run apt-get update/upgrade first."
  exit 3
}
copy() {
  cp -r "$filedir/$1" "$2"
}

copy_if_ne() {
  if [ ! -f $2 ]; then
    copy $1 $2
  else
    echo "File $PWD/$2 exists."
  fi 
}

install() {
  if [ $(dpkg-query -W -f='${Status}' $1 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
    sudo apt-get -y install $1
  fi
}

pip_install() {
  pip show -q $1
  if [ "$?" -eq 0 ]; then
    return
  fi
  pip install $1
}

gem_install() {
  if [ "`gem list -i $1`" = "false" ]; then
    gem install $1
  fi
}
basic() {
# vim
  install vim
  copy_if_ne .vimrc .vimrc
  install curl
# oh-my-zsh
  install zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  copy_if_ne johnson.zsh-theme "$HOME/.oh-my-zsh/themes"
  copy .zshrc .zshrc
# tmux
  install tmux
  copy_if_ne .tmux.conf .tmux.conf
}

install_python() {
  curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash
  pyenv install 2.7.13
  pyenv global 2.7.13
}

install_ruby() {
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  cd ~/.rbenv && src/configure && make -C src && cd -
  git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
  install libreadline-dev
  rbenv install 2.3.3
  rbenv global 2.3.3
  source ~/.zshrc
}

tools() {
  install gcc
  install g++
  install make
  install libssl-dev
# gdb
  install gdb
  git clone https://github.com/longld/peda.git ~/peda
  copy .gdb .
  copy .gdbinit .
# python tools
  install_python
  pip_install ipython
  pip_install pwntools
# ruby
  install_ruby
# ruby tools
  gem_install pry
  gem_install heapinfo
  gem_install pwntools
  gem_install one_gadget
}

adv() {
  echo "TODO"
}
if [ "$#" -ne 1 ]; then
  usage
fi
if [ $1 = "basic" ]; then
  basic
elif [ $1 = "tools" ]; then
  tools
elif [ $1 = "adv" ]; then
  adv
else
  usage
fi

