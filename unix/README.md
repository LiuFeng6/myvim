#  写一个unix版的vim优化

## 安装vim

```shell
sudo add-apt-repository ppa:jonathonf/vim 
sudo apt-get update  
sudo apt install vim 
vim --version
```

## 安装插件管理[vim-plug](https://github.com/junegunn/vim-plug) 

```shell
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

## 编辑.vimrc

```shell
call plug#begin()

Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()
```

`:PlugInstall`

## 安装[coc](https://github.com/neoclide/coc.nvim)

#### 先安装 node

1. 安装node版本管理工具

```shell
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
```

```bash
nvm list-remote
nvm install latest
nvm install vX.Y.Z
nvm alias default vX.Y.Z
nvm alias default v16.20.0
node -v
```

#### 后安装coc

设置coc

```bash
let g:coc_global_extensions = ['coc-vimlsp', 'coc-clangd', 'coc-pyright', 'coc-markdownlint']
```

