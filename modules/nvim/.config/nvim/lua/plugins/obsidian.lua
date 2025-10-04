return {
  "epwalsh/obsidian.nvim",
  version = "*", -- latest release
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/Documents/ObsidianVault", -- change to your vault path
      },
    },
    daily_notes = {
      folder = "Journal/dailies",
      date_format = "%Y-%m-%d",
    },
    completion = {
      nvim_cmp = true, -- integrate with nvim-cmp if you're using it
    },
  },
  keys = {
    { "<leader>on", "<cmd>ObsidianNew<CR>", desc = "New Obsidian note" },
    { "<leader>oo", "<cmd>ObsidianQuickSwitch<CR>", desc = "Open Obsidian note" },
    { "<leader>ot", "<cmd>ObsidianToday<CR>", desc = "Today’s daily note" },
  },
}
