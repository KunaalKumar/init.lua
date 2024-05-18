vim.keymap.set("n", "<leader><tab>", "<C-^>", { noremap = true })
vim.keymap.set("n", "<S-Tab>", "<C-^>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "save" })
-- Yank to macOS clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
-- Format using LSP
-- vim.keymap.set({ "n", "v" }, "gg=G", "<cmd>lua  vim.lsp.buf.format({ async = true })<CR>",
--     { noremap = true, silent = true })

local autocmd = vim.api.nvim_create_autocmd

-- If a window exists to the right of the current window, returns it; else returns nil.
local function find_right_vertical_split()
    local current_win = vim.api.nvim_get_current_win()
    local current_win_position = vim.api.nvim_win_get_position(current_win)
    local current_win_width = vim.api.nvim_win_get_width(current_win)

    -- Scan all windows in the current tab page
    local windows = vim.api.nvim_list_wins()
    for _, win in ipairs(windows) do
        if win ~= current_win then -- Skip the current window
            local win_position = vim.api.nvim_win_get_position(win)

            -- Check if the window is vertically aligned and to the right
            if win_position[2] > current_win_position[2] + current_win_width then
                return win
            end
        end
    end
    return nil -- No vertical split to the right found
end

local function open_file(win, file, line, column)
    -- Ensure window and file are provided.
    if win == nil or file == nil then
        print("Window and file must be provided")
        return
    end

    vim.api.nvim_set_current_win(win)

    vim.api.nvim_command("edit " .. file)

    if line then
        vim.api.nvim_win_set_cursor(win, { line, column or 0 })
    end
end

autocmd("LspAttach", {
    callback = function(e)
        -- Enable by inlay hints default.
        vim.lsp.inlay_hint.enable(true, {})
        -- Run code lens on startup.
        vim.lsp.codelens.run()

        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition({ reuse_win = true }) end, opts)
        vim.keymap.set("n", "gD", function()
            vim.lsp.buf.definition({
                on_list = function(options)
                    -- if there are multiple items, warn the user
                    if #options.items > 1 then
                        vim.notify("Multiple items found, opening first one", vim.log.levels.WARN)
                    end

                    -- Open the first item in a vertical split
                    local item = options.items[1]
                    local win = find_right_vertical_split()
                    if win == nil then
                        vim.cmd("vsplit | wincmd l")
                        win = vim.api.nvim_get_current_win()
                    end
                    open_file(win, item.filename, item.lnum, item.col)
                end,
            })
        end, opts)

        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "<C-.>", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
        vim.keymap.set("n", "<leader>h", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
            print("Inlay hint status: " .. tostring(vim.lsp.inlay_hint.is_enabled()))
        end, { desc = "Toggle inlay hints" })

        -- iTerm2 Remaps
        vim.keymap.set("n", "_-NvimCodeActionsRemap-_", function() vim.lsp.buf.code_action() end, opts)
    end
})

autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end
})

vim.api.nvim_create_user_command("Wnof", function()
    vim.b.disable_autoformat = true
    vim.cmd("write")
    vim.b.disable_autoformat = false
end, { bang = true })

autocmd("BufWritePre", {
    desc = "Format on save",
    callback = function()
        if not vim.b.disable_autoformat then
            vim.lsp.buf.format({ async = false })
        end
    end
})

autocmd("FileType", {
    desc = "Close the quickfix window with <ESC>",
    pattern = "qf",
    callback = function()
        vim.keymap.set("n", "<ESC>", ":cclose<CR>", { noremap = true, silent = true })
    end
})
