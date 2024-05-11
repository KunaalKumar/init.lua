return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,

    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },

    config = function()
        local function my_on_attach(bufnr)
            local api = require("nvim-tree.api")

            local function opts(desc)
                return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end

            api.config.mappings.default_on_attach(bufnr)

            -- your removals and mappings go here
            vim.keymap.set("n", "<C-e>", api.tree.close, opts("Close"))
            vim.api.nvim_set_keymap("n", "<C-e>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
        end

        require("nvim-tree").setup({
            on_attach = my_on_attach,
        })

    end
}
