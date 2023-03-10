local opt = vim.opt --for conciseness
--line numbers
opt.relativenumber = true
opt.number = true

--tab and identation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

--line wrapping
opt.wrap =false

--search settings
opt.ignorecase = true
opt.smartcase = true

--cursor line
--This is for appear a line under the active cursor
opt.cursorline = false

--appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

--backspace
--this make the backspace work propiertly
opt.backspace = "indent,eol,start"

--clipboard
--This "force" nvim to use the clipboard of the PC
opt.clipboard:append("unnamedplus")

--split windows
opt.splitright = true
opt.splitbelow = true
