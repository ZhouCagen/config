return {
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          keys = {
            { icon = " ", key = "f", desc = "查找文件", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "新建文件", action = ":ene | startinsert" },
            { icon = " ", key = "p", desc = "项目", action = ":lua Snacks.dashboard.pick('projects')" },
            { icon = " ", key = "g", desc = "查找文本", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "最近文件", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = " ", key = "c", desc = "配置", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = " ", key = "s", desc = "恢复会话", section = "session" },
            { icon = " ", key = "x", desc = "Lazy 扩展", action = ":LazyExtras" },
            { icon = "󰒲 ", key = "l", desc = "Lazy 插件", action = ":Lazy" },
            { icon = " ", key = "q", desc = "退出", action = ":qa" },
          },
        },
      },
    },
  },
}
