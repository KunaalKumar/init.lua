return {
  "freddiehaddad/feline.nvim",
  config = function()
    local ctp_feline = require('catppuccin.groups.integrations.feline')

    ctp_feline.setup({
      view = {
        lsp = {
          name = true,
        },
      },
    })

    require("feline").setup({
      components = ctp_feline.get(),
    })
  end
}
