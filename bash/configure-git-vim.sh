# configure git

echo '************************'
echo '*   User git config    *'
echo '************************'

git config --global user.name 'jacques-navarro'
git config --global user.email '4421229+jacques-navarro@users.noreply.github.com'

echo ''
git config --list
echo ''

# install vim-plug

echo '************************'
echo '*   Install vim-plug   *'
echo '************************'

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install yegappan/lsp plugin

echo '************************'
echo '*  Install LSP plugin  *'
echo '************************'

mkdir -p ~/.vim/pack/downloads/opt
cd ~/.vim/pack/downloads/opt
git clone https://github.com/yegappan/lsp
vim -u NONE -c "helptags ~/.vim/pack/downloads/opt/lsp/doc" -c q
# chown -R ubuntu:ubuntu /home/ubuntu/.vim

# copy .vimrc to home directory

echo '************************'
echo '*     Copy .vimrc      *'
echo '************************'

cd $HOME
cp ~/vim/vim-vimrc/.vimrc /home/ubuntu
# chown -R ubuntu:ubuntu /home/ubuntu/.vimrc

# generate ssh key

echo '************************'
echo '*   Generate SSH key   *'
echo '************************'

echo -e "\n\n\n" | ssh-keygen -t ed25519 -C "4421229+jacques-navarro@users.noreply.github.com" -N "" -f ~/.ssh/id_ed25519
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub
