local options = {

  base46 = {
    theme = "onedark",
    hl_add = {},
    hl_override = {},
    integrations = {},
    changed_themes = {},
    -- transparency = false,
    transparency = true,
  },

  ui = {
    cmp = {
      icons = true,
      lspkind_text = true,
      style = "flat_dark", -- default/flat_light/flat_dark/atom/atom_colored
    },

    telescope = { style = "borderless" }, -- borderless / bordered

    -- lazyload it when there are 1+ buffers
    tabufline = {
      enabled = false,
      lazyload = true,
      order = { "treeOffset", "buffers", "tabs", "btns" },
      modules = nil,
    },

    nvdash = {
      load_on_startup = true,
    },
  },

  term = {
    winopts = { number = false, relativenumber = false },
    sizes = { sp = 0.3, vsp = 0.2, ["bo sp"] = 0.3, ["bo vsp"] = 0.2 },
    float = {
      relative = "editor",
      row = 0.3,
      col = 0.25,
      width = 0.5,
      height = 0.4,
      border = "single",
    },
  },

  lsp = { signature = true },

  cheatsheet = {
    theme = "grid", -- simple/grid
    excluded_groups = { "terminal (t)", "autopairs", "Nvim", "Opens" }, -- can add group name or with mode
  },

  mason = { cmd = true, pkgs = {} },
}

local status, chadrc = pcall(require, "chadrc")
return vim.tbl_deep_extend("force", options, status and chadrc or {})