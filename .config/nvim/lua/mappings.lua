require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- nvim-tree toggle with focus behavior
local function smart_nvim_tree_toggle()
  local api = require("nvim-tree.api")
  
  -- Check if nvim-tree buffer exists and is visible
  local tree_wins = {}
  for _, win in pairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.api.nvim_buf_get_option(buf, 'filetype') == 'NvimTree' then
      table.insert(tree_wins, win)
    end
  end
  
  if #tree_wins > 0 then
    -- Tree is visible
    if vim.bo.filetype == "NvimTree" then
      -- Currently focused on tree, close it
      api.tree.close()
    else
      -- Tree is visible but not focused, focus on it
      api.tree.focus()
    end
  else
    -- Tree is not visible, open it
    api.tree.open()
  end
end

map("n", "<leader>e", smart_nvim_tree_toggle, { desc = "Smart toggle file explorer" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
