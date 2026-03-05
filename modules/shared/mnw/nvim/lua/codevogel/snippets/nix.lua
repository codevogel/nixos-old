local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  s(
    "optmod",
    fmt(
      [[
{{
  lib,
  config,
  ...
}}:

{{
  options = {{
    host-options.{}.enable = lib.mkEnableOption "Enable {}" // {{
      default = {};
    }};
  }};

  config = lib.mkIf config.host-options.{}.enable {{
    {}
  }};
}}
]],
      {
        i(1, "module-name"), -- module name
        f(function(args)
          return args[1][1]
        end, { 1 }), -- mirror in mkEnableOption string
        i(2, "true"), -- default value
        f(function(args)
          return args[1][1]
        end, { 1 }), -- mirror in config.host-options
        i(3, "<config>"), -- config body
      }
    )
  ),
}
