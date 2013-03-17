set langmenu=zh_CN.UTF-8                 "设置菜单语言
source $VIMRUNTIME/delmenu.vim    "导入删除菜单脚本，删除乱码的菜单
source $VIMRUNTIME/menu.vim          "导入正常的菜单脚本
language messages zh_CN.utf-8          "设置提示信息语言

" 判断是终端还是gvim
if has("gui_running")
	let g:isGUI=1
else
	let g:isGUI=0
endif

if v:progname =~? "evim"
  finish
endif

" 非兼容模式
set nocompatible

"显示行号
set number

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

"自动加载外部修改内容
set autoread 	

"命令模式下使用tab自动补全的时候，将补全内容用一个漂亮的单行菜单形式显示出来
set wildmenu

"不备份文件
set nobackup		

set history=1000

"编辑时右下角光标的状态
"状态栏显示在屏幕底部
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands

map Q gq

"设置语法高亮
set syntax=c
syntax enable

"搜索时高亮关键字
set hlsearch

"中文帮助
set helplang=cn

"不在单词中间断行
set lbr

command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis

set ambiwidth=double

" 指定不折行，如果一行太长，超过屏幕宽度，则向右边延伸到屏幕外面
"set nowrap
set wrap 		

"打开C/C++风格的自动缩进
"当在终端粘贴代码时，这个动作解释为键入，vim会按照设置的自动缩进格式为代码
"调整缩进而粘贴的代码本身就包含了缩进，因此便出现了版式混乱的情况。
"在GVIM时不会出现这种情况
"在粘贴之前输入 :set paste 关闭所有自动缩进
"粘贴后 :set nopaste 重新打开原有的自动缩进设置
set cindent shiftwidth=8

"设定C/C++风格自动缩进的选项
" :0 switch语句之下的case语句缩进0个空格
" g0 class struct 等之下的访问权控制语句如public protected private等
" 相对class缩进0个空格
" t0 如果函数返回值与函数名不在同一行，则返回值缩进0个空格。
" 这里返回值指的是函数返回类型
" (sus 当一对括号跨越多行时，其后的行缩进为sw指定的距离
set cino=:0,g0,t0,+0,(0

set smartindent 	"c 程序自动缩进

"打开普通文件类型的自动缩进，不如cindent智能，
"但可以为编辑非C/C++文件提供一定的帮助
set autoindent shiftwidth=8

"tab4个空格
set tabstop=8
"将所有的tab替换为空格
"set et
		
"显示括号配对情况，打开这个选项后，当输入后括号时，光标会跳 回前括号片刻，然后
"跳回来，以此显示括号的配对情况
set showmatch 	
set matchtime=2

"状态栏
"set statusline format 
set cmdheight=1 "命令行占一行
set laststatus=2 "显示状态栏
highlight statusline guifg=SlateBlue guibg=Yellow
highlight statuslineNC guifg=Gray guibg=White
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]

"""""""""""""""""""""""折叠"""""""""""""""""""""""""""""""""""""""""""""""
set foldmethod=manual
set foldlevel=0	"初始时不折叠
set foldcolumn=0
set foldenable
"空格折叠键
"nnoremap <space> @= ((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR> 

"<F3>给文件加上日期
map <F3> :read !date<CR>

"set cursorline "整行标颜色
"set cursorcolumn "整列标注颜色

"+++++++++++++VIM中文编码设置

" 1. encoding 是VIM内部使用的字符编码方式。设置了它之后，VIM内部所有的buffer, 
"    寄存器、脚本中的字符串等都使用这个编码。VIM在工作的时候，如果编码方式与它
"    的内部编码不一致，它会先把编码转换成内部编码。如果工作用的编码含有无法转换
"    为内部编码的字符，则这些字符就会丢失。因此，内部编码一定要使用一种表现能力
"    足够强的编码。
set encoding=utf-8

" 2. termencoding 是VIM用于屏幕显示的编码，在显示的时候VIM会把内部编码转换
"    为屏幕编码，再用于输出。内部编码中含有无法转换为屏幕编码的字符时，该字符会
"    变成问号，但不会影响对它的编辑操作。如果termencoding没有设置，则直接使用
"    encoding，不进行转换。
" let &termencoding=&encoding
set termencoding=utf-8

