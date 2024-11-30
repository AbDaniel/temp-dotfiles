return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  enabled = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup({
      view = {},
      update_root = false,
      focus = true,
    })
  end,
}
