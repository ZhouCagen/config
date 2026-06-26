return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        omnisharp = {
          settings = {
            FormattingOptions = {
              EnableEditorConfigSupport = true,
            },
            RoslynExtensionsOptions = {
              enableDecompilationSupport = true,
              enableImportCompletion = true,
              analyzeOpenDocumentsOnly = true,
            },
          },
          on_attach = function(client, bufnr)
            if client.name == "omnisharp" then
              client.server_capabilities.inlayHintProvider = false
            end
          end,
        },
      },
    },
  },
}
