-- 快捷键入口
local map = vim.keymap.set

-- 通用快捷键选项
-- silent: 执行时不在命令行显示命令
-- desc: 给 which-key / snacks 这类插件显示说明
local function opts(desc)
  return {
    silent = true,
    desc = desc,
  }
end

-- ============================================================================
-- 基础操作
-- ============================================================================

-- 保存文件
map("n", "<C-s>", "<cmd>w<cr>", opts("保存"))

-- 退出当前窗口
map("n", "<leader>q", "<cmd>q<cr>", opts("退出"))

-- 插入模式下快速回到 normal 模式
map("i", "jj", "<Esc>", opts("退出插入模式"))

-- ============================================================================
-- C++ 编译运行
-- ============================================================================

-- 编译并运行当前 C++ 文件
local function compileAndRunCpp()
  -- 当前文件完整路径，例如 /home/zhoukaijun/code/main.cpp
  local file = vim.fn.expand("%:p")

  -- 输出文件路径，去掉后缀，例如 /home/zhoukaijun/code/main
  local out = vim.fn.expand("%:p:r")

  -- 如果当前 buffer 没有关联真实文件，直接退出
  if file == "" then
    print("当前没有文件")
    return
  end

  -- 编译前先保存
  vim.cmd("write")

  -- 拼接编译运行命令
  -- shellescape 用来处理路径里的空格、特殊字符
  local cmd = "g++ -std=c++23 -O2 "
    .. vim.fn.shellescape(file)
    .. " -o "
    .. vim.fn.shellescape(out)
    .. " && "
    .. vim.fn.shellescape(out)

  -- 在底部打开一个 12 行高的终端窗口
  vim.cmd("botright 12split")

  -- 在终端中执行编译运行命令
  vim.cmd("terminal " .. cmd)
end

-- normal 模式下按 F5 编译运行
map("n", "<F5>", compileAndRunCpp, opts("编译并运行 C++"))

-- insert 模式下按 F5，先退出插入模式，再编译运行
map("i", "<F5>", function()
  vim.cmd("stopinsert")
  compileAndRunCpp()
end, opts("编译并运行 C++"))

-- ============================================================================
-- 文件查找 / 全文搜索
-- ============================================================================

-- 查找文件
map("n", "<leader>ff", function()
  Snacks.picker.files({
    hidden = false,
    ignored = false,
  })
end, opts("查找文件"))

-- 全文搜索
map("n", "<leader>fg", function()
  Snacks.picker.grep()
end, opts("全文搜索"))

-- ============================================================================
-- Dashboard 首页
-- ============================================================================

-- 回到 Snacks 首页
map("n", "<leader>h", function()
  Snacks.dashboard()
end, opts("回到首页"))

-- ============================================================================
-- 编辑辅助
-- ============================================================================

-- 全选当前文件并复制到系统剪贴板
map("n", "<leader>a", function()
  -- gg 到文件开头，V 进入行选择，G 选到文件结尾
  vim.cmd("normal! ggVG")

  -- "+ 是系统剪贴板寄存器，y 是复制
  vim.cmd('normal! "+y')

  print("已全选并复制到系统剪贴板")
end, opts("全选并复制"))

-- ============================================================================
-- LSP
-- ============================================================================

-- 变量 / 函数 / 符号重命名
map("n", "<leader>rn", function()
  vim.lsp.buf.rename()
end, opts("变量重命名"))

-- ============================================================================
-- 快捷键帮助
-- ============================================================================

-- 搜索所有快捷键
map("n", "<leader>/", function()
  Snacks.picker.keymaps()
end, opts("搜索快捷键"))

require("config.keymapsZh")

-- Ctrl+V 粘贴系统剪贴板
vim.keymap.set("n", "<C-v>", '"+p', { desc = "从系统剪贴板粘贴" })
vim.keymap.set("i", "<C-v>", "<C-r>+", { desc = "从系统剪贴板粘贴" })
vim.keymap.set("v", "<C-v>", '"+p', { desc = "从系统剪贴板粘贴" })

-- Ctrl+Z 撤销
vim.keymap.set("n", "<C-z>", "u", { desc = "撤销" })
vim.keymap.set("i", "<C-z>", "<C-o>u", { desc = "撤销" })
vim.keymap.set("v", "<C-z>", "<Esc>u", { desc = "撤销" })
