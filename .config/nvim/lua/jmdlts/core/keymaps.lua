local keymap = vim.keymap -- for conciseness
---------------------
-- General Keymaps
---------------------
-- window management
keymap.set("n", "<leader>sv", "<C-w>v")       -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s")       -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=")       -- make split windows equal width & height
keymap.set("n", "<leader>sx", ":close<CR>")   -- close current split window
keymap.set("n", '<leader>mu', "<C-w><Up>")    -- move to above window
keymap.set("n", '<leader>ml', "<C-w><Left>")  -- move to left window
keymap.set("n", '<leader>md', "<C-w><Down>")  -- move to below window
keymap.set("n", '<leader>mr', "<C-w><Right>") -- move to right window
keymap.set("n", '<A-k>', "<C-w><Up>")         -- move to above window
keymap.set("n", '<A-j>', "<C-w><Down>")       -- move to below window
keymap.set("n", '<A-h>', "<C-w><Left>")       -- move to left window
keymap.set("n", '<A-l>', "<C-w><Right>")      -- move to right window
keymap.set('t', '<Esc>', [[<C-\><C-n>]])

---------------------
-- Plugin Keybinds
----------------------

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>") -- toggle file explorer

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")  -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>")   -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescop buffers<cr>")      -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")   -- list available help tags

-- Tabs
local opts = { noremap = true, silent = true }
-- Move to previous/next
keymap.set('n', '<A-,>', '<Cmd>BufferPrevious<CR>')
keymap.set('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)
-- Re-order to previous/next
keymap.set('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
keymap.set('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)
-- Goto buffer in position...
keymap.set('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
keymap.set('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
keymap.set('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
keymap.set('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
keymap.set('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
keymap.set('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
keymap.set('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
keymap.set('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
keymap.set('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
keymap.set('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)
-- Close buffer
keymap.set('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)
