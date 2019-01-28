" .vimrc / init.vim
" The following vim/neovim configuration works for both Vim and NeoVim

" ensure vim-plug is installed and then load it
call functions#PlugLoad()
call plug#begin('~/.config/nvim/plugged')

" General {{{
    " Abbreviations
    abbr funciton function
    abbr teh the
    abbr tempalte template
    abbr fitler filter
    abbr cosnt const
    abbr attribtue attribute
    abbr attribuet attribute

    set ttimeoutlen=1 " Used for key code delays"

    " convert to Unicode defaults
    setglobal termencoding=utf-8 fileencodings=
    set encoding=utf-8

    set wildignore+=*/shared/*,*/node_modules/*,*/.bundle/*,*/build/*,*/test/*,*/.docker-sync/*,_site,*/__pycache__/,*/venv/*,*/target/*,*/.vim$,\~$,*/.log,*/.aux,*/.cls,*/.aux,*/.bbl,*/.blg,*/.fls,*/.fdb*/,*/.toc,*/.out,*/.glo,*/.log,*/.ist,*/.fdb_latexmk,*/tags,*/.swp,*/.tags " ignore files

    set autoread " detect when a file is changed

    set history=1000 " change history to 1000

    set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
    set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

    if (has('nvim'))
        " show results of substition as they're happening
        " but don't open a split
        set inccommand=nosplit
    endif

    set backspace=indent,eol,start " make backspace behave in a sane manner
    set clipboard^=unnamed,unnamedplus " copy and past from system clipboard

    if has('mouse')
        set mouse=a
    endif

    " Searching
    set ignorecase " case insensitive searching
    set smartcase " case-sensitive if expresson contains a capital letter
    set hlsearch " highlight search results
    set incsearch " set incremental search, like modern browsers
    set nolazyredraw " don't redraw while executing macros

    set magic " Set magic on, for regex

    " error bells
    set noerrorbells
    set visualbell
    set t_vb=
    set tm=500

    " disable continuation of comments to the next line
    set formatoptions-=ro
" }}}