" 3. fileencoding VIM从磁盘上读取文件的时候，会对文件的编码进行探测。如果文件
"    的编码方式和VIM的内部编码不同，VIM就会对编码进行转换。转换完毕后，VIM会
"    将fileencoding设置为文件的编码。当VIM存盘的时候，如果encoding和fileencoding
"    不一样，则会进行编码转换。因此，通过打开文件后设置fileencoding,可以将文件
"    由一种编码转换为另一种编码。但fileencoding是在打开文件的时候，由VIM进行
"    探测后自动设置的。因此，如果出现乱码，我们无法通过 在打开文件后重新设置
"    fileencoding来纠正乱码。

" 4. fileencodings 编码的自动识别是通过fileencodings实现的。用一个逗号分隔。
"    当打开文件的时候，VIM按顺序使用其中的编码尝试解码，如果成功的话，就使用该
"    编码方式进行解码，并将fileencoding设置为这个值，如果失败的话，就继续试验下
"    一个编码。所以在设置时，一定要把要求严格的，当文件不是这个编码的时候更容易
"    出现解码失败的编码方式放在前面，把宽松的编码放在后面。
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

set incsearch 		"查找匹配
set sessionoptions+=resize

if has("gui_running")
	colorscheme desertEx " 背景颜色
	"colorscheme rainbow_neon 		" 背景颜色
	set guifont=Bitstream\ Vera\ Sans\ Mono\ 14	"gvim字体设置
	"<F2>显隐状态栏
	set guioptions=aegimtT
	set guioptions-=r
	set guioptions-=l
	set guioptions-=m
	set guioptions-=T
	set lines=20 columns=80
	map <silent> <F2> :if &guioptions =~# 'T' <Bar>
				\ set guioptions-=T <Bar>
				\ set guioptions-=m <Bar>
			\ else <Bar>
				\ set guioptions+=T <Bar>
				\ set guioptions+=m <Bar>
			\ endif<CR>
else
	colorscheme desert_mei " 背景颜色
endif

"中文帮助
set helplang=cn

set completeopt=longest,menu,menuone

"打开语法打开补全
setlocal omnifunc=syntaxcomplete#Complete

set mouse=a


""""""""""""""""""""""""""窗口最大化""""""""""""""""""""""""""""""""
"function Maximize_Window()
"	silent !wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
"endfunction

""""""""""""""""""""""""""插件配置"""""""""""""""""""""""""""""""""""
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1

let g:winManagerWindowLayout='FileExplorer|TagList'
nmap mm :WMToggle<cr>

if has("autocmd")
  filetype plugin on
  augroup vimrcEx
  au!
  "光标自动到上次退出该文件时所在位置
  autocmd FileType text setlocal textwidth=78 fo+=MmB
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
  augroup END
else
  set autoindent		" always set autoindenting on
endif " has("autocmd")

"打开断行模式对亚洲语言的支持，m表示允许在两个汉字之间断行，
"即使汉字间没有出现空格
"B表示将两行合并为一行的时候，汉字与汉字之间不要补空格
set tw=78 fo+=MmB

"set visualbell 	"用闪烁代替响铃
"set novisualbell 	"用响铃代替闪烁
set noeb 		"noerrorbells的缩写

map <C-h> :tabp<CR>
map <C-l> :tabn<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cscope
if has("cscope")
	set csprg=/usr/bin/cscope
	set cst
	set csto=0
	set nocsverb
	if filereadable("cscope.out")
		cs add cscope.out
	elseif $CSCOPE_DB != ""
		cs add $CSCOPE_DB
	endif
	set csverb
endif

""""""""""""""""""""""""""""""""""""""""""""""""""
" vimwiki
let g:vimwiki_use_mouse = 1
let g:vimwiki_list_ignore_newline = 0
let g:vimwiki_hl_headers = 0
" vimwiki打开折叠
"let g:vimwiki_folding = 1
let g:vimwiki_camel_case = 0
let g:vimwiki_list_ignore_newline = 0
let g:vimwiki_CJK_length = 1

"设定文件浏览器目录为当前目录
set bsdir=buffer 	
"set autochdir

" 日历插件
map ca :Calendar<cr>

map <S-Space> :<C-Space>

" vimwiki
let g:vimwiki_list = [{'path': '~/wiki/wiki/', 'path_html': '~/wiki/', 'auto_export': 1}]
" 转化为Html文件
map <S-F4> :Vimwiki2HTML<cr>

" 设置颜色
hi VimwikiHeader1 guifg=#FF0000
hi VimwikiHeader2 guifg=#00FF00
hi VimwikiHeader3 guifg=#0000FF
hi VimwikiHeader4 guifg=#FF00FF
hi VimwikiHeader5 guifg=#00FFFF
hi VimwikiHeader6 guifg=#FFFF00

