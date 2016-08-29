#!/bin/bash
cd $HOME
filedir="$HOME/setup/files"
usage() {
	echo "$0 <basic|tools|adv>"
	echo "Remember to run apt-get update/upgrade first."
	exit 3
}
copy() {
	cp "$filedir/$1" "$2"
}

copy_if_ne() {
  if [ ! -f $2 ]; then
    copy $1 $2
  else
    echo "File $PWD/$2 exists."
  fi 
}
install() {
	dpkg -l $1 2>&1 > /dev/null
	if [ "$?" -eq 0 ]; then
		return
	fi
	apt-get -y install $1
}
basic() {
# vim
	install vim
	copy_if_ne .vimrc .vimrc
	install ruby2.3
	install curl
# oh-my-zsh
	install zsh
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  copy_if_ne johnson.zsh-theme "$HOME/.oh-my-zsh/themes"
	perl -i -pe's/="robbyrussell/="johnson/g' "$HOME/.zshrc"
# tmux
	install tmux
  copy_if_ne .tmux.conf .tmux.conf
}

tools() {
  install gcc
  install g++
  install pip
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

