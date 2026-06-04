-- ============================================================================
-- LazyVim 默认快捷键中文说明覆盖
-- 只覆盖 desc，不改快捷键功能
-- ============================================================================

local function setKeymapDesc(mode, lhs, desc)
  local modes = type(mode) == "table" and mode or { mode }

  for _, currentMode in ipairs(modes) do
    local currentMap = vim.fn.maparg(lhs, currentMode, false, true)

    if currentMap and next(currentMap) ~= nil then
      local rhs = nil

      if type(currentMap.callback) == "function" then
        rhs = currentMap.callback
      elseif currentMap.rhs and currentMap.rhs ~= "" then
        rhs = currentMap.rhs
      end

      if rhs then
        pcall(vim.keymap.del, currentMode, lhs)

        vim.keymap.set(currentMode, lhs, rhs, {
          desc = desc,
          silent = currentMap.silent == 1,
          expr = currentMap.expr == 1,
          remap = currentMap.noremap == 0,
          nowait = currentMap.nowait == 1,
        })
      end
    end
  end
end

local function addWhichKeyGroups()
  local ok, whichKey = pcall(require, "which-key")
  if not ok then
    return
  end

  whichKey.add({
    { "<leader>b", group = "缓冲区" },
    { "<leader>c", group = "代码" },
    { "<leader>d", group = "调试" },
    { "<leader>f", group = "文件/查找" },
    { "<leader>g", group = "Git" },
    { "<leader>q", group = "退出/会话" },
    { "<leader>r", group = "运行/重命名" },
    { "<leader>s", group = "搜索" },
    { "<leader>u", group = "界面开关" },
    { "<leader>w", group = "窗口" },
    { "<leader>x", group = "诊断/列表" },
    { "<leader><tab>", group = "标签页" },
  })
end

addWhichKeyGroups()

-- ============================================================================
-- 基础移动
-- ============================================================================

setKeymapDesc({ "n", "x" }, "j", "向下移动")
setKeymapDesc({ "n", "x" }, "<Down>", "向下移动")
setKeymapDesc({ "n", "x" }, "k", "向上移动")
setKeymapDesc({ "n", "x" }, "<Up>", "向上移动")

-- ============================================================================
-- 窗口跳转
-- ============================================================================

setKeymapDesc("n", "<C-h>", "跳到左侧窗口")
setKeymapDesc("n", "<C-j>", "跳到下方窗口")
setKeymapDesc("n", "<C-k>", "跳到上方窗口")
setKeymapDesc("n", "<C-l>", "跳到右侧窗口")

-- ============================================================================
-- 调整窗口大小
-- ============================================================================

setKeymapDesc("n", "<C-Up>", "增加窗口高度")
setKeymapDesc("n", "<C-Down>", "减小窗口高度")
setKeymapDesc("n", "<C-Left>", "减小窗口宽度")
setKeymapDesc("n", "<C-Right>", "增加窗口宽度")

-- ============================================================================
-- 移动行
-- ============================================================================

setKeymapDesc("n", "<A-j>", "当前行下移")
setKeymapDesc("n", "<A-k>", "当前行上移")
setKeymapDesc("i", "<A-j>", "当前行下移")
setKeymapDesc("i", "<A-k>", "当前行上移")
setKeymapDesc("v", "<A-j>", "选中内容下移")
setKeymapDesc("v", "<A-k>", "选中内容上移")

-- ============================================================================
-- Buffer / 缓冲区
-- ============================================================================

setKeymapDesc("n", "<S-h>", "上一个 Buffer")
setKeymapDesc("n", "<S-l>", "下一个 Buffer")
setKeymapDesc("n", "[b", "上一个 Buffer")
setKeymapDesc("n", "]b", "下一个 Buffer")
setKeymapDesc("n", "<leader>bb", "切换到上一个 Buffer")
setKeymapDesc("n", "<leader>`", "切换到上一个 Buffer")
setKeymapDesc("n", "<leader>bd", "删除当前 Buffer")
setKeymapDesc("n", "<leader>bo", "删除其他 Buffer")
setKeymapDesc("n", "<leader>bD", "删除 Buffer 和窗口")

-- ============================================================================
-- Esc / 搜索高亮
-- ============================================================================

