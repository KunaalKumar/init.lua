return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.6",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local actions = require("telescope.actions")

    local options = {
      defaults = {
        vimgrep_arguments = {
          "rg",
          "-L",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        file_ignore_patterns = { "node_modules" },
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        path_display = { "truncate" },
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
        mappings = {
          n = { ["q"] = actions.close },
          i = {
            -- ["<ESC>"] = actions.close,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
          },
        },
      },

      extensions_list = { "themes", "terms" },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    }

    require("telescope").setup(options)

    local builtin = require("telescope.builtin")

    --vim.keymap.set("n", "<C-S-p>", builtin.find_files,{})

    -- fallback to find_fileea if git file search fails.
    vim.keymap.set("n", "<C-p>", function()
      local success, git_files = pcall(builtin.git_files, { show_untracked = true })
      if not success then
        builtin.find_files({})
      end
    end)

    vim.keymap.set("n", "<leader>gs", function()
      builtin.grep_string({
        search = vim.fn.input("Grep > ") })
    end)

    vim.keymap.set("n", "<leader>fs", function()
      local folder = vim.fn.input({
        prompt = "Search in folder > ",
        default = vim.fn.expand('%:p:h'),
        completion = "dir",
        history = "search",
      })
      builtin.grep_string({
        search = vim.fn.input("Grep > "),
        search_dirs = { folder }
      })
    end)

    vim.keymap.set("n", "_-NvimSearchOpenBuffers-_", "<cmd>Telescope current_buffer_fuzzy_find<CR>", {})
  end
}
