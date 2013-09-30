#!/bin/bash

git config --global user.name sammei
git config --global user.email sammei@wondermedia.com.cn
git config --global core.edit vim
git config --global merge.tool meld
git config --global color.ui auto 

git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status

if [ -f git-completion.bash ]; then
		cp git-completion.bash ~/.git-completion.bash
		echo "" >> ~/.bashrc
		echo ". ~/.git-completion.bash" >> ~/.bashrc
		. ~/.bashrc
fi

exit

