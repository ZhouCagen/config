return {
  {
    "iamcco/markdown-preview.nvim",
    -- Load preview support before the first Markdown file is opened.
    lazy = false,
    init = function()
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 0
      vim.g.mkdp_refresh_slow = 0
      vim.g.mkdp_combine_preview = 1
      vim.g.mkdp_combine_preview_auto_refresh = 0

      local math_dir = vim.fs.normalize(vim.fn.expand("~/Code/work/docs/NCUT/math"))
      vim.api.nvim_create_autocmd("BufEnter", {
        group = vim.api.nvim_create_augroup("MathMarkdownPreview", { clear = true }),
        callback = function(args)
          vim.schedule(function()
            if not vim.api.nvim_buf_is_valid(args.buf) or vim.api.nvim_get_current_buf() ~= args.buf then
              return
            end
            local filename = vim.fs.normalize(vim.api.nvim_buf_get_name(args.buf))
            if vim.bo[args.buf].filetype == "markdown" and filename:sub(1, #math_dir + 1) == math_dir .. "/" then
              vim.fn["mkdp#util#open_preview_page"]()
            end
          end)
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "latex" } },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    config = function(_, opts)
      require("config.latex-preview").setup()
      require("render-markdown").setup(opts)
    end,
    opts = {
      render_modes = { "n", "c" },
      anti_conceal = { ignore = { latex = true } },
      win_options = {
        conceallevel = { default = 0, rendered = 2 },
        concealcursor = { default = "", rendered = "nc" },
        wrap = { default = true, rendered = true },
        linebreak = { default = true, rendered = true },
      },
      custom_handlers = {
        latex = { parse = function(ctx)
          return require("config.latex-preview").parse(ctx)
        end },
      },
      latex = {
        enabled = true,
        converter = { vim.fn.expand("~/.local/bin/nvim-utftex") },
        position = "center",
        top_pad = 0,
        bottom_pad = 0,
      },
    },
  },
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
