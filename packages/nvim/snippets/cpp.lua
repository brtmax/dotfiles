-- ~/.config/nvim/snippets/cpp.lua
local ls = require "luasnip"
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

ls.add_snippets("cpp", {
  s("rule5", {
    t "class ",
    i(1, "Name"),
    t { " {", "public:" },
    t { "", "\t" },
    i(0),
    t { "", "", "\t// Rule of Five" },
    t { "", "\t" },
    t "~",
    rep(1),
    t "();",
    t { "", "\t" },
    t "",
    t { "", "\t" },
    t "Name(const ",
    rep(1),
    t "&);",
    t { "", "\t" },
    t "Name& operator=(const ",
    rep(1),
    t "&);",
    t { "", "\t" },
    t "Name(",
    rep(1),
    t "&&) noexcept;",
    t { "", "\t" },
    t "Name& operator=(",
    rep(1),
    t "&&) noexcept;",
    t { "", "", "private:", "\t" },
    i(2),
    t { "", "};" },
  }),
})
