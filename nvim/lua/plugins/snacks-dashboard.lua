return {
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      opts.picker = opts.picker or {}
      opts.picker.sources = opts.picker.sources or {}

      local exclude = {
        -- Git / 系统
        "**/.git/**",

        -- CMake / C++
        "**/build/**",
        "**/cmake-build-*/**",
        "**/__cmake_systeminformation/**",
        "**/CMakeFiles/**",
        "**/CMakeCache.txt",
        "**/cmake_install.cmake",
        "**/compile_commands.json",

        -- Vivado / Xilinx
        "**/.Xil/**",
        "**/*.runs/**",
        "**/*.sim/**",
        "**/*.cache/**",
        "**/*.hw/**",
        "**/*.ip_user_files/**",
        "**/xsim.dir/**",

        -- Vivado 生成文件
        "**/*.jou",
        "**/*.log",
        "**/*.wdb",
        "**/*.pb",
        "**/*.sdb",
        "**/*.rlx",
        "**/*.rtti",
        "**/*.reloc",
        "**/*.mem",
        "**/*.dbg",
        "**/*.win64.obj",
        "**/xsimk.exe",
        "**/xsimSettings.ini",
        "**/TempBreakPointFile.txt",
        "**/Compile_Options.txt",
      }

      opts.picker.sources.files = opts.picker.sources.files or {}
      opts.picker.sources.files.hidden = false
      opts.picker.sources.files.ignored = false
      opts.picker.sources.files.exclude = exclude

      opts.picker.sources.grep = opts.picker.sources.grep or {}
      opts.picker.sources.grep.hidden = false
      opts.picker.sources.grep.ignored = false
      opts.picker.sources.grep.exclude = exclude

      opts.picker.sources.explorer = opts.picker.sources.explorer or {}
      opts.picker.sources.explorer.hidden = false
      opts.picker.sources.explorer.ignored = false
      opts.picker.sources.explorer.exclude = exclude

      opts.dashboard = opts.dashboard or {}
      opts.dashboard.preset = opts.dashboard.preset or {}

      local function project_files()
        local cwd = vim.g.project_root or vim.fn.getcwd()

        vim.cmd.cd(vim.fn.fnameescape(cwd))

        local uv = vim.uv or vim.loop
        pcall(uv.chdir, cwd)

        Snacks.picker.files({
          cwd = cwd,
          hidden = false,
          ignored = false,
          exclude = exclude,
        })
      end

      local keys = opts.dashboard.preset.keys or {}
      local found = false

      for _, item in ipairs(keys) do
        if item.key == "f" then
          item.desc = "查找文件"
          item.action = project_files
          found = true
          break
        end
      end

      if not found then
        table.insert(keys, 1, {
          icon = " ",
          key = "f",
          desc = "查找文件",
          action = project_files,
        })
      end

      opts.dashboard.preset.keys = keys
    end,
  },
}
