return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    -- config = function()
    --   vim.cmd("colorscheme tokyonight")
    -- end,
  },

  {
    "olimorris/onedarkpro.nvim",
    lazy = true,
  },
  -- {
  --   "navarasu/onedark.nvim",
  --   lazy = true,
  --   config = function()
  --     require("onedark").setup({
  --       -- style = "cool",
  --     })
  --   end,
  -- },

  {
    "mhartington/oceanic-next",
    -- priority = 1000,
  },

  {
    "oxfist/night-owl.nvim",
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
  },
  -- catppuccin
  {
    "catppuccin/nvim",
    lazy = false,
    -- lazy = true,
    -- name = "catppuccin",
    -- opts = {
    --   integrations = {
    --     aerial = true,
    --     alpha = true,
    --     cmp = true,
    --     dashboard = true,
    --     flash = true,
    --     grug_far = true,
    --     gitsigns = true,
    --     headlines = true,
    --     illuminate = true,
    --     indent_blankline = { enabled = true },
    --     leap = true,
    --     lsp_trouble = true,
    --     mason = true,
    --     markdown = true,
    --     mini = true,
    --     native_lsp = {
    --       enabled = true,
    --       underlines = {
    --         errors = { "undercurl" },
    --         hints = { "undercurl" },
    --         warnings = { "undercurl" },
    --         information = { "undercurl" },
    --       },
    --     },
    --     navic = { enabled = true, custom_bg = "lualine" },
    --     neotest = true,
    --     neotree = true,
    --     noice = true,
    --     notify = true,
    --     semantic_tokens = true,
    --     telescope = true,
    --     treesitter = true,
    --     treesitter_context = true,
    --     which_key = true,
    --   },
    -- },
    -- specs = {
    --   {
    --     "akinsho/bufferline.nvim",
    --     optional = true,
    --     opts = function(_, opts)
    --       if (vim.g.colors_name or ""):find("catppuccin") then
    --         opts.highlights = require("catppuccin.groups.integrations.bufferline").get()
    --       end
    --     end,
    --   },
    -- },
  },

  -- {
  --   "LazyVim/LazyVim",
  --   opts = {
  --     colorscheme = "oceanic-next",
  --   },
  -- },
}
