return {
  -- add pyright to lspconfig
  -- {
  --   "neovim/nvim-lspconfig",
  --   -- @class PluginLspOpts
  --   opts = {
  --     -- @type lspconfig.options
  --     servers = {
  --       -- pyright will be automatically installed with mason and loaded with lspconfig
  --       ruff = {},
  --       pyright = {},
  --       -- pylyzer = {},
  --     },
  --   },
  -- },

  -- {
  --   "WhoIsSethDaniel/mason-tool-installer.nvim",
  --   dependencies = {
  --     { "williamboman/mason.nvim", opts = true },
  --     { "williamboman/mason-lspconfig.nvim", opts = true },
  --   },
  --   opts = {
  --     ensure_installed = {
  --       "pyright", -- LSP for python
  --       "ruff", -- linter & formatter (includes flake8, pep8, black, isort, etc.)
  --       -- "debugpy", -- debugger
  --       -- "taplo", -- LSP for toml (e.g., for pyproject.toml files)
  --     },
  --   },
  -- },

  -- Setup the LSPs
  -- `gd` and `gr` for goto definition / references
  -- `<C-f>` for formatting
  -- `<leader>c` for code actions (organize imports, etc.)
  {
    "neovim/nvim-lspconfig",
    keys = {
      -- { "gd", vim.lsp.buf.definition, desc = "Goto Definition" },
      -- { "gr", vim.lsp.buf.references, desc = "Goto References" },
      -- { "<leader>c", vim.lsp.buf.code_action, desc = "Code Action" },
      -- { "<C-f>", vim.lsp.buf.format, desc = "Format File" },
    },
    opts = {
      -- @type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        ruff = {},
        pyright = {},
        -- pylyzer = {},
      },
    },
    init = function()
      -- this snippet enables auto-completion
      local lspCapabilities = vim.lsp.protocol.make_client_capabilities()
      lspCapabilities.textDocument.completion.completionItem.snippetSupport = true

      -- setup pyright with completion capabilities
      require("lspconfig").pyright.setup({
        capabilities = lspCapabilities,
      })

      -- setup taplo with completion capabilities
      require("lspconfig").taplo.setup({
        capabilities = lspCapabilities,
      })

      -- ruff uses an LSP proxy, therefore it needs to be enabled as if it
      -- were a LSP. In practice, ruff only provides linter-like diagnostics
      -- and some code actions, and is not a full LSP yet.
      require("lspconfig").ruff.setup({
        -- disable ruff as hover provider to avoid conflicts with pyright
        on_attach = function(client)
          client.server_capabilities.hoverProvider = false
        end,
      })
    end,
  },

  { import = "lazyvim.plugins.extras.lang.python" },

  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        -- "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "java",
        "ruby",
        "go",
        "query",
        "regex",
        -- "tsx",
        -- "typescript",
        "vim",
        "yaml",
      },
    },
  },
}