" Appearance {{{
    set ruler " show col,line
    set number " show line numbers
    set textwidth=80 " break line at 8-
    let &colorcolumn="80"
    set wrap " turn on line wrapping, doesn't affect buffer
    set wrapmargin=8 " wrap lines when coming within n characters from side
    set linebreak " set soft wrapping, doesn't affect buffer
    set showbreak=… " show ellipsis at breaking
    set autoindent " automatically set indent of new line
    set ttyfast " faster redrawing
    set diffopt+=vertical
    set laststatus=2 " show the satus line all the time
    set so=7 " set 7 lines to the cursors - when moving vertical
    set wildmenu " enhanced command line completion
    set hidden " current buffer can be put into background
    set showcmd " show incomplete commands
    set noshowmode " don't show which mode disabled for PowerLine
    set wildmode=list:longest,full " complete files like a shell
    set shell=$SHELL
    set cmdheight=1 " command bar height
    set title " set terminal title
    set showmatch " show matching braces
    set mat=2 " how many tenths of a second to blink

    " Tab control
    set expandtab " insert spaces rather than tabs for <Tab>
    set smarttab " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
    set tabstop=2 " the visible width of tabs
    set softtabstop=2 " edit as if the tabs are x characters wide
    set shiftwidth=2 " number of spaces to use for indent and unindent
    set shiftround " round indent to a multiple of 'shiftwidth'

    " code folding settings
    set foldmethod=indent " fold based on indent
    set foldlevelstart=99
    set foldnestmax=10 " deepest fold is 10 levels
    set nofoldenable " don't fold by default
    set foldlevel=1
    set foldcolumn=1 " show a column with width 1 for folding

    " toggle invisible characters
    set list
    set listchars=tab:→\ ,trail:⋅,extends:❯,precedes:❮,nbsp:⎵
    " set eol:¬
    " set showbreak=↪

    " show vertical indentation 
    Plug 'Yggdroot/indentLine'
    let g:indentLine_char = '│'

    set t_Co=256 " Explicitly tell vim that the terminal supports 256 colors
    " switch cursor to line when in insert mode, and block when not
    set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
    \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
    \,sm:block-blinkwait175-blinkoff150-blinkon175

    if &term =~ '256color'
        " disable background color erase
        set t_ut=
    endif

    " enable 24 bit color support if supported
    if (has("termguicolors"))
        if (!(has("nvim")))
            let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
            let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
        endif
        set termguicolors
    endif

    " highlight conflicts
    match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

    " Load colorschemes
    Plug 'chriskempson/base16-vim'
    Plug 'joshdick/onedark.vim'

    " LightLine {{{
        Plug 'itchyny/lightline.vim'
        Plug 'nicknisi/vim-base16-lightline'
        let g:lightline = {
        \   'colorscheme': 'base16',
        \   'active': {
        \       'left': [ [ 'mode', 'paste' ],
        \               [ 'gitbranch' ],
        \               [ 'readonly', 'filetype', 'filename' ]],
        \       'right': [ [ 'percent' ], [ 'lineinfo' ],
        \               [ 'fileformat', 'fileencoding' ],
        \               [ 'linter_errors', 'linter_warnings' ]]
        \   },
        \   'component_expand': {
        \       'linter': 'LightlineLinter',
        \       'linter_warnings': 'LightlineLinterWarnings',
        \       'linter_errors': 'LightlineLinterErrors',
        \       'linter_ok': 'LightlineLinterOk'
        \   },
        \   'component_type': {
        \       'readonly': 'error',
        \       'linter_warnings': 'warning',
        \       'linter_errors': 'error'
        \   },
        \   'component_function': {
        \       'fileencoding': 'LightlineFileEncoding',
        \       'filename': 'LightlineFileName',
        \       'fileformat': 'LightlineFileFormat',
        \       'filetype': 'LightlineFileType',
        \       'gitbranch': 'LightlineGitBranch'
        \   },
        \   'tabline': {
        \       'left': [ [ 'tabs' ] ],
        \       'right': [ [ 'close' ] ]
        \   },
        \   'tab': {
        \       'active': [ 'filename', 'modified' ],
        \       'inactive': [ 'filename', 'modified' ],
        \   },
        \   'separator': { 'left': '', 'right': '' },
        \   'subseparator': { 'left': '', 'right': '' }
        \ }
        " \   'separator': { 'left': '▓▒░', 'right': '░▒▓' },
        " \   'subseparator': { 'left': '▒', 'right': '░' }

        function! LightlineFileName() abort
            let filename = winwidth(0) > 70 ? expand('%') : expand('%:t')
            if filename =~ 'NERD_tree'
                return ''
            endif
            let modified = &modified ? ' +' : ''
            return fnamemodify(filename, ":~:.") . modified
        endfunction

        function! LightlineFileEncoding()
            " only show the file encoding if it's not 'utf-8'
            return &fileencoding == 'utf-8' ? '' : &fileencoding
        endfunction

        function! LightlineFileFormat()
            " only show the file format if it's not 'unix'
            let format = &fileformat == 'unix' ? '' : &fileformat
            return winwidth(0) > 70 ? format . ' ' . WebDevIconsGetFileFormatSymbol() : ''
        endfunction

        function! LightlineFileType()
            return &filetype
        endfunction

        function! LightlineLinter() abort
            let l:counts = ale#statusline#Count(bufnr(''))
            return l:counts.total == 0 ? '' : printf('×%d', l:counts.total)
        endfunction

        function! LightlineLinterWarnings() abort
            let l:counts = ale#statusline#Count(bufnr(''))
            let l:all_errors = l:counts.error + l:counts.style_error
            let l:all_non_errors = l:counts.total - l:all_errors
            return l:counts.total == 0 ? '' : '⚠ ' . printf('%d', all_non_errors)
        endfunction

        function! LightlineLinterErrors() abort
            let l:counts = ale#statusline#Count(bufnr(''))
            let l:all_errors = l:counts.error + l:counts.style_error
            return l:counts.total == 0 ? '' : '✖ ' . printf('%d', all_errors)
        endfunction

        function! LightlineLinterOk() abort
            let l:counts = ale#statusline#Count(bufnr(''))
            return l:counts.total == 0 ? 'OK' : ''
        endfunction

        function! LightlineGitBranch()
            return "\uE725" . (exists('*fugitive#head') ? fugitive#head() : '')
        endfunction

        function! LightlineUpdate()
            if g:goyo_entered == 0
                " do not update lightline if in Goyo mode
                call lightline#update()
            endif
        endfunction

        augroup alestatus
            autocmd User ALELintPost call LightlineUpdate()
        augroup end
    " }}}
" }}}

" General Mappings {{{
    " set a map leader for more key combos
    let mapleader = ','

    " clear highlighted search
    noremap <space> :set hlsearch! hlsearch?<cr>

    " activate spell-checking alternatives
    nmap ;s :set invspell spelllang=en<cr>

    " markdown to html
    nmap <leader>md :%!markdown --html4tags <cr>

    " remove extra whitespace
    nmap <leader><space> :%s/\s\+$<cr>
    nmap <leader><space><space> :%s/\n\{2,}/\r\r/g<cr>

    inoremap <expr> <C-j> pumvisible() ? "\<C-N>" : "\<C-j>"
    inoremap <expr> <C-k> pumvisible() ? "\<C-P>" : "\<C-k>"

    nmap <leader>l :set list!<cr>

    " switch between current and last buffer
    nmap <leader>. <c-^>

    " enable . command in visual mode
    vnoremap . :normal .<cr>

    map <leader>wc :wincmd q<cr>

    " toggle cursor line
    nnoremap <leader>i :set cursorline!<cr>

    " scroll the viewport faster
    " nnoremap <C-e> 3<C-e>
    " nnoremap <C-y> 3<C-y>

    " moving up and down work as you would expect
    nnoremap <silent> j gj
    nnoremap <silent> k gk
    nnoremap <silent> ^ g^
    nnoremap <silent> $ g$

    " helpers for dealing with other people's code
    nmap \t :set ts=4 sts=4 sw=4 noet<cr>
    nmap \s :set ts=4 sts=4 sw=4 et<cr>

    nnoremap <silent> <leader>u :call functions#HtmlUnEscape()<cr>

    command! Rm call functions#Delete()
    command! RM call functions#Delete() <Bar> q!
" }}}

" AutoGroups {{{
    " file type specific settings
    augroup configgroup
        autocmd!

        " close help file with q
        autocmd FileType help nnoremap <buffer> q :q<CR>
        " jump to the last position when reopening a file
        autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
        " helps in gf
        autocmd BufRead * execute 'setl suffixesadd+=.' . expand('%:e')
        " clean for fugitive
        autocmd BufReadPost fugitive://* set bufhidden=delete
        " set encoding in new files to utf-8
        autocmd BufNewFile,BufRead  *   try
        autocmd BufNewFile,BufRead  *   set encoding=utf-8
        autocmd BufNewFile,BufRead  *   endtry
        " exception for makefiles, keep tabs
        autocmd FileType make setlocal ts=4 sts=4 sw=4 noexpandtab
        " automatically resize panes on resize
        autocmd VimResized * exe 'normal! \<c-w>='
        autocmd BufWritePost .vimrc,.vimrc.local,init.vim source %
        autocmd BufWritePost .vimrc.local source %
        " save all files on focus lost, ignoring warnings about untitled buffers
        " autocmd FocusLost * silent! wa
        " make quickfix windows take all the lower section of the screen
        " when there are multiple windows open
        autocmd FileType qf wincmd J
        autocmd FileType qf nmap <buffer> q :q<cr>
    augroup END
" }}}

" General Functionality {{{

    " Tab for insert mode completion {{{
        Plug 'ervandew/supertab'

        let g:SuperTabDefaultCompletionType = '<C-n>'
        set completeopt=menu,longest    " Use the popup menu by default; only insert the longest common text of the completion matches; don't automatically show extra information in the preview window.
    " }}}

    " align => ga {{{
        Plug 'junegunn/vim-easy-align'

        nmap ga <Plug>(EasyAlign)
        xmap ga <Plug>(EasyAlign)
        xmap a  ga*<Space><CR>
        xmap aa ga*<Space><CR>
    " }}}

    " swap files handling
    Plug 'gioele/vim-autoswap'

    " create directory on save if not existing
    Plug 'DataWraith/auto_mkdir'

    " better terminal integration
    " substitute, search, and abbreviate multiple variants of a word
    Plug 'tpope/vim-abolish'

    " search inside files using ripgrep. This plugin provides an Ack command.
    Plug 'wincent/ferret'

    " insert or delete brackets, parens, quotes in pair
    Plug 'jiangmiao/auto-pairs'

    " {{{ easy commenting motions
        Plug 'tpope/vim-commentary'
        " Comments <C-/>
        vmap <C-_> gc
        nmap <C-_> gcc
        imap <C-_> <Esc>gcci
    " }}}

    " mappings which are simply short normal mode aliases for commonly used ex commands
    Plug 'tpope/vim-unimpaired'

    " endings for html, xml, etc. - ehances surround
    Plug 'tpope/vim-ragtag'

    " {{{ mappings to easily delete, change and add such surroundings in pairs, such as quotes, parens, etc.
        Plug 'tpope/vim-surround'

        vmap ' S'
        vmap " S"
        vmap { S{
        vmap [ S[
        vmap ( S(

    " }}}

    " tmux integration for vim
    Plug 'benmills/vimux'

    " enables repeating other supported plugins with the . command
    Plug 'tpope/vim-repeat'

    " .editorconfig support
    Plug 'editorconfig/editorconfig-vim'

    " asynchronous build and test dispatcher
    Plug 'tpope/vim-dispatch'

    " netrw helper
    Plug 'tpope/vim-vinegar'

    " single/multi line code handler: gS - split one line into multiple, gJ - combine multiple lines into one
    Plug 'AndrewRadev/splitjoin.vim'

    " extended % matching
    Plug 'vim-scripts/matchit.zip'

    " add end, endif, etc. automatically
    Plug 'tpope/vim-endwise'

    " detect indent style (tabs vs. spaces)
    Plug 'tpope/vim-sleuth'

    " Startify: Fancy startup screen for vim {{{
        Plug 'mhinz/vim-startify'

        " Don't change to directory when selecting a file
        let g:startify_files_number = 5
        let g:startify_change_to_dir = 0
        let g:startify_custom_header = [ ]
        let g:startify_relative_path = 1
        let g:startify_use_env = 1

        function! s:list_commits()
            let git = 'git -C ' . getcwd()
            let commits = systemlist(git . ' log --oneline | head -n5')
            let git = 'G' . git[1:]
            return map(commits, '{"line": matchstr(v:val, "\\s\\zs.*"), "cmd": "'. git .' show ". matchstr(v:val, "^\\x\\+") }')
        endfunction

        " Custom startup list, only show MRU from current directory/project
        let g:startify_lists = [
        \  { 'type': 'dir',       'header': [ 'Files '. getcwd() ] },
        \  { 'type': function('s:list_commits'), 'header': [ 'Recent Commits' ] },
        \  { 'type': 'sessions',  'header': [ 'Sessions' ]       },
        \  { 'type': 'bookmarks', 'header': [ 'Bookmarks' ]      },
        \  { 'type': 'commands',  'header': [ 'Commands' ]       },
        \ ]

        let g:startify_commands = [
        \   { 'up': [ 'Update Plugins', ':PlugUpdate' ] },
        \   { 'ug': [ 'Upgrade Plugin Manager', ':PlugUpgrade' ] },
        \ ]

        let g:startify_bookmarks = [
            \ { 'c': '~/code/dotfiles/config/nvim/init.vim' },
            \ { 'z': '~/code/dotfiles/zsh/zshrc.symlink' }
        \ ]

        autocmd User Startified setlocal cursorline
    " }}}

    " Open selection in carbon.now.sh
    Plug 'kristijanhusak/vim-carbon-now-sh'

    " Close buffers but keep splits
    Plug 'moll/vim-bbye'
    nmap <leader>b :Bdelete<cr>

    " Writing in vim {{{{
        Plug 'junegunn/goyo.vim'

        let g:goyo_entered = 0
        function! s:goyo_enter()
            silent !tmux set status off
            let g:goyo_entered = 1
            set noshowmode
            set noshowcmd
            set scrolloff=999
            set wrap
            setlocal textwidth=0
            setlocal wrapmargin=0
        endfunction

        function! s:goyo_leave()
            silent !tmux set status on
            let g:goyo_entered = 0
            set showmode
            set showcmd
            set scrolloff=5
            set textwidth=120
            set wrapmargin=8
        endfunction

        autocmd! User GoyoEnter nested call <SID>goyo_enter()
        autocmd! User GoyoLeave nested call <SID>goyo_leave()
    " }}}

    " context-aware pasting
    Plug 'sickill/vim-pasta'

    " NERDTree {{{
        Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
        Plug 'Xuyuanp/nerdtree-git-plugin'
        Plug 'ryanoasis/vim-devicons'
        Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
        let g:WebDevIconsOS = 'Darwin'
        let g:WebDevIconsUnicodeDecorateFolderNodes = 1
        let g:DevIconsEnableFoldersOpenClose = 1
        let g:DevIconsEnableFolderExtensionPatternMatching = 1
        let g:NERDTreeWinSize=30 " open if no dir specified
        let NERDTreeDirArrowExpandable = "\u00a0" " make arrows invisible
        let NERDTreeDirArrowCollapsible = "\u00a0" " make arrows invisible
        let NERDTreeNodeDelimiter = "\u263a" " smiley face
        let NERDTreeIgnore = ['__pycache__', '\.pyc$', '\.o$', '\.so$', '\.a$', '\.swp', '*\.swp', '\.swo', '\.swn', '\.swh', '\.swm', '\.swl', '\.swk', '\.sw*$', '[a-zA-Z]*egg[a-zA-Z]*', '.DS_Store']
        let NERDTreeShowHidden=1 " hide files
        let g:NERDTreeMouseMode=3 " single click

        augroup nerdtree
            autocmd!
            " Prevent Tab on NERDTree (breaks everything otherwise)
            autocmd FileType nerdtree noremap <buffer> <Tab> <nop>
            autocmd FileType nerdtree noremap <buffer> <S-Tab> <nop>
            autocmd FileType nerdtree nnoremap <buffer> q :NERDTreeToggle<CR>
            autocmd FileType nerdtree nnoremap <buffer> <Tab> <C-w><Right>:bn<CR>
            autocmd FileType nerdtree nnoremap <buffer> <S-Tab> <C-w><Right>:bn<CR>
            autocmd FileType nerdtree setlocal nolist " turn off whitespace characters
            autocmd FileType nerdtree setlocal nocursorline " turn off line highlighting for performance
        augroup END

        nmap <silent> <C-e> :NERDTreeToggle<cr>
        " find the current file in nerdtree without needing to reload the drawer
        nmap <silent> <C-e><C-e> :NERDTreeFind<cr>

        let NERDTreeShowHidden=1
        " let NERDTreeDirArrowExpandable = '▷'
        " let NERDTreeDirArrowCollapsible = '▼'
        let g:NERDTreeIndicatorMapCustom = {
        \ "Modified"  : "✹",
        \ "Staged"    : "✚",
        \ "Untracked" : "✭",
        \ "Renamed"   : "➜",
        \ "Unmerged"  : "═",
        \ "Deleted"   : "✖",
        \ "Dirty"     : "✗",
        \ "Clean"     : "✔︎",
        \ 'Ignored'   : '☒',
        \ "Unknown"   : "?"
        \ }
    " }}}

    " FZF {{{
        Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
        Plug 'junegunn/fzf.vim'
        let g:fzf_layout = { 'down': '~25%' }

        if isdirectory(".git")
            " if in a git project, use :GFiles
            nmap <silent> <leader>t :GitFiles --cached --others --exclude-standard<cr>
            nnoremap <C-p> yiw :GitFiles --cached --others --exclude-standard<cr>
            inoremap <C-p> <Esc>yiw :GitFiles --cached --others --exclude-standard<cr>
        else
            " otherwise, use :FZF
            nnoremap <C-p> yiw :FZF<CR>
            inoremap <C-p> <Esc>yiw :FZF<CR>
        endif

        nnoremap <C-t> yiw :Ag<CR>
        inoremap <C-t> <Esc>yiw :Ag<CR>
        nnoremap <c-q> :Buffers<CR>
        inoremap <c-q> <Esc>yiw :Buffers<CR>

        nnoremap <leader>m :Marks<CR>

        nmap <C-m> <plug>(fzf-maps-n)
        xmap <C-m> <plug>(fzf-maps-x)
        omap <C-m> <plug>(fzf-maps-o)

        " Insert mode completion
        imap <c-x><c-k> <plug>(fzf-complete-word)
        imap <c-x><c-f> <plug>(fzf-complete-path)
        imap <c-x><c-j> <plug>(fzf-complete-file-ag)
        imap <c-x><c-l> <plug>(fzf-complete-line)

        nnoremap <silent> <Leader>C :call fzf#run({
        \   'source':
        \     map(split(globpath(&rtp, "colors/*.vim"), "\n"),
        \         "substitute(fnamemodify(v:val, ':t'), '\\..\\{-}$', '', '')"),
        \   'sink':    'colo',
        \   'options': '+m',
        \   'left':    30
        \ })<CR>

        command! FZFMru call fzf#run({
        \  'source':  v:oldfiles,
        \  'sink':    'e',
        \  'options': '-m -x +s',
        \  'down':    '40%'})

        command! -bang -nargs=* Find call fzf#vim#grep(
            \ 'rg --column --line-number --no-heading --follow --color=always '.<q-args>, 1,
            \ <bang>0 ? fzf#vim#with_preview('up:60%') : fzf#vim#with_preview('right:50%:hidden', '?'), <bang>0)
        command! -bang -nargs=? -complete=dir Files
            \ call fzf#vim#files(<q-args>, fzf#vim#with_preview('right:50%', '?'), <bang>0)
        command! -bang -nargs=? -complete=dir GitFiles
            \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview('right:50%', '?'), <bang>0)
    " }}}

    " signify {{{
        " Plug 'airblade/vim-gitgutter'
        Plug 'mhinz/vim-signify'
        let g:signify_vcs_list = [ 'git' ]
        let g:signify_sign_add               = '+'
        let g:signify_sign_delete            = '_'
        let g:signify_sign_delete_first_line = '‾'
        let g:signify_sign_change = '!'
    " }}}

    " vim-fugitive {{{
        Plug 'tpope/vim-fugitive'
        Plug 'tpope/vim-rhubarb' " hub extension for fugitive
        Plug 'junegunn/gv.vim'
        Plug 'sodapopcan/vim-twiggy'
        Plug 'christoomey/vim-conflicted'

        " Git
        nnoremap ;fc :Commits<CR>
        nnoremap ;fb :BCommits<CR>
        nnoremap ;ff :GFiles?<CR>
        nnoremap ;s  :Gstatus<CR>
        nnoremap ;r  :Gread<CR>
        nnoremap ;r! :Gread!<CR>
        nnoremap ;w  :Gwrite<CR>
        nnoremap ;w! :Gwrite!<CR>
        nnoremap ;-  :Gremove<CR>
        nnoremap ;m  :Gmove<CR>
        nnoremap ;c  :Gcommit<CR>
        nnoremap ;b  :Gblame<CR>
        nnoremap ;l  :Gbrowse<CR>
        nnoremap ;e  :Gedit<Space>
        nnoremap ;v  :Gvsplit<Space>
        nnoremap ;df :Gdiff<CR>
        nnoremap ;du :diffupdate<CR>
        nmap     ;dg :diffget v:count <CR>;du
        nmap     ;dp :diffput v:count <CR>;du
        nnoremap ;o  [c
        nnoremap ;i  ]c
    " }}}

    " ALE {{{
        Plug 'w0rp/ale' " Asynchonous linting engine
        let g:ale_set_highlights = 0
        let g:ale_change_sign_column_color = 0
        let g:ale_sign_column_always = 1
        let g:ale_sign_error = '✖'
        let g:ale_sign_warning = '⚠'
        let g:ale_echo_msg_error_str = '✖'
        let g:ale_echo_msg_warning_str = '⚠'
        let g:ale_echo_msg_format = '%severity% %s% [%linter%% code%]'
        let g:ale_completion_enabled = 1

        let g:ale_linters = {
        \   'javascript': ['eslint', 'tsserver'],
        \   'typescript': ['tsserver', 'tslint'],
        \   'typescript.tsx': ['tsserver', 'tslint'],
        \   'html': []
        \}
        let g:ale_fixers = {}
        let g:ale_fixers['javascript'] = ['prettier']
        let g:ale_fixers['typescript'] = ['prettier', 'tslint']
        let g:ale_fixers['json'] = ['prettier']
        let g:ale_fixers['css'] = ['prettier']
        let g:ale_javascript_prettier_use_local_config = 1
        let g:ale_fix_on_save = 0
        nmap <silent><leader>af :ALEFix<cr>
    " }}}

    " UltiSnips {{{
        Plug 'SirVer/ultisnips' " Snippets plugin
        let g:UltiSnipsExpandTrigger="<tab>"
        let g:UltiSnipsJumpForwardTrigger = "<tab>"
        let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
    " }}}

    " Schelpp for VM move {{{
        Plug 'zirrostig/vim-schlepp'

        let g:Schlepp#reindent = 1 " supress errors for next cmds
        :silent! vmap <unique> <M-up>    <Plug>SchleppUp
        :silent! vmap <unique> <M-down>  <Plug>SchleppDown
        :silent! vmap <unique> <M-left>  <Plug>SchleppLeft
        :silent! vmap <unique> <M-right> <Plug>SchleppRight
        nmap <M-Up> V<M-Up>V
        nmap <M-Down> V<M-Down>V
        imap <M-Up> <Esc>V<M-Up>Va
        imap <M-Down> <Esc>V<M-Down>Va
    " }}}

    " Vim multi-cursor {{{
        Plug 'mg979/vim-visual-multi'

        let g:VM_maps = {}
        let g:VM_maps['Find Under']         = '<C-d>'
        let g:VM_maps['Find Subword Under'] = '<C-d>'
        let g:VM_maps["Visual Cursors"]     = '<leader><leader>c'
        let g:VM_theme = 'iceblue'
        imap <C-Up> <Esc><C-Up>i
        imap <C-Down> <Esc><C-Down>i
    " }}}

    " Search and replace in directory {{{
        Plug 'dkprice/vim-easygrep'

        let g:EasyGrepFilesToExclude='.bundle,node_modules,coverage,*.lock,*.log,__snapshots__,bundle,build,shared,docker-sync,*.swp,*.tags,tags'
        let g:EasyGrepRecursive=1
        let g:EasyGrepCommand=1   " important, otherwise, it won't work
    " }}}

    "  {{{
    " }}}

    " Completion {{{
        " if (has('nvim'))
        "     Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
        " else
        "     Plug 'Shougo/deoplete.nvim'
        "     Plug 'roxma/nvim-yarp'
        "     Plug 'roxma/vim-hug-neovim-rpc'
        " endif
        " let g:deoplete#enable_at_startup = 1
    " }}}
" }}}

" Language-Specific Configuration {{{
    " html / templates {{{
        " emmet support for vim - easily create markdup wth CSS-like syntax
        Plug 'mattn/emmet-vim', { 'for': ['html', 'javascript.jsx']}
        let g:user_emmet_settings = {
        \  'javascript.jsx': {
        \      'extends': 'jsx',
        \  },
        \}

        " match tags in html, similar to paren support
        Plug 'gregsexton/MatchTag', { 'for': 'html' }

        " html5 support
        Plug 'othree/html5.vim', { 'for': 'html' }

        " mustache support
        Plug 'mustache/vim-mustache-handlebars'

        " pug / jade support
        Plug 'digitaltoad/vim-pug', { 'for': ['jade', 'pug'] }
    " }}}

    " JavaScript {{{
        Plug 'othree/yajs.vim', { 'for': [ 'javascript', 'javascript.jsx', 'html' ] }
        " Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx', 'html'] }
        Plug 'moll/vim-node', { 'for': 'javascript' }
        Plug 'mxw/vim-jsx', { 'for': ['javascript.jsx', 'javascript'] }
        Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx'], 'do': 'npm install' }
    " }}}

    " TypeScript {{{
        Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
        Plug 'ianks/vim-tsx', { 'for': 'typescript' }
        Plug 'Shougo/vimproc.vim', { 'do': 'make' }

        " Plug 'mhartington/nvim-typescript', { 'for': 'typescript', 'do': './install.sh' }
        " let g:nvim_typescript#diagnostics_enable = 0
        " let g:nvim_typescript#max_completion_detail=100
    " }}}


    " Styles {{{
        Plug 'wavded/vim-stylus', { 'for': ['stylus', 'markdown'] }
        Plug 'groenewege/vim-less', { 'for': 'less' }
        Plug 'hail2u/vim-css3-syntax', { 'for': 'css' }
        Plug 'cakebaker/scss-syntax.vim', { 'for': 'scss' }
        Plug 'gko/vim-coloresque'
        Plug 'stephenway/postcss.vim', { 'for': 'css' }
    " }}}

    " markdown {{{
        Plug 'tpope/vim-markdown', { 'for': 'markdown' }
        let g:markdown_fenced_languages = [ 'tsx=typescript.tsx' ]
    " }}}

    " JSON {{{
        Plug 'elzr/vim-json', { 'for': 'json' }
        let g:vim_json_syntax_conceal = 0
    " }}}

    " Python {{{
        Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'py' }
        Plug 'python-rope/rope', { 'for': 'py' }
        Plug 'python-rope/ropemode', { 'for': 'py' }
        Plug 'python-rope/ropevim', { 'for': 'py' }
        Plug 'klen/pylama', { 'for': 'py' }
    " }}}

    " Plug 'scrooloose/syntastic', { 'for': '' }
    Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['cpp', 'h', 'hpp', 'c'] }
    Plug 'fatih/vim-go', { 'for': 'go' }
    Plug 'timcharper/textile.vim', { 'for': 'textile' }
    Plug 'lambdatoast/elm.vim', { 'for': 'elm' }
    Plug 'ekalinin/Dockerfile.vim'
