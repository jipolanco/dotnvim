# C/C++

## cquery

<https://github.com/jacobdufault/cquery>

<https://github.com/autozimu/LanguageClient-neovim/wiki/cquery>

Build:

    git clone https://github.com/jacobdufault/cquery --single-branch
    cd cquery
    git submodule update --init

    # Note: by default, a version of clang+llvm compiled for Ubuntu is downloaded.
    # However, a version compiled for Fedora is also available on the llvm site.
    # Thus, modify the value of `CLANG_TARBALL_NAME` in `wscript` to:
    #   CLANG_TARBALL_NAME = 'clang+llvm-$version-x86_64-linux-gnu-Fedora27'

    ./waf configure --prefix ~/opt/cquery
    ./waf build -j4
    ./waf install

## clangd

<https://clang.llvm.org/extra/clangd.html>

Included in clang 5+.

Set path to `clangd` binary in `g:LanguageClient_serverCommands`.

# Julia

<https://github.com/JuliaEditorSupport/LanguageServer.jl>

<https://github.com/JuliaEditorSupport/LanguageServer.jl/wiki/Neovim>

# Python

<https://github.com/palantir/python-language-server>

## Installation

    pip install python-language-server
    pip install pyls-mypy  # optional

or, with Anaconda:

    conda install python-language-server