setKeymapDesc({ "i", "n", "s" }, "<esc>", "退出并清除搜索高亮")
setKeymapDesc("n", "<leader>ur", "重绘屏幕 / 清除搜索高亮 / 更新 Diff")
setKeymapDesc({ "n", "x", "o" }, "n", "下一个搜索结果")
setKeymapDesc({ "n", "x", "o" }, "N", "上一个搜索结果")

-- ============================================================================
-- 保存 / Lazy / 新文件
-- ============================================================================

setKeymapDesc({ "i", "x", "n", "s" }, "<C-s>", "保存文件")
setKeymapDesc("n", "<leader>K", "查看关键字帮助")
setKeymapDesc("n", "<leader>l", "打开 Lazy 插件管理器")
setKeymapDesc("n", "<leader>fn", "新建文件")

-- ============================================================================
-- 缩进 / 注释
-- ============================================================================

setKeymapDesc("x", "<", "左缩进并保持选中")
setKeymapDesc("x", ">", "右缩进并保持选中")
setKeymapDesc("n", "gco", "在下方添加注释")
setKeymapDesc("n", "gcO", "在上方添加注释")

-- ============================================================================
-- Location List / Quickfix
-- ============================================================================

setKeymapDesc("n", "<leader>xl", "打开/关闭 Location List")
setKeymapDesc("n", "<leader>xq", "打开/关闭 Quickfix List")
setKeymapDesc("n", "[q", "上一个 Quickfix")
setKeymapDesc("n", "]q", "下一个 Quickfix")

-- ============================================================================
-- 代码 / LSP / 诊断
-- ============================================================================

setKeymapDesc({ "n", "x" }, "<leader>cf", "格式化代码")
setKeymapDesc("n", "<leader>cd", "查看当前行诊断")
setKeymapDesc("n", "]d", "下一个诊断")
setKeymapDesc("n", "[d", "上一个诊断")
setKeymapDesc("n", "]e", "下一个错误")
setKeymapDesc("n", "[e", "上一个错误")
setKeymapDesc("n", "]w", "下一个警告")
setKeymapDesc("n", "[w", "上一个警告")

-- ============================================================================
-- UI / 开关
-- ============================================================================

setKeymapDesc("n", "<leader>uf", "开关自动格式化")
setKeymapDesc("n", "<leader>uF", "开关强制格式化")
setKeymapDesc("n", "<leader>us", "开关拼写检查")
setKeymapDesc("n", "<leader>uw", "开关自动换行")
setKeymapDesc("n", "<leader>uL", "开关相对行号")
setKeymapDesc("n", "<leader>ud", "开关诊断显示")
setKeymapDesc("n", "<leader>ul", "开关行号")
setKeymapDesc("n", "<leader>uc", "开关 Conceal Level")
setKeymapDesc("n", "<leader>uA", "开关 Tabline")
setKeymapDesc("n", "<leader>uT", "开关 Treesitter")
setKeymapDesc("n", "<leader>ub", "切换亮色/暗色背景")
setKeymapDesc("n", "<leader>uD", "开关 Dim 模式")
setKeymapDesc("n", "<leader>ua", "开关动画")
setKeymapDesc("n", "<leader>ug", "开关缩进指示线")
setKeymapDesc("n", "<leader>uS", "开关平滑滚动")
setKeymapDesc("n", "<leader>uh", "开关 Inlay Hints")
setKeymapDesc("n", "<leader>ui", "查看当前位置语法/高亮信息")
setKeymapDesc("n", "<leader>uI", "查看 Treesitter 语法树")

-- ============================================================================
-- Debug / Profiler
-- ============================================================================

setKeymapDesc("n", "<leader>dpp", "开关性能分析器")
setKeymapDesc("n", "<leader>dph", "开关性能分析高亮")

-- ============================================================================
-- Git
-- ============================================================================

setKeymapDesc("n", "<leader>gg", "打开 LazyGit 项目根目录")
setKeymapDesc("n", "<leader>gG", "打开 LazyGit 当前目录")
setKeymapDesc("n", "<leader>gL", "Git 日志 当前目录")
setKeymapDesc("n", "<leader>gb", "查看当前行 Git Blame")
setKeymapDesc("n", "<leader>gf", "查看当前文件历史")
setKeymapDesc("n", "<leader>gl", "Git 日志")
setKeymapDesc({ "n", "x" }, "<leader>gB", "在浏览器打开 Git 地址")
setKeymapDesc({ "n", "x" }, "<leader>gY", "复制 Git 地址")

