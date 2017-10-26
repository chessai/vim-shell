with import <nixpkgs> {};
let
  myVim = pkgs.vim_configurable.customize {
    name = "vim";
    vimrcConfig.customRC = builtins.readFile ./vimrc;
    
    vimrcConfig.packages.myVimPackage = with pkgs.vimPlugins; {
        start = [

        ];

    };
  };
in
{
  name = "vim-shell";
  buildInputs = [ myVim ];
  shellHook = ''
    alias vi = vim
  '';
  EDITOR = "vim"
}
