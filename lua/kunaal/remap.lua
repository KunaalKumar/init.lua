vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader><tab>", "<C-^>", {noremap=true})
--
--vim.keymap.set("n", "<C-e>", ":Lexplore %:p:h<CR>", {noremap=true})
vim.keymap.set("n", "<C-e>", function()
    -- Look for a netrw window and if found, close it.
    local windows = vim.api.nvim_list_wins()
    for _, win in ipairs(windows) do
        local buf = vim.api.nvim_win_get_buf(win)
        local filetype = vim.api.nvim_buf_get_option(buf, "filetype")
        if filetype == "netrw" then
            vim.api.nvim_win_close(win, false)
            return
        end
    end
    
    -- If a netrw window wasn't found open one.
    local current_file_name = vim.fn.expand("%:t")
    vim.cmd("Lexplore %:p:h")
    vim.cmd("/" .. current_file_name)
end, {noremap=true})

vim.keymap.set("n", "<leader>w", ":w<CR>")

