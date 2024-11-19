local opt = vim.opt

-- General settings
opt.autoindent = true
opt.hidden = true
opt.number = true
opt.incsearch = true
opt.ruler = true
opt.wildmenu = true

-- Tab settings
opt.shiftwidth = 4
opt.smarttab = true
opt.expandtab = true
opt.tabstop = 8
opt.softtabstop = 0

-- Cursor settings
opt.guicursor = "n-v-c:block-Cursor/lCursor,i:ver25-CursorInsert/lCursorInsert,r-cr:hor20-CursorReplace/lCursorReplace"

-- Status line
opt.laststatus = 2

opt.termguicolors = true

vim.g.t_Co = 256
-- Syntax and filetype
vim.cmd('syntax on')
vim.cmd('filetype plugin indent on')

-- Regex engine
opt.regexpengine = 0
