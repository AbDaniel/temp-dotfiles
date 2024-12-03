return {
  {
    "neovim/nvim-lspconfig",
    keys = {
      -- { "gd", vim.lsp.buf.definition, desc = "Goto Definition" },
      -- { "gr", vim.lsp.buf.references, desc = "Goto References" },
      -- { "<leader>c", vim.lsp.buf.code_action, desc = "Code Action" },
      -- { "<C-f>", vim.lsp.buf.format, desc = "Format File" },
    },
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        ruff = {},
        -- ruff_lsp = {},
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

  -- { import = "lazyvim.plugins.extras.lang.python" },

  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      indent = { enable = true },
      ensure_installed = {
        "bash",
        "go",
        "html",
        "java",
        "json",
        "lua",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "ruby",
        -- "taplo",
        "vim",
        "yaml",
        -- "javascript",
        -- "tsx",
        -- "typescript",
      },
    },
  },
}
