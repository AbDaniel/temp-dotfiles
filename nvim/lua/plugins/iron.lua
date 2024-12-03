return {
  "Vigemus/iron.nvim",
  keys = {
    { "<leader>i", vim.cmd.IronRepl, desc = "󱠤 Toggle REPL" },
    { "<leader>I", vim.cmd.IronRestart, desc = "󱠤 Restart REPL" },

    -- these keymaps need no right-hand-side, since that is defined by the
    -- plugin config further below
    { "+", mode = { "n", "x" }, desc = "󱠤 Send-to-REPL Operator" },
    { "++", desc = "󱠤 Send Line to REPL" },
  },

  -- since irons's setup call is `require("iron.core").setup`, instead of
  -- `require("iron").setup` like other plugins would do, we need to tell
  -- lazy.nvim which module to via the `main` key
  main = "iron.core",

  opts = {
    keymaps = {
      send_line = "++",
      visual_send = "+",
      send_motion = "+",
    },
    config = {
      -- This defines how the repl is opened. Here, we set the REPL window
      -- to open in a horizontal split to the bottom, with a height of 10.
      repl_open_cmd = "vertical botright 40 split",

      -- This defines which binary to use for the REPL. If `ipython` is
      -- available, it will use `ipython`, otherwise it will use `python3`.
      -- since the python repl does not play well with indents, it's
      -- preferable to use `ipython` or `bypython` here.
      -- (see: https://github.com/Vigemus/iron.nvim/issues/348)
      repl_definition = {
        python = {
          command = { "uv", "run", "ipython", "--no-autoindent" },
          -- format = require("iron.fts.common").bracketed_paste_python,
        },
      },
    },
  },
}

--   "Vigemus/iron.nvim",
--   config = function()
--     require("iron.core").setup({
--       config = {
--         -- Whether a repl should be discarded or not
--         scratch_repl = true,
--         -- Your repl definitions come here
--         repl_definition = {
--           sh = {
--             -- Can be a table or a function that
--             -- returns a table (see below)
--             command = { "zsh" },
--           },
--           python = {
--             command = { "uv", "run", "ipython", "--no-autoindent" },
--             format = require("iron.fts.common").bracketed_paste_python,
--           },
--         },
--         -- How the repl window will be displayed
--         -- See below for more information
--         repl_open_cmd = require("iron.view").split.vertical.botright(50),
--         -- repl_open_cmd = "vertical botright 80 split"
--         -- repl_open_cmd = require("iron.view").vertical.botright(50),
--       },
--       -- Iron doesn't set keymaps by default anymore.
--       -- You can set them here or manually add keymaps to the functions in iron.core
--       keymaps = {
--         send_motion = "<space>sc",
--         visual_send = "<space>sc",
--         send_file = "<space>sf",
--         send_line = "<space>sl",
--         send_paragraph = "<space>sp",
--         send_until_cursor = "<space>su",
--         send_mark = "<space>sm",
--         mark_motion = "<space>mc",
--         mark_visual = "<space>mc",
--         remove_mark = "<space>md",
--         cr = "<space>s<cr>",
--         interrupt = "<space>s<space>",
--         exit = "<space>sq",
--         clear = "<space>cl",
--       },
--       -- If the highlight is on, you can change how it looks
--       -- For the available options, check nvim_set_hl
--       highlight = {
--         italic = true,
--       },
--       ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
--     })
--   end,
-- }
