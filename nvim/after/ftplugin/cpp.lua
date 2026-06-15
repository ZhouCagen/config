-- C++ 不自动换行注释
vim.opt_local.textwidth = 0
vim.opt_local.wrapmargin = 0

-- t: 自动换行普通文本
-- c: 自动换行注释
-- r: 回车后自动补注释符号
-- o: 用 o/O 新开行后自动补注释符号
-- a: 自动格式化段落
vim.opt_local.formatoptions:remove({ "t", "c", "r", "o", "a" })
