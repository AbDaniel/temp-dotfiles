if true then
  return {}
end

return {
  "rmagatti/auto-session",
  lazy = false,

  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    suppressed_dirs = { "~/", "~/Workspace/", "~/Downloads", "/" },
    -- log_level = 'debug',
  },
}
