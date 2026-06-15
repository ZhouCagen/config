return {
    "saghen/blink.cmp",
    opts = {
        completion = {
            list = {
                selection = {
                    -- 默认不选中第一项
                    preselect = false,

                    -- 切换候选时不要直接插入
                    auto_insert = false,
                },
            },
        },

        keymap = {
            preset = "none",

            -- 手动打开补全
            ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },

            -- Tab / Shift-Tab 切换候选
            ["<Tab>"] = { "select_next", "fallback" },

            -- 方向键也能切换候选
            ["<Down>"] = { "select_next", "fallback" },
            ["<Up>"] = { "select_prev", "fallback" },

            -- Enter：选中候选时确认；没选中时正常回车
            ["<CR>"] = { "accept", "fallback" },

            -- 关闭补全菜单
            ["<C-e>"] = { "hide", "fallback" },
        },
    },
}
