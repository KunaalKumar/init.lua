return {
  "github/copilot.vim",
  cond = vim.loop.os_uname().sysname ~= "Linux",
  config = function()
    vim.keymap.set('i', '<S-Tab>', 'copilot#Accept("\\<CR>")', {
      expr = true,
      replace_keycodes = false
    })
    vim.g.copilot_no_tab_map = true
  end
}
