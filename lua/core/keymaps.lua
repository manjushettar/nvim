-- ~/.config/nvim/lua/core/keymaps.lua
local map = vim.keymap.set

-- Markdown Preview mappings
map('n', '<C-s>', '<Plug>MarkdownPreview', {})
map('n', '<M-s>', '<Plug>MarkdownPreviewStop', {})
map('n', '<C-p>', '<Plug>MarkdownPreviewToggle', {})

-- NERDTree mappings
map('n', '<leader>n', ':NERDTreeFocus<CR>', {})
map('n', '<C-n>', ':NERDTree<CR>', {})
map('n', '<C-t>', ':NERDTreeToggle<CR>', {})
map('n', '<C-f>', ':NERDTreeFind<CR>', {})

map('n', '<leader>h', ':Alpha<CR>', { noremap = true, silent = true })

