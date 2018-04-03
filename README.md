# Setup

1.  Clone repo:

    ```bash
    git clone git@github.com:jipolanco/dotnvim.git ~/.config/nvim
    ```

1.  To use with (regular) vim:

    ```bash
    ln -s ~/.config/nvim ~/.vim
    ```

1.  Install [plug.vim](https://github.com/junegunn/vim-plug):

    ```bash
    curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    ```

1.  Install plugins:

    ```bash
    vim +PlugInstall
    ```
