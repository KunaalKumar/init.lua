return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "macchiato",
        transparent_background = true,
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          mason = true,
          harpoon = true,
          dropbar = {
            enabled = true,
            color_mode = true,
          },
          hop = true,
          markdown = true,
          lsp_trouble = true,
          illuminate = {
            enabled = true,
            lsp = true,
          },
          which_key = true,
        }
      })

      vim.cmd.colorscheme "catppuccin"
    end
  },
}
