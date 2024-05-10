return {
    "tpope/vim-fugitive",

    config = function()
        vim.keymap.set("n", "<leader>gits", vim.cmd.Git);
    end
}
