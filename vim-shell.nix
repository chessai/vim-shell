with import <nixpkgs> {};
let
  myVim = pkgs.vim_configurable.customize {
    name = "vim";
    vimrcConfig.customRC = ''
      set nocompatible
      syntax on
      set hidden
      set wildmenu
      set showcmd
      set hlsearch
      set ignorecase
      set smartcase
      set backspace=indent,eol,start
      set autoindent
      set ruler
      set laststatus=2
      set confirm
      set visualbell
      set number
      set notimeout ttimeout ttimeoutlen=200
      set pastetoggle=<F2>
      set shiftwidth=2
      set shiftround
      set softtabstop=4
      set expandtab
      map Y y$
      nnoremap <C-L> :nohl<CR><C-L>
      let mapleader = ","
      cmap w!! w !sudo tee % >/dev/null
      set t_Co=256
      colorscheme colorful256
      
      au VimEnter * RainbowParenthesesToggle
      au Syntax * RainbowParenthesesLoadRound
      au Syntax * RainbowParenthesesLoadSquare
      au Syntax * RainbowParenthesesLoadBraces

      map <Leader>s :SyntasticToggleMode<CR>
      let g:syntastic_always_populate_loc_list = 1
      let g:syntastic_auto_loc_list = 1
      let g:syntastic_check_on_open = 1
      let g:syntastic_check_on_wq = 0

      set autoread
      au FocusGained,BufEnter * :silent! !
      map <silent> tw :GhcModTypeInsert<CR>
      map <silent> ts :GhcModSplitFunCase<CR>
      map <silent> tq :GhcModType<CR>
      map <silent> te :GhcModTypeClear<CR>
      map <silent> tc :GhcModCheck<CR>

      " autocmd FileType rust :packadd rust-vim
      " autocmd FileType haskell :packadd ghc-mod
      " autocmd FileType haskell :packadd neco-ghc
      " autocmd FileType nix :packadd vim-nix
      
      let g:NERDSpaceDelims = 1
      let g:NERDCompactSexyComs = 1
      let g:NERDTrimTrailingWhitespace = 1

      let g:SuperTabDefaultCompletionType = '<c-x><c-o>'

      if has("gui_running")
        imap <c-space> <c-r>=SuperTabAlternateCompletion("\<lt>c-x>\<lt>c-o>")<cr>
      else " no gui
        if has("unix")
          inoremap <Nul> <c-r>=SuperTabAlternateCompletion("\<lt>c-x>\<lt>c-o>")<cr>
        endif
      endif

      let g:haskellmode_completion_ghc = 1
      autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

      map <Leader>n :NERDTreeToggle<CR>

      let g:haskell_tabular = 1

      vmap a= :Tabularize /=<CR>
      vmap a; :Tabularize /::<CR>
      vmap a- :Tabularize /-><CR>

      map <silent> <Leader>t :CtrlP()<CR>
      noremap <leader>b<space> :CtrlPBuffer<cr>
      let g:ctrlp_custom_ignore = '\v[\/]dist$'
      
      " Do not create swap files in same directory as files I edit.
      " The double slash at the end is important. It tells vim to
      " recreate the entire directory leading up to the file. This
      " prevents collisions
      " set backupdir=~/.vim/backup_files//
      " set directory=~/.vim/swap_files//
      " set undodir=~/.vim/undo_files//
    '';

    vimrcConfig.packages.myVimPackage = with pkgs.vimPlugins; {
        start = [
          vim-colorschemes 
          rainbow_parentheses
          syntastic
          vimproc
          ctrlp
          neocomplete
          The_NERD_Commenter
          The_NERD_tree
          supertab
          tabular
          tlib
          vim-addon-mw-utils
          vim-repeat
          snipmate
          surround
          #rust-vim
          #ghcmod
          neco-ghc
          vim-nix
          fugitive
      ];

      #opt = [
      #  rust-vim
      #  ghcmod
      #  neco-ghc
      #  vim-nix
      #];
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
