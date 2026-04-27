vim.cmd.highlight("clear")
vim.o.background = "dark"
vim.g.colors_name = "max"
local p = {
	bg = "#231f1c",
	bg2 = "#2e2923",
	dark_gray = "#483f36",
	gray = "#6b6158",
	mid_gray = "#978c7f",
	light = "#d8d3cc",
	muted = "#c4bdb5",
	secondary = "#c3998b",
	tertiary = "#a6988b",
	rust = "#db8e88",
	clay = "#deaea0",
	ochre = "#dec07a",
	sage = "#acbb9d",
	pine = "#56706b",
	slate = "#a8bef0",
	mauve = "#c7afb7",
}
local hi = function(group, opts)
	vim.api.nvim_set_hl(0, group, opts)
end
hi("Normal", { fg = p.light, bg = "none" })
hi("NormalNC", { fg = p.light, bg = "none" })
hi("NormalFloat", { fg = p.light, bg = p.bg2 })
hi("SignColumn", { bg = "none" })
hi("EndOfBuffer", { fg = p.dark_gray, bg = "none" })
hi("CursorLine", { bg = "none" })
hi("CursorLineNr", { fg = p.secondary, bg = "none" })
hi("LineNr", { fg = p.gray })
hi("Comment", { fg = p.gray, italic = true })
hi("String", { fg = p.sage })
hi("Number", { fg = p.ochre })
hi("Boolean", { fg = p.ochre })
hi("Float", { fg = p.ochre })
hi("Keyword", { fg = p.rust })
hi("Conditional", { fg = p.rust })
hi("Repeat", { fg = p.rust })
hi("Function", { fg = p.clay })
hi("Identifier", { fg = p.light })
hi("Type", { fg = p.slate })
hi("StorageClass", { fg = p.slate })
hi("Structure", { fg = p.slate })
hi("Constant", { fg = p.ochre })
hi("Special", { fg = p.secondary })
hi("Operator", { fg = p.mid_gray })
hi("Delimiter", { fg = p.mid_gray })
hi("PreProc", { fg = p.mauve })
hi("Include", { fg = p.mauve })
hi("Statement", { fg = p.rust })
hi("Title", { fg = p.secondary, bold = true })
hi("Todo", { fg = p.ochre, bold = true })
hi("Error", { fg = p.rust })
hi("Warning", { fg = p.ochre })
hi("StatusLine", { fg = p.muted, bg = "none" })
hi("StatusLineNC", { fg = p.gray, bg = "none" })
hi("WinBar", { fg = p.muted, bg = "none" })
hi("WinBarNC", { fg = p.gray, bg = "none" })
hi("TabLine", { fg = p.gray, bg = "none" })
hi("TabLineFill", { bg = "none" })
hi("TabLineSel", { fg = p.secondary, bg = "none" })
hi("Visual", { bg = p.dark_gray })
hi("Search", { fg = p.bg, bg = p.ochre })
hi("IncSearch", { fg = p.bg, bg = p.rust })
hi("MatchParen", { fg = p.ochre, bold = true })
hi("Pmenu", { fg = p.light, bg = p.bg2 })
hi("PmenuSel", { fg = p.bg, bg = p.secondary })
hi("PmenuSbar", { bg = p.bg2 })
hi("PmenuThumb", { bg = p.gray })
hi("Directory", { fg = p.pine })
hi("DiagnosticError", { fg = p.rust })
hi("DiagnosticWarn", { fg = p.ochre })
hi("DiagnosticInfo", { fg = p.slate })
hi("DiagnosticHint", { fg = p.sage })
hi("GitSignsAdd", { fg = p.sage })
hi("GitSignsChange", { fg = p.ochre })
hi("GitSignsDelete", { fg = p.rust })
-- Treesitter
hi("@variable", { fg = p.light })
hi("@variable.builtin", { fg = p.clay })
hi("@function", { fg = p.clay })
hi("@function.builtin", { fg = p.secondary })
hi("@keyword", { fg = p.rust })
hi("@keyword.return", { fg = p.rust })
hi("@string", { fg = p.sage })
hi("@number", { fg = p.ochre })
hi("@boolean", { fg = p.ochre })
hi("@type", { fg = p.slate })
hi("@type.builtin", { fg = p.slate })
hi("@constant", { fg = p.ochre })
hi("@constant.builtin", { fg = p.ochre })
hi("@comment", { fg = p.gray, italic = true })
hi("@punctuation", { fg = p.mid_gray })
hi("@operator", { fg = p.mid_gray })
hi("@parameter", { fg = p.clay })
hi("@field", { fg = p.tertiary })
hi("@property", { fg = p.tertiary })
hi("@namespace", { fg = p.mauve })
hi("@include", { fg = p.mauve })
hi("@tag", { fg = p.rust })
hi("@tag.attribute", { fg = p.ochre })
	hi("@tag.delimiter", { fg = p.mid_gray })
