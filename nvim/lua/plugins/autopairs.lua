return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local npairs = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")

      npairs.setup({
        check_ts = true,
        disable_filetype = {
          "TelescopePrompt",
          "snacks_picker_input",
        },
      })

      npairs.add_rule(Rule("【", "】"))
    end,
  },
}
