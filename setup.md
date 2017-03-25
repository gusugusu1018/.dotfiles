# zsh
```
sudo apt install git vim zsh tmux tree sl
# ascii art
sudo apt install figlet
which zsh
chsh
cd
curl -sL zplug.sh/installer | zsh
```
# vim
```
curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > install.sh
sh ./install.sh
vim hoge
:NeoBundleInstall
rm hoge
```
# .dotfiles
```
sh ~/.dotfiles/ln.sh
```
# anyenv
```
git clone https://github.com/riywo/anyenv ~/.anyenv
exec $SHELL -l
```
# pyenv
not on tmux
```
anyenv install -l
anyenv install pyenv
exec $SHELL -l
pyenv install 3.3.3
pyenv install 2.7.6
pyenv global 3.3.3
```
# virtualenv
```
anyenv versions
git clone https://github.com/yyuu/pyenv-virtualenv.git ~/.anyenv/envs/pyenv/plugins/pyenv-virtualenv

```
# reference
* [zshの設定ファイルの読み込み順序と使い方Tipsまとめ](http://qiita.com/muran001/items/7b104d33f5ea3f75353f)
* [とりあえずZshを使えば良いんだろう？](http://qiita.com/ktr_type23/items/3eb782f98c7a5f4c60b0)
* [Vim pluginへの入門 NeoBundle.vim](http://qiita.com/okamos/items/caf5a0b19ce893a75363)
* [anyenvで開発環境を整える](http://qiita.com/luckypool/items/f1e756e9d3e9786ad9ea)
* [pyenvとvirtualenvで環境構築](http://qiita.com/Kodaira_/items/feadfef9add468e3a85b)
* [anyenv環境でpyenvインストール後にハマったのでメモ](http://qiita.com/dodo5522/items/8e9e63d8c94a70fbbbb9)
* [ターミナルマルチプレクサ tmux をカスタマイズする](http://qiita.com/b4b4r07/items/01359e8a3066d1c37edc)

# trouble
* tmuxが起動しなかった場合、/tmp/内のセッションをrm -rfすればよい。

