return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
    vim.keymap.set("n", "<leader>q", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

    -- Toggle previous & next buffers stored within Harpoon list
    --vim.keymap.set("n", "<C-S-p>", function() harpoon:list():prev() end, {noremap=true})
    vim.keymap.set("n", "_-NvimHarpoonPrev-_", function() harpoon:list():prev() end, { noremap = true })
    vim.keymap.set("n", "_-NvimHarpoonNext-_", function() harpoon:list():next() end, { noremap = true })
  end
}
