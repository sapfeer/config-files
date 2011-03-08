"----- GENERAL OPTIONS

set ruler
set exrc secure
set showcmd
set showmode
set number
set incsearch
set cursorcolumn
set cursorline
set langmenu=none
retab 2

"----- HIGHLIGHT OPTIONS

syntax enable
colorscheme darkblue

"----- PLUGIN OPTIONS

filetype plugin on

"----- FUNCTIONS DEFINITIONS

function! SetLocalOptions(fname)
	 " Set directory-wise configuration.
	 " Search from the directory the file is located upwards to the root for
	 " a local configuration file called .lvimrc and sources it.
	 "
	 " The local configuration file is expected to have commands affecting
	 " only the current buffer.
	 let dirname = fnamemodify(a:fname, ":p:h")
	 while "/" != dirname
			let lvimrc  = dirname . "/.lvimrc"
			if filereadable(lvimrc)
				 execute "source " . lvimrc
				 break
			endif
			let dirname = fnamemodify(dirname, ":p:h:h")
	 endwhile
endfunction

function! InsertDatedComment()
	" Insert comment depending on language and date-time stamp after it
	" then enters append mode
	let comment="#"
	if b:current_syntax =~ "vim"
		let comment='"'
	endif
	call append(line('.'), comment." ".strftime('%Y-%m-%d %H:%M:%S'))
endfunction

" ABBREVIATIONS DEFINITIONS

inoreabbrev /c <Esc>:call InsertDatedComment()<CR>jA

" MAPPING DEFINITIONS

map  "+y

"----- AUTOCOMMANDS DEFINITIONS

au BufNewFile,BufRead * call SetLocalOptions(bufname("%"))
