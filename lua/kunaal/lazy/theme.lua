return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        config = function()
            require("catppuccin").setup({
                transparent_background = true,
                show_end_of_buffer = false,
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    treesitter = true,
                    notify = false,
                    mason = true,
                }
            })
            vim.cmd.colorscheme "catppuccin"
        end
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        --config = function()
        --    require("rose-pine").setup({
        --        disable_background = true,
        --        styles = {
        --            bol = true,
        --            italic = false,
        --        },
        --    })

        --    vim.cmd("colorscheme rose-pine")
        --end
    },
}
