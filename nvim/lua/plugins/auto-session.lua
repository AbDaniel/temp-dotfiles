return {
  "rmagatti/auto-session",
  lazy = false,
  enabled = true,

  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    suppressed_dirs = { "~/", "~/Workspace/", "~/Downloads", "/", "~/Documents/" },
    -- log_level = 'debug',
  },
}
