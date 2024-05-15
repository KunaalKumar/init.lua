return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "lua", "luadoc", "bash", "vim", "vimdoc", "printf" },

      sync_install = false,
      auto_install = true,

      indent = {
        enable = true,
      },

      highlight = {
        enable = true,
        use_languagetree = true,
        additional_vim_regex_highlighting = false,
      },
    })
  end
}
