local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
    {
        "nvim-lua/plenary.nvim",
    },
    {
        dir = vim.fn.stdpath("config") .. "/local/markdown-diagrams",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("markdown-diagrams").setup({
                image_dir = "img",
                prompts = {
                    diagram = [[
    Create a Mermaid diagram that visualizes the following text. 
    Focus on showing relationships and flow between key concepts.
    Respond ONLY with the Mermaid diagram code, nothing else.

    Text to visualize:
    %s
    ]],
                    summary = [[
    Provide a concise summary of the following text.
    Focus on key points and main ideas.
    Keep the summary clear and structured.

    Text to summarize:
    %s
    ]]
                }
            })
        end,
        cmd = { "GenerateDiagram", "SummarizeText" },
        keys = {
            { "<Leader>md", mode = "x", desc = "Generate diagram from selection" },
            { "<Leader>sum", mode = "x", desc = "Summarize text from selection" }
        },
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
        }
    },
    {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local alpha = require('alpha')
        local dashboard = require('alpha.themes.dashboard')

        -- Function to get date and time
        local function get_date()
            return os.date(" %d-%m-%Y   %H:%M:%S")
        end

        dashboard.section.header.val = {
            [[                                                                       ]],
            [[  _    _     __          ___  __  _______ _    _         _    _      ]],
            [[ | |  | |   /\ \        / / |/ / |__   __| |  | |  /\   | |  | |    ]],
            [[ | |__| |  /  \ \  /\  / /| ' /     | |  | |  | | /  \  | |__| |    ]],
            [[ |  __  | / /\ \ \/  \/ / |  <      | |  | |  | |/ /\ \ |  __  |    ]],
            [[ | |  | |/ ____ \  /\  /  | . \     | |  | |__| / ____ \| |  | |    ]],
            [[ |_|  |_/_/    \_\/  \/   |_|\_\    |_|   \____/_/    \_\_|  |_|    ]],
            [[                                                                       ]],
        }

        -- Set colors
        vim.api.nvim_set_hl(0, 'AlphaHeader', { fg = '#89b4fa' }) -- You can change the color here
        dashboard.section.header.opts.hl = 'AlphaHeader'
            -- Get info
        local function getInfo()
            local plugins = #vim.tbl_keys(require("lazy").plugins())
            local v = vim.version()
            local datetime = get_date()
            
            return {
                "                                   ",
                " " .. datetime,
                "                                   ",
                " " .. plugins .. " plugins installed",
                " Neovim v" .. v.major .. "." .. v.minor .. "." .. v.patch,
                "                                   ",
            }
        end

        -- Set menu
        dashboard.section.buttons.val = {
            dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
            dashboard.button("f", "  Find file", ":Files<CR>"),
            dashboard.button("r", "  Recent files", ":History<CR>"),
            dashboard.button("t", "  Find text", ":Rg<CR>"),
            dashboard.button("s", "  Settings", ":e $MYVIMRC <CR>"),
            dashboard.button("u", "  Update plugins", ":Lazy sync<CR>"),
            dashboard.button("q", "  Quit", ":qa<CR>"),
        }

        -- Set footer
        dashboard.section.footer.val = getInfo()

        -- Set colors
        vim.api.nvim_set_hl(0, 'AlphaHeader', { fg = '#89b4fa' })
        vim.api.nvim_set_hl(0, 'AlphaButtons', { fg = '#a6e3a1' })
        vim.api.nvim_set_hl(0, 'AlphaFooter', { fg = '#cba6f7' })

        -- Apply colors
        dashboard.section.header.opts.hl = 'AlphaHeader'
        dashboard.section.buttons.opts.hl = 'AlphaButtons'
        dashboard.section.footer.opts.hl = 'AlphaFooter'

        -- Set layout
        dashboard.config.layout = {
            { type = "padding", val = 2 },
            dashboard.section.header,
            { type = "padding", val = 2 },
            dashboard.section.buttons,
            { type = "padding", val = 2 },
            dashboard.section.footer,
        }

        -- Disable folding for alpha buffer
        vim.cmd([[
            autocmd FileType alpha setlocal nofoldenable
        ]])

        -- Setup alpha
        alpha.setup(dashboard.opts)
    end
}, 

    -- Theme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = false, -- Changed to false for richer colors
        dim_inactive = {
          enabled = true,
          shade = "dark",
          percentage = 0.15,
        },
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
          loops = { "italic" },
          functions = { "italic" },
          keywords = { "italic" },
          strings = { "italic" },
          variables = { "italic" },
          numbers = { "italic" },
          booleans = { "italic" },
          properties = { "italic" },
          types = { "italic" },
        },
        integrations = {
          treesitter = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
            },
          },
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          telescope = true,
          markdown = true,
          mason = true,
        }
      })
    end
  },

  -- Treesitter for better syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { 
          "lua", "vim", "vimdoc", "python", "cpp", 
          "javascript", "typescript", "html", "css" 
        },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
      })
    end
  },

  -- Status line
  {
    "vim-airline/vim-airline",
    dependencies = { "vim-airline/vim-airline-themes" },
    config = function()
      vim.g.airline_powerline_fonts = 1
      vim.g.airline_section_b = '%{getcwd()}'
      vim.g.airline_theme = 'catppuccin'  -- Changed to match catppuccin
      vim.g['airline#extensions#tabline#enabled'] = 1
      vim.g['airline#extensions#tabline#formatter'] = 'unique_tail'
    end,
  },
  
  -- File explorer
  {
    "preservim/nerdtree",
  },
  
  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npx --yes yarn install",
    config = function()
      vim.g.mkdp_refresh_slow = 0
      vim.g.mkdp_open_to_the_world = 0
      vim.g.mkdp_echo_preview_url = 1
      vim.g.mkdp_theme = 'dark'
      vim.g.mkdp_filetypes = {'markdown'}
      vim.g.mkdp_preview_options = {
        mkit = {},
        katex = {},
        uml = {},
        maid = {},
        disable_sync_scroll = 0,
        sync_scroll_type = 'middle',
        hide_yaml_meta = 1,
        sequence_diagrams = {},
        flowchart_diagrams = {},
        content_editable = false,
        disable_filename = 0,
        toc = {},
      }
    end,
  },
  
  -- Fuzzy finder
  {
    "junegunn/fzf",
    build = function()
      vim.fn["fzf#install"]()
    end,
    dependencies = { "junegunn/fzf.vim" },
    config = function()
      vim.g.fzf_vim = {
        preview_window = {'right,50%', 'ctrl-/'}
      }
    end,
  },
  
  -- REPL integration
  {
    "jpalardy/vim-slime",
    ft = "python",
    config = function()
      vim.g.slime_python_ipython = 1
    end,
  },
})
