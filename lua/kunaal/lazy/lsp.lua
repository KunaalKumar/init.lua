return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "folke/neodev.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/nvim-cmp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },

    config = function()
      local cmp = require('cmp')
      local cmp_lsp = require("cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        cmp_lsp.default_capabilities())

      require("mason").setup()
      -- IMPORTANT: make sure to setup neodev BEFORE lspconfig
      require("neodev").setup({
        -- add any options here, or leave empty to use the default settings
      })
      require("mason-lspconfig").setup({
        handlers = {
          function(server_name) -- default handler (optional)
            require("lspconfig")[server_name].setup {
              capabilities = capabilities
            }
          end,

          ["lua_ls"] = function()
            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup {
              capabilities = capabilities,
              settings = {
                Lua = {
                  runtime = { version = "Lua 5.4.6" },
                  diagnostics = {
                    globals = { "vim", "it", "describe", "before_each", "after_each" },
                  }
                }
              }
            }
          end,

          ["typos_lsp"] = function()
            local lspconfig = require("lspconfig")
            lspconfig.typos_lsp.setup {
              capabilities = capabilities,
            }
          end,
        }
      })

      local util = require 'lspconfig.util'
      local lspconfig = require("lspconfig")
      lspconfig.dartls.setup {
        capabilities = capabilities,
        cmd = { "dart", "language-server", "--lsp" },
        filetypes = { "dart" },
        root_dir = util.root_pattern "pubspec.yaml",
        init_options = {
          onlyAnalyzeProjectsWithOpenFiles = true,
          suggestFromUnimportedLibraries = true,
          closingLabels = true,
          outline = true,
          flutterOutline = true,
          enableExperimentation = true,
          enableNullSafety = true,
        },
        settings = {
          dart = {
            completeFunctionCalls = true,
            showTodos = true,
            enableSdkFormatter = true,
          },
        },
      }

      local cmp_select = { behavior = cmp.SelectBehavior.Select }

      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
          ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
          ['<Tab>'] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' }, -- For luasnip users.
        }, {
          { name = 'buffer' },
        })
      })

      vim.diagnostic.config({
        -- update_in_insert = true,
        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      })
    end
  },

  {
    "dart-lang/dart-vim-plugin",
    config = function()
      vim.g.dart_style_guide = 2
      vim.g.dart_html_in_string = true
      vim.g.dart_trailing_comma_indent = true
      vim.g.dartfmt_options = { "--fix" }
    end
  },
}
