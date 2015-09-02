#/bin/bash
wget -O .bashrc https://raw.githubusercontent.com/snorrej/configs/master/.bashrc
wget -O .bash-preexec.sh https://raw.githubusercontent.com/snorrej/configs/master/.bash-preexec.sh
wget -O .bash_profile https://raw.githubusercontent.com/snorrej/configs/master/.bash_profile
wget -O .tmux.conf https://raw.githubusercontent.com/snorrej/configs/master/.tmux.conf
wget -O .screenrc https://raw.githubusercontent.com/snorrej/configs/master/.screenrc

if [ -e .screenrc-tabs ] ; then
  wget -O .screenrc-tabs https://raw.githubusercontent.com/snorrej/configs/master/.screenrc-tabs
fi
