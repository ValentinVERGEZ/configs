" URL: http://vim.wikia.com/wiki/Example_vimrc
" Authors: http://vim.wikia.com/wiki/Vim_on_Freenode
" Description: A minimal, but feature rich, example .vimrc. If you are a
"              newbie, basing your first .vimrc on this file is a good choice.
"              If you're a more advanced user, building your own .vimrc based
"              on this file is still a good idea.

"------------------------------------------------------------
" Features {{{1
"
" These options and commands enable some very useful features in Vim, that
" no user should have to live without.

" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible

" Pathogen
execute pathogen#infect()

" Attempt to determine/se the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on
filetype plugin on

" Enable syntax highlighting
syntax on

colorscheme monokai

" Extra whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
" Make sure colorscheme commands do not erase our group
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
" Show trailing whitespace:
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Custom Highlighting tags
function! UpdateHighlightingFile()
		silent exec "!rm -rf types.vim"
		silent exec "!ctags -R --languages=C,C++ --c++-kinds=cgstu  -o- ./ | cut -f1 | xargs echo 'syntax keyword Type ' >> types.vim"
endfunction

" load the types.vim highlighting file, if it exists
autocmd BufRead,BufNewFile *.[ch] if filereadable('types.vim')
autocmd BufRead,BufNewFile *.[ch]   exe 'so ' . 'types.vim'
autocmd BufRead,BufNewFile *.[ch] endif

" Cscope handling
if filereadable("cscope.out")
  cs add cscope.out
endif
map g} :cs find 3 <C-R>=expand("<cword>")<CR><CR>

function! UpdateCscope()
  silent exec "!cscope -R -b"
  cs kill -1
  cs add cscope.out
endfunction

function! UpdateTags()
  silent exec "!ctags -R --languages=C,C++ --c++-kinds=+p --fields=+iaStm --extra=+q+f ./"
endfunction

function! UpdateCall()
	silent exec "!clear"
	let uc_startTime = system("date +'%s'")
	silent exec '!echo -e "\nUpdate CTags/CScope ..."'
	silent call UpdateTags()
	silent call UpdateCscope()
	silent call UpdateHighlightingFile()
	silent redraw!
	let uc_totalTime = system("date +'%s'") - uc_startTime
	let result = "CTags/CScope UPDATED (" . uc_totalTime . "sec)"
	echo result
endfunction

" Ctags/cscope update
noremap <silent> <F8> :call UpdateCall()<CR>

" NERDTree
noremap <silent> <F9> :NERDTreeToggle<CR>

" TLIST
" let Tlist_Show_One_File = 1
" let Tlist_Auto_Highlight_Tag = 1
" let Tlist_Enable_Fold_Column = 0
" let Tlist_Compact_Format = 1
" let Tlist_Use_Right_Window = 1
" noremap <silent> <F2> :TlistToggle<CR>

" Tagbar
let g:tagbar_usearrows = 1
noremap <silent> <F10> :TagbarToggle<CR>

" OmniCppComplete
set omnifunc=syntaxcomplete#Complete " override built-in C omnicomplete with C++ OmniCppComplete plugin
let OmniCpp_GlobalScopeSearch   = 1
let OmniCpp_DisplayMode         = 1
let OmniCpp_ShowScopeInAbbr     = 0 "do not show namespace in pop-up
let OmniCpp_ShowPrototypeInAbbr = 1 "show prototype in pop-up
let OmniCpp_ShowAccess          = 1 "show access in pop-up
let OmniCpp_SelectFirstItem     = 1 "select first item in pop-up
set completeopt=menuone,menu,longest


" COMPILE
noremap <silent> <F5> :make -j3<CR>
noremap <silent> <F6> :cprevious<CR>
noremap <silent> <F7> :cnext<CR>

" Use <F3> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F3>

let g:load_doxygen_syntax=1


" vim -b : edit binary using xxd-format!
augroup Binary
	au!
	au BufReadPre  *.bin let &bin=1
	au BufReadPost *.bin if &bin | %!xxd
	au BufReadPost *.bin set ft=xxd | endif
	au BufWritePre *.bin if &bin | %!xxd -r
	au BufWritePre *.bin endif
	au BufWritePost *.bin if &bin | %!xxd
	au BufWritePost *.bin set nomod | endif
augroup END

"------------------------------------------------------------
" Must have options {{{1
"
" These are highly recommended options.

" Vim with default settings does not allow easy switching between multiple files
" in the same editor window. Users can use multiple split windows or multiple
" tab pages to edit multiple files, but it is still best to enable an option to
" allow easier switching between files.
"
" One such option is the 'hidden' option, which allows you to re-use the same
" window and switch from an unsaved buffer without saving it first. Also allows
" you to keep an undo history for multiple files when re-using the same window
" in this way. Note that using persistent undo also lets you undo in multiple
" files even in the same window, but is less efficient and is actually designed
" for keeping undo history after closing Vim entirely. Vim will complain if you
" try to quit without saving, and swap files will keep you safe if your computer
" crashes.
" set hidden

" Note that not everyone likes working this way (with the hidden option).
" Alternatives include using tabs or split windows instead of re-using the same
" window as mentioned above, and/or either of the following options:
" set confirm
" set autowriteall

" Better command-line completion
set wildmenu

" Show partial commands in the last line of the screen
set showcmd

" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch

" Modelines have historically been a source of security vulnerabilities. As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
" set nomodeline


"------------------------------------------------------------
" Usability options {{{1
"
" These are options that users frequently set in their .vimrc. Some of them
" change Vim's behaviour in ways which deviate from the true Vi way, but
" which are considered to add usability. Which, if any, of these options to
" use is very much a personal preference, but they are harmless.

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Always display the status line, even if only one window is displayed
set laststatus=2

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Use visual bell instead of beeping when doing something wrong
set visualbell

" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
" set t_vb=

" Enable use of the mouse for all modes
set mouse=a

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2

" Display line numbers on the left
set number

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200


"------------------------------------------------------------
" Indentation options {{{1
"
" Indentation settings according to personal preference.

" Indentation settings for using 2 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
" set shiftwidth=2
" set softtabstop=2
" set expandtab

" Indentation settings for using hard tabs for indent. Display tabs as
" two characters wide.
set noexpandtab
" set copyindent
" set preserveindent
set softtabstop=0
set shiftwidth=4
set tabstop=4

"------------------------------------------------------------
" Mappings {{{1
"
" Useful mappings

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
" map Y y$

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>


"------------------------------------------------------------
" Display hidden characters
set listchars=tab:▸\ ,eol:¬
set list

" Insert new line
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

" Bufferline and airline
let g:bufferline_echo = 0
let g:airline#extensions#bufferline#enabled = 0
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = "luna"
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#buffer_nr_show = 1

" Git-gutter
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0
let g:gitgutter_max_signs = 4000

" Change higlight for search
highlight Search term=reverse cterm=underline ctermfg=235 ctermbg=159
set incsearch