-- ============================================================================
-- 退出 / LazyVim 信息
-- ============================================================================

setKeymapDesc("n", "<leader>qq", "退出全部")
setKeymapDesc("n", "<leader>L", "查看 LazyVim 更新日志")

-- ============================================================================
-- 终端
-- ============================================================================

setKeymapDesc("n", "<leader>fT", "终端 当前目录")
setKeymapDesc("n", "<leader>ft", "终端 项目根目录")
setKeymapDesc({ "n", "t" }, "<C-/>", "终端 项目根目录")
setKeymapDesc({ "n", "t" }, "<C-_>", "终端 项目根目录")

-- ============================================================================
-- 分屏窗口
-- ============================================================================

setKeymapDesc("n", "<leader>-", "向下分屏")
setKeymapDesc("n", "<leader>|", "向右分屏")
setKeymapDesc("n", "<leader>wd", "关闭窗口")
setKeymapDesc("n", "<leader>wm", "最大化/还原当前窗口")
setKeymapDesc("n", "<leader>uZ", "最大化/还原当前窗口")
setKeymapDesc("n", "<leader>uz", "Zen 模式")

-- ============================================================================
-- Tab 标签页
-- ============================================================================

setKeymapDesc("n", "<leader><tab>l", "最后一个 Tab")
setKeymapDesc("n", "<leader><tab>o", "关闭其他 Tab")
setKeymapDesc("n", "<leader><tab>f", "第一个 Tab")
setKeymapDesc("n", "<leader><tab><tab>", "新建 Tab")
setKeymapDesc("n", "<leader><tab>]", "下一个 Tab")
setKeymapDesc("n", "<leader><tab>d", "关闭当前 Tab")
setKeymapDesc("n", "<leader><tab>[", "上一个 Tab")

-- ============================================================================
-- Snacks / Picker / Explorer
-- 这些可能来自 Snacks 插件配置，不一定在 LazyVim 默认 keymaps.lua 里
-- ============================================================================

setKeymapDesc("n", "<leader><space>", "查找文件 项目根目录")
setKeymapDesc("n", "<leader>e", "文件树 项目根目录")
setKeymapDesc("n", "<leader>E", "文件树 当前目录")
setKeymapDesc("n", "<leader>/", "全文搜索 项目根目录")
setKeymapDesc("n", "<leader>:", "命令历史")
setKeymapDesc("n", "<leader>n", "通知历史")
setKeymapDesc("n", "<leader>S", "选择 Scratch Buffer")
setKeymapDesc("n", "<leader>.", "开关 Scratch Buffer")

-- ============================================================================
-- Lua
-- ============================================================================

setKeymapDesc({ "n", "x" }, "<localleader>r", "运行 Lua")

-- ============================================================================
-- 插件快捷键中文说明补充
-- 来自当前 nvim-keymaps.tsv 导出结果
-- ============================================================================

