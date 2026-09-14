return {
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters = opts.linters or {}
      opts.linters["markdownlint-cli2"] = function()
        local linter = vim.deepcopy(require("lint.linters.markdownlint-cli2"))
        local docs = vim.fs.normalize(vim.fn.expand("~/Code/work/docs"))
        local filename = vim.fs.normalize(vim.api.nvim_buf_get_name(0))
        if filename:sub(1, #docs + 1) == docs .. "/" then
          -- stdin has no filename, so resolve the document's config explicitly.
          local config = vim.fs.find(".markdownlint.json", {
            path = vim.fs.dirname(filename),
            upward = true,
            stop = vim.fs.dirname(docs),
          })[1]
          if config then
            linter.args = { "--config", config, "-" }
            linter.cwd = vim.fs.dirname(config)
          end
        end
        return linter
      end
    end,
  },
}
