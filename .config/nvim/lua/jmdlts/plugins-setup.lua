---------------------
-- LUA SETUP
---------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { import = "jmdlts.plugins" },
}, {})
---------------------------------
-- nvim tree
require("jmdlts.plugconfig.nvimtree")

--nvimtreesitter
require("jmdlts.plugconfig.treesitter")

-- LSP
require("jmdlts.plugconfig.lspandmason")

-- CMP
require("jmdlts.plugconfig.cmp")
