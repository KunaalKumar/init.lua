return {
    'nvim-telescope/telescope.nvim', 
    tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' },

    config = function()
        require("telescope").setup({})

        local builtin = require('telescope.builtin')

        --vim.keymap.set('n', '<C-S-p>', builtin.find_files,{})

        -- fallback to find_files if git file search fails. 
        vim.keymap.set('n', '<C-p>', function()
            local success, git_files = pcall(builtin.git_files, {show_untracked=true})
            if not success then
                builtin.find_files({})
            end
        end)

        vim.keymap.set('n', '<leader>gs', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
    end
}