" }}}

call plug#end()

" Colorscheme and final setup {{{
    " This call must happen after the plug#end() call to ensure
    " that the colorschemes have been loaded
    if filereadable(expand("~/.vimrc_background"))
        let base16colorspace=256
        source ~/.vimrc_background
    else
        let g:onedark_termcolors=16
        let g:onedark_terminal_italics=1
        colorscheme base16-tomorrow-night
    endif
    syntax on
    filetype plugin indent on
    " make the highlighting of tabs and other non-text less annoying
    highlight SpecialKey ctermfg=19 guifg=#333333
    highlight NonText ctermfg=19 guifg=#333333

    " make comments and HTML attributes italic
    highlight Comment cterm=italic term=italic gui=italic
    highlight htmlArg cterm=italic term=italic gui=italic
    highlight xmlAttrib cterm=italic term=italic gui=italic
    " highlight Type cterm=italic term=italic gui=italic
    highlight Normal ctermbg=none


    " Fix nerdtree bug
    if exists("g:loaded_webdevicons")
      call webdevicons#refresh()
    endif
" }}}

" General maps {{{
    " Leader
    nnoremap <Leader><BS>     :TrimTrailingWS<CR>
    nnoremap <leader>1        :SynStack<CR>
    nnoremap <leader>2        :set path+=**
    nnoremap <leader>.        yyp

    " remap esc
    inoremap jj <esc>

    " General
    nnoremap ;;s     :so $MYVIMRC<CR>
    nnoremap ;;m     :e ~/.config/Makefile<CR>
    nnoremap ;;v     :e  $MYVIMRC<CR>
    nnoremap ;;t     :e  ~/.tmux.conf<CR>
    nnoremap q       :bp\|bd #<CR>
    nnoremap Q       :q<CR>
    nnoremap U        <C-r>
    nnoremap /       yiw/
    nnoremap gi      <C-]>
    nnoremap gp      <C-o>
    nnoremap gn      <C-i>
    nnoremap <Esc>   :noh<CR><Esc>
    nnoremap <Tab>   :bn<CR>
    nnoremap <S-Tab> :bp<CR>
    vnoremap <BS>    x
    vnoremap <Tab>   >gv
    vnoremap <S-Tab> <gv
    cnoremap W       w
    cnoremap Q       q

    " Useful Ctrl cmds
    nnoremap <C-c> yy<C-c>
    inoremap <C-c> <Esc>yy
    vnoremap <C-c> y
    nnoremap <C-x> dd
    inoremap <C-x> <Esc>dd
    vnoremap <C-x> d
    nnoremap <C-v> p^
    inoremap <C-v> <C-r>"<Esc>`[V`]=
    vnoremap <C-v> "0P
    inoremap <C-z> <Esc>ui
    nnoremap <C-z> u
    vnoremap <C-z> <Esc>ugv
    nnoremap <C-s> :w<CR>
    inoremap <C-s> <Esc>:w<CR>
    vnoremap <C-s> <Esc>:w<CR>
    nnoremap <C-a> ggVG
    inoremap <C-a> <Esc>ggVG
    noremap <C-n> :e %:h/
    noremap <C-Space> <Esc>:vs<CR>
    nnoremap <C-f> yiw:Grep<Space><C-r>0
    inoremap <C-f> <Esc>yiw:Grep<Space><C-r>0
    nnoremap <C-h> yiw:Replace<Space><C-r>0<Space>
    inoremap <C-h> <Esc>yiw:Replace<Space><C-r>0<Space>

    " Visual with shift
    nnoremap <S-Up>    V<Up>
    nnoremap <S-Down>  V<Down>
    nnoremap <S-Left>  <C-v><Left>
    nnoremap <S-Right> <C-v><Right>
    inoremap <S-Up>    <Esc><Right>V<Up>
    inoremap <S-Down>  <Esc><Right>V<Down>
    inoremap <S-Left>  <Esc><Right><C-v><Left>
    inoremap <S-Right> <Esc><Right><C-v><Right>
    vnoremap <S-Up>    <Up>
    vnoremap <S-Down>  <Down>
    vnoremap <S-Left>  <Left>
    vnoremap <S-Right> <Right>
    vnoremap <Up>    <Esc><Up>
    vnoremap <Down>  <Esc><Down>
    vnoremap <Left>  <Esc><Left>
    vnoremap <Right> <Esc><Right>

    " motion commands
    nnoremap <M-Left> bi
    nnoremap <M-Right> ea
    inoremap <M-Left> <Esc>bi
    inoremap <M-Right> <Esc>ea
    nnoremap <C-Left> I
    nnoremap <C-Right> A
    inoremap <C-Left> <Esc>I
    inoremap <C-Right> <Esc>A

" }}}

