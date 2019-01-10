# This is my environment
  * zsh
    * zplug
      * zsh-users/zsh-autosuggestions
      * zsh-users/zsh-completions
      * tcnksm/docker-alias
  * vim
    * neobundle
      * Shougo/vimproc
      * Shougo/neocomplete.vim
      * Townk/vim-autoclose
      * ekalinin/Dockerfile.vim
      * rcmdnk/vim-markdown
  * tmux
  * fzf
  * anyenv
    * pyenv
      * virtualenv
      * anaconda
  * docker

## Nvidia-driver and CUDA-10.0 setup

```
sudo apt-get update
sudo apt-get upgrade
```

[リンク](https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&target_distro=Ubuntu&target_version=1604&target_type=deblocal)からdebファイルをダウンロード。  
ただし、nvidiaのアカウントが必要。  

```
sudo sh -c "echo 'blacklist nouveau' >> /etc/modprobe.d/blacklist-nouveau.conf"
sudo sh -c "echo 'options nouveau modeset=0' >>/etc/modprobe.d/blacklist-nouveau.conf"
sudo dpkg -i cuda-repo-ubuntu1604-10-0-local-10.0.130-410.48_1.0-1_amd64.deb
udo apt-key add /var/cuda-repo-10-0-local-10.0.130-410.48/7fa2af80.pub
sudo apt-get update
sudo apt-get install cuda

```

もしdpkgに失敗した時は
```
sudo dpkg -r cuda-repo-ubuntu1604
```

## Install git
```
sudo apt install git
```
## zsh
```
sudo apt install zsh
which zsh
chsh
cd
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
# ascii art
sudo apt install figlet
```

## vim
```
sudo apt install vim
curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > install.sh

sh ./install.sh
vim hoge
:NeoBundleInstall
rm hoge
```

## tmux
```
sudo apt install tmux
```

## fzf
```
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

## anyenv
```
git clone https://github.com/riywo/anyenv ~/.anyenv
exec $SHELL -l
```

## pyenv
Install requirements
```
sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils
```
not on tmux
```
anyenv install -l
anyenv install pyenv
exec $SHELL -l
pyenv install 3.3.3
pyenv install 2.7.6
pyenv global 3.3.3
```

## virtualenv
```
anyenv versions
git clone https://github.com/yyuu/pyenv-virtualenv.git ~/.anyenv/envs/pyenv/plugins/pyenv-virtualenv
```

```
pyenv virtualenv 3.3.3 virtural-3.3.3
# change directory you like
pyenv local virtual-3.3.3
```

## opencv @python
```
pyenv install anaconda-2.1.0
pyenv virtualenv anaconda-2.1.0 virtual-conda-2.1.0
pyenv versions
# change directory you like
pyenv local virtual-conda-2.1.0
conda install -c https://conda.binstar.org/jjhelmus opencv
```

## .dotfiles
```
git clone https://github.com/minaminoki/.dotfiles.git ~/.dotfiles
# ascii art
sudo apt install figlet
chmod +x ~/.dotfiles/ln.sh
sh ~/.dotfiles/ln.sh
source ~/.zshrc
```

## docker
[official site for docker install](https://docs.docker.com/engine/installation/linux/ubuntu/)
```
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository    "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install docker-ce
apt-cache madison docker-ce
```
if want to remove sudo
```
cat /etc/group | grep docker
sudo groupadd docker
sudo gpasswd -a $USER docker
sudo reboot
```

## How to update Git
```
sudo apt-get install git
git version
sudo add-apt-repository ppa:git-core/ppa
sudo apt-get update
sudo apt-get upgrade
```

## Install all requirements of packages
```
sudo apt install git zsh vim tmux tree figlet sl make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils apt-transport-https ca-certificates curl software-properties-common
```

# reference
* [zshの設定ファイルの読み込み順序と使い方Tipsまとめ](http://qiita.com/muran001/items/7b104d33f5ea3f75353f)
* [とりあえずZshを使えば良いんだろう？](http://qiita.com/ktr_type23/items/3eb782f98c7a5f4c60b0)
* [Vim pluginへの入門 NeoBundle.vim](http://qiita.com/okamos/items/caf5a0b19ce893a75363)
* [anyenvで開発環境を整える](http://qiita.com/luckypool/items/f1e756e9d3e9786ad9ea)
* [pyenvとvirtualenvで環境構築](http://qiita.com/Kodaira_/items/feadfef9add468e3a85b)
* [anyenv環境でpyenvインストール後にハマったのでメモ](http://qiita.com/dodo5522/items/8e9e63d8c94a70fbbbb9)
* [ターミナルマルチプレクサ tmux をカスタマイズする](http://qiita.com/b4b4r07/items/01359e8a3066d1c37edc)
* [zshでvim+Tabでエラーになる時の対処法](http://qiita.com/Asuforce/items/28b287fdb933d1985e15)
* [Dockerコマンドをsudoなしで実行する方法](http://qiita.com/DQNEO/items/da5df074c48b012152ee)
* [GitHub pyenv-virtualenv](https://github.com/pyenv/pyenv-virtualenv)

# trouble
* tmuxが起動しなかった場合、/tmp/内のセッションをrm -rfすればよい。もしくは、デフォルトシェルが間違っているため、.tmux.confの2行目を修正する。
* vimコマンド時のファイル名tab補完でエラーが出るとき、以下のコマンドで解決
  ```
   rm .zcompdump
   rm .zplug/zcompdump
   exec $SHELL -l
  ```
