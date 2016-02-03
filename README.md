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
    curl -fLo ~/.nvim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    ```

1.  Install plugins:

    ```bash
    vim +PlugInstall
    ```

1.  Compile YouCompleteMe. See
    [here](https://github.com/Valloric/YouCompleteMe/blob/master/README.md) for
    instructions, or:

    ```bash
    cd ~/.nvim/plugged/YouCompleteMe/
    mkdir build
    cd build
    cmake ../third_party/ycmd/cpp -DUSE_SYSTEM_LIBCLANG=ON \
        -DUSE_SYSTEM_BOOST=ON -DUSE_CLANG_COMPLETER=ON
    make ycm_support_libs
    ```
