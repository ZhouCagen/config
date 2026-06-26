return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.inlay_hints = {
        enabled = false,
      }

      opts.servers = opts.servers or {}
      opts.servers.omnisharp = opts.servers.omnisharp or {}

      opts.servers.omnisharp.on_attach = function(client, bufnr)
        client.server_capabilities.inlayHintProvider = false
      end
    end,
  },

  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}

      -- C# 先不让 conform 管，避免保存就弹 Formatter failed
      opts.formatters_by_ft.cs = nil
      opts.formatters_by_ft.cshtml = nil
    end,
  },
}
