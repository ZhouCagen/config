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

-- 自动记录当前项目根目录
local group = vim.api.nvim_create_augroup("AutoProjectCwd", {
  clear = true,
})

local function detect_root(file)
  if file == nil or file == "" then
    return nil
  end

  if vim.fn.isdirectory(file) == 1 then
    return file
  end

  return vim.fs.root(file, {
    ".git",
    "CMakeLists.txt",
    "compile_commands.json",
    "Makefile",
    "xmake.lua",
  }) or vim.fn.fnamemodify(file, ":h")
end

local function set_project_root(root)
  if root == nil or root == "" then
    return
  end

  root = vim.fs.normalize(root)

  vim.g.project_root = root
  vim.cmd.cd(vim.fn.fnameescape(root))

  local uv = vim.uv or vim.loop
  pcall(uv.chdir, root)
end

vim.api.nvim_create_autocmd({ "VimEnter", "BufEnter" }, {
  group = group,
  callback = function(args)
    if vim.bo[args.buf].buftype ~= "" then
      return
    end

    local file = vim.api.nvim_buf_get_name(args.buf)
    local root = detect_root(file)

    if root then
      set_project_root(root)
    end
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if client and client.name == "omnisharp" then
      client.server_capabilities.inlayHintProvider = false
    end
  end,
})
