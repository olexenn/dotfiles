local keymap = vim.keymap

keymap.set('n', 'x', '"_x')

-- Increment/decrement
keymap.set('n', '+', '<C-a>')
keymap.set('n', '-', '<C-x>')

-- Delete a word backwards
keymap.set('n', 'dw', 'vb"_d')

-- Select all
keymap.set('n', '<C-a>', 'gg<S-v>G')

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- New tab
keymap.set('n', 'te', ':tabedit')
-- Split window
keymap.set('n', 'ss', ':split<Return><C-w>w')
keymap.set('n', 'sv', ':vsplit<Return><C-w>w')
-- Move window
keymap.set('n', '<Space>', '<C-w>w')
keymap.set('', 'sh', '<C-w>h')
keymap.set('', 'sk', '<C-w>k')
keymap.set('', 'sj', '<C-w>j')
keymap.set('', 'sl', '<C-w>l')

-- Resize window
keymap.set('n', '<C-w><left>', '<C-w><')
keymap.set('n', '<C-w><right>', '<C-w>>')
keymap.set('n', '<C-w><up>', '<C-w>+')
keymap.set('n', '<C-w><down>', '<C-w>-')

-- Open Oil
keymap.set('n', "sf", ':Oil<CR>')

-- Diagnostic window
keymap.set('n', "[e", vim.diagnostic.open_float, { desc = "Show line diagnostic" })

-- Kill Compilation Pane
local function kill_comp_pane()
  local target_name = "compilation"

  local wins = vim.api.nvim_tabpage_list_wins(0)

  for _, win in ipairs(wins) do
    local buf = vim.api.nvim_win_get_buf(win)
    local buf_name = vim.api.nvim_buf_get_name(buf)
    local ft = vim.bo[buf].filetype

    if string.match(buf_name, target_name) or ft == target_name then
      vim.api.nvim_win_close(win, true)
      return
    end
  end
end

vim.api.nvim_create_user_command('KillCompPane', kill_comp_pane, {})
keymap.set('n', '<leader>ck', kill_comp_pane, { desc =  "KillCompPane" })
