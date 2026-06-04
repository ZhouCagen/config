vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.confirm = true
vim.opt.termguicolors = true

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smartindent = true

vim.g.autoformat = true

-- 只显示错误，不显示警告/提示/信息
local function onlyShowErrors()
  vim.diagnostic.config({
    virtual_text = {
      severity = { min = vim.diagnostic.severity.ERROR },
    },
    signs = {
      severity = { min = vim.diagnostic.severity.ERROR },
    },
    underline = {
      severity = { min = vim.diagnostic.severity.ERROR },
    },
    float = {
      severity = { min = vim.diagnostic.severity.ERROR },
    },
    severity_sort = true,
  })
end

onlyShowErrors()

vim.api.nvim_create_autocmd("VimEnter", {
  callback = onlyShowErrors,
})
