-- 自动命令配置文件
-- 这个文件会在 LazyVim 的 VeryLazy 事件后自动加载
--
-- LazyVim 默认自带了一些 autocmd：
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- 你自己的 autocmd 可以写在这里
-- 写法一般是：vim.api.nvim_create_autocmd(...)
--
-- 如果想删除 LazyVim 默认的 autocmd，可以按组名删除
-- LazyVim 默认组名一般带 lazyvim_ 前缀
--
-- 例如：
-- vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- 关闭 Markdown 和普通文本文件的拼写检查
-- 作用：
--   1. 防止中文笔记被当成英文拼写错误
--   2. 去掉 Markdown 里的红色波浪线
--   3. 只影响 markdown 和 text 类型文件，不影响代码文件
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text" },
  callback = function()
    vim.opt_local.spell = false
  end,
})
