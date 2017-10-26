# vim-shell

This is a nix expression that is useful when editing remote files with vim. It enables you to use your customised vim without affecting the host vim configuration. Using it is simple:

## 1. Copy your current vimrc into vimrc. 
## 2. In 'start = [ ];', in vim-shell.nix, add any plugins that you wish to use, separated by spaces or newlines.
## 3. Drop this file into a directory, and in that same directory, run:
```sh
$ nix-shell
```
This will run your customised vim inside of a nix-shell.