local function applyExtraKeymapChineseDesc()
  -- BufferLine
  setKeymapDesc("n", "<leader>bP", "关闭未固定的 Buffer")
  setKeymapDesc("n", "<leader>bj", "选择 Buffer")
  setKeymapDesc("n", "<leader>bl", "删除左侧 Buffer")
  setKeymapDesc("n", "<leader>br", "删除右侧 Buffer")
  setKeymapDesc("n", "<leader>bp", "固定/取消固定 Buffer")
  setKeymapDesc("n", "[B", "向左移动 Buffer")
  setKeymapDesc("n", "]B", "向右移动 Buffer")

  -- Noice
  setKeymapDesc("n", "<leader>snt", "Noice 消息选择器")
  setKeymapDesc("n", "<leader>snd", "关闭所有 Noice 消息")
  setKeymapDesc("n", "<leader>sna", "查看全部 Noice 消息")
  setKeymapDesc("n", "<leader>snh", "查看 Noice 历史")
  setKeymapDesc("n", "<leader>snl", "查看上一条 Noice 消息")

  -- Trouble
  setKeymapDesc("n", "<leader>cs", "符号列表 Trouble")
  setKeymapDesc("n", "<leader>xX", "当前 Buffer 诊断 Trouble")
  setKeymapDesc("n", "<leader>xx", "诊断列表 Trouble")
  setKeymapDesc("n", "<leader>xQ", "Quickfix 列表 Trouble")
  setKeymapDesc("n", "<leader>xL", "Location 列表 Trouble")
  setKeymapDesc("n", "<leader>cS", "LSP 引用/定义 Trouble")

  -- Which-key / MiniPairs
  setKeymapDesc("n", "<leader>?", "Buffer 快捷键提示")
  setKeymapDesc("n", "<leader>up", "开关 MiniPairs 自动括号")

  -- Explorer / Snacks
  setKeymapDesc("n", "<leader>fE", "文件树 当前目录")
  setKeymapDesc("n", "<leader>fe", "文件树 项目根目录")
  setKeymapDesc("n", "<leader>dps", "性能分析 Scratch Buffer")
  setKeymapDesc("n", "<leader>un", "关闭所有通知")
  setKeymapDesc("n", "<leader>uC", "选择配色方案")

  -- 搜索
  setKeymapDesc("n", "<leader>su", "撤销树")
  setKeymapDesc("n", "<leader>sq", "Quickfix 列表")
  setKeymapDesc("n", "<leader>sR", "恢复上次搜索")
  setKeymapDesc("n", "<leader>sm", "标记列表")
  setKeymapDesc("n", "<leader>sM", "Man 手册页")
  setKeymapDesc("n", "<leader>sl", "Location 列表")
  setKeymapDesc("n", "<leader>sk", "快捷键列表")
  setKeymapDesc("n", "<leader>sj", "跳转历史")
  setKeymapDesc("n", "<leader>si", "图标列表")
  setKeymapDesc("n", "<leader>sH", "高亮组列表")
  setKeymapDesc("n", "<leader>sh", "帮助页面")
  setKeymapDesc("n", "<leader>sD", "当前 Buffer 诊断")
  setKeymapDesc("n", "<leader>sd", "诊断列表")
  setKeymapDesc("n", "<leader>sC", "命令列表")
  setKeymapDesc("n", "<leader>sc", "命令历史")
  setKeymapDesc("n", "<leader>sa", "自动命令列表")
  setKeymapDesc("n", "<leader>s/", "搜索历史")
  setKeymapDesc("n", '<leader>s"', "寄存器列表")
  setKeymapDesc("n", "<leader>sW", "搜索选中文本/当前单词 当前目录")
  setKeymapDesc("n", "<leader>sw", "搜索选中文本/当前单词 项目根目录")
  setKeymapDesc("n", "<leader>sp", "搜索插件配置")
  setKeymapDesc("n", "<leader>sG", "全文搜索 当前目录")
  setKeymapDesc("n", "<leader>sg", "全文搜索 项目根目录")
  setKeymapDesc("n", "<leader>sB", "搜索已打开 Buffer")
  setKeymapDesc("n", "<leader>sb", "搜索当前 Buffer 内容")

  -- GitHub / Git
  setKeymapDesc("n", "<leader>gP", "GitHub 所有 Pull Request")
  setKeymapDesc("n", "<leader>gp", "GitHub 打开的 Pull Request")
  setKeymapDesc("n", "<leader>gI", "GitHub 所有 Issue")
  setKeymapDesc("n", "<leader>gi", "GitHub 打开的 Issue")
  setKeymapDesc("n", "<leader>gS", "Git Stash")
  setKeymapDesc("n", "<leader>gs", "Git 状态")
  setKeymapDesc("n", "<leader>gD", "Git Diff 对比 origin")
  setKeymapDesc("n", "<leader>gd", "Git Diff 当前改动块")

  -- 文件 / 项目
  setKeymapDesc("n", "<leader>fp", "项目列表")
  setKeymapDesc("n", "<leader>fR", "最近文件 当前目录")
  setKeymapDesc("n", "<leader>fr", "最近文件")
  setKeymapDesc("n", "<leader>fF", "查找文件 当前目录")
  setKeymapDesc("n", "<leader>fc", "查找配置文件")
  setKeymapDesc("n", "<leader>fB", "所有 Buffer")
  setKeymapDesc("n", "<leader>fb", "Buffer 列表")
  setKeymapDesc("n", ",", "Buffer 列表")

  -- Session
  setKeymapDesc("n", "<leader>qd", "不保存当前会话")
  setKeymapDesc("n", "<leader>ql", "恢复上次会话")
  setKeymapDesc("n", "<leader>qS", "选择会话")
  setKeymapDesc("n", "<leader>qs", "恢复会话")

  -- Code / Todo / Mason
  setKeymapDesc("n", "<leader>cF", "格式化嵌入语言")
  setKeymapDesc("n", "<leader>xT", "待办/修复项问题列表")
  setKeymapDesc("n", "<leader>xt", "待办事项问题列表")
  setKeymapDesc("n", "<leader>st", "待办事项列表")
  setKeymapDesc("n", "<leader>sT", "待办/修复项列表")
  setKeymapDesc("n", "<leader>sr", "搜索并替换")
  setKeymapDesc("n", "<leader>cm", "打开 Mason 插件管理器")

  -- Flash / Treesitter / Scope
  setKeymapDesc("n", "S", "Flash Treesitter")
  setKeymapDesc("n", "s", "Flash 跳转")
  setKeymapDesc("n", "[i", "跳到作用域顶部")
  setKeymapDesc("n", "]i", "跳到作用域底部")
  setKeymapDesc("n", "[D", "跳到当前 Buffer 第一个诊断")
  setKeymapDesc("n", "]D", "跳到当前 Buffer 最后一个诊断")
  setKeymapDesc("n", "[ ", "在上方添加空行")
  setKeymapDesc("n", "] ", "在下方添加空行")

  -- Todo comments
  setKeymapDesc("n", "[t", "上一个 Todo 注释")
  setKeymapDesc("n", "]t", "下一个 Todo 注释")

  -- LSP 默认快捷键
  setKeymapDesc("n", "gO", "文档符号列表")
  setKeymapDesc("n", "grt", "跳到类型定义")
  setKeymapDesc("n", "gri", "跳到实现")
  setKeymapDesc("n", "grr", "查找引用")
  setKeymapDesc("n", "grx", "运行 CodeLens")
  setKeymapDesc("n", "gra", "代码操作")
  setKeymapDesc("n", "grn", "LSP 重命名")

  -- Comment / gx
  setKeymapDesc("n", "gcc", "注释当前行")
  setKeymapDesc("n", "gc", "注释操作")
  setKeymapDesc("n", "gx", "用系统程序打开光标下路径/链接")

  -- 滚动 / Treesitter
  setKeymapDesc("n", "<C-Space>", "Treesitter 增量选择")
  setKeymapDesc("n", "<C-F>", "向前滚动")
  setKeymapDesc("n", "<C-B>", "向后滚动")
  setKeymapDesc("n", "<C-W> ", "窗口快捷键模式")
  setKeymapDesc("n", "<C-W>d", "显示光标下诊断")
  setKeymapDesc("n", "<C-W><C-D>", "显示光标下诊断")

  -- Insert 模式 MiniPairs / snippet
  setKeymapDesc("i", "<BS>", "MiniPairs 退格")
  setKeymapDesc("i", "<S-Tab>", "跳转到上一个 snippet 位置")
  setKeymapDesc("i", "<Tab>", "跳转到下一个 snippet 位置")
  setKeymapDesc("i", "<CR>", "自动括号确认补全")
  setKeymapDesc("i", '"', "补全双引号")
  setKeymapDesc("i", "'", "补全单引号")
  setKeymapDesc("i", "(", "补全左小括号")
  setKeymapDesc("i", ")", "跳过右小括号")
  setKeymapDesc("i", "[", "补全左中括号")
  setKeymapDesc("i", "]", "跳过右中括号")
  setKeymapDesc("i", "`", "补全反引号")
  setKeymapDesc("i", "{", "补全左大括号")
  setKeymapDesc("i", "}", "跳过右大括号")
  setKeymapDesc("i", "<C-F>", "向前滚动")
  setKeymapDesc("i", "<C-B>", "向后滚动")

  -- Visual / Select
  setKeymapDesc({ "v", "x" }, "<leader>sW", "搜索选中文本 当前目录")
  setKeymapDesc({ "v", "x" }, "<leader>sw", "搜索选中文本 项目根目录")
  setKeymapDesc({ "v", "x" }, "<leader>cF", "格式化嵌入语言")
  setKeymapDesc({ "v", "x" }, "<leader>sr", "搜索并替换")
  setKeymapDesc({ "v", "x" }, "R", "Treesitter 搜索")
  setKeymapDesc({ "v", "x" }, "S", "Flash Treesitter")
  setKeymapDesc({ "v", "x" }, "s", "Flash 跳转")
  setKeymapDesc({ "v", "x" }, "[i", "跳到作用域顶部")
  setKeymapDesc({ "v", "x" }, "]i", "跳到作用域底部")
  setKeymapDesc({ "v", "x" }, "[n", "选择上一个节点")
  setKeymapDesc({ "v", "x" }, "]n", "选择下一个节点")
  setKeymapDesc({ "v", "x" }, "al", "选择上一个外部文本对象")
  setKeymapDesc({ "v", "x" }, "a", "选择外部文本对象")
  setKeymapDesc({ "v", "x" }, "ai", "选择完整作用域")
  setKeymapDesc({ "v", "x" }, "an", "选择下一个外部文本对象")
  setKeymapDesc({ "v", "x" }, "il", "选择上一个内部文本对象")
  setKeymapDesc({ "v", "x" }, "i", "选择内部文本对象")
  setKeymapDesc({ "v", "x" }, "ii", "选择内部作用域")
  setKeymapDesc({ "v", "x" }, "in", "选择下一个内部文本对象")
  setKeymapDesc({ "v", "x" }, "g]", "移动到右侧文本对象")
  setKeymapDesc({ "v", "x" }, "g[", "移动到左侧文本对象")
  setKeymapDesc({ "v", "x" }, "gra", "代码操作")
  setKeymapDesc({ "v", "x" }, "gc", "注释选中内容")
  setKeymapDesc({ "v", "x" }, "gx", "用系统程序打开选中路径/链接")
  setKeymapDesc({ "v", "x" }, "<C-Space>", "Treesitter 增量选择")

  -- Operator-pending
  setKeymapDesc("o", "R", "Treesitter 搜索")
  setKeymapDesc("o", "S", "Flash Treesitter")
  setKeymapDesc("o", "r", "远程 Flash 跳转")
  setKeymapDesc("o", "s", "Flash 跳转")
  setKeymapDesc("o", "[i", "跳到作用域顶部")
  setKeymapDesc("o", "]i", "跳到作用域底部")
  setKeymapDesc("o", "al", "选择上一个外部文本对象")
  setKeymapDesc("o", "a", "选择外部文本对象")
  setKeymapDesc("o", "ai", "选择完整作用域")
  setKeymapDesc("o", "an", "选择下一个外部文本对象")
  setKeymapDesc("o", "il", "选择上一个内部文本对象")
  setKeymapDesc("o", "i", "选择内部文本对象")
  setKeymapDesc("o", "ii", "选择内部作用域")
  setKeymapDesc("o", "in", "选择下一个内部文本对象")
  setKeymapDesc("o", "g]", "移动到右侧文本对象")
  setKeymapDesc("o", "g[", "移动到左侧文本对象")
  setKeymapDesc("o", "gc", "注释文本对象")
  setKeymapDesc("o", "<C-Space>", "Treesitter 增量选择")

  -- Command-line 模式
  setKeymapDesc("c", "<S-Tab>", "补全菜单上一个")
  setKeymapDesc("c", "<End>", "隐藏补全菜单")
  setKeymapDesc("c", "<C-Space>", "显示补全菜单")
  setKeymapDesc("c", "<C-P>", "补全菜单上一个")
  setKeymapDesc("c", "<C-Y>", "选择并确认补全")
  setKeymapDesc("c", "<C-N>", "补全菜单下一个")
  setKeymapDesc("c", "<C-E>", "取消补全")
  setKeymapDesc("c", "<C-S>", "开关 Flash 搜索")
  setKeymapDesc("c", "<S-CR>", "重定向命令行输出")
  setKeymapDesc("c", "<BS>", "MiniPairs 退格")
  setKeymapDesc("c", "<Tab>", "补全菜单下一个/确认唯一项")
end

applyExtraKeymapChineseDesc()

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    vim.schedule(applyExtraKeymapChineseDesc)
  end,
})
