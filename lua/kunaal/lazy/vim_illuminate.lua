return {
  "RRethy/vim-illuminate",
  config = function()
    local opts = {
      -- providers: provider used to get references in the buffer, ordered by priority
      providers = {
        'lsp',
        'treesitter',
        'regex',
      },
      delay = 100,
    }
    require("illuminate").configure(opts)
  end
}
