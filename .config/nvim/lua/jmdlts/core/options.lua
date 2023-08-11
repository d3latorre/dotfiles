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
opt.wrap = false

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
--opt.clipboard = "unnamedplus"
if vim.fn.has('wsl') == 1 then
    opt.clipboard = {
        name = 'WslClipboard',
        copy = {
            ['+'] = 'clip.exe',
            ['*'] = 'clip.exe',
        },
        paste = {
            ['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
            ['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
        },
        cache_enabled = 0,
    }
else
    opt.clipboard = "unnamedplus"
end

--split windows
opt.splitright = true
opt.splitbelow = true

--sign column
opt.signcolumn = 'yes'

-- mouse mode
opt.mouse = 'a'
