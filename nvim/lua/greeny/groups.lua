local M = {}

local colors = require("greeny.palette")

M.setup = function ()
  return {
    Normal       = { fg = colors.fg, bg = colors.bg },
    Cursor       = { fg = colors.cursor },
    Visual       = { bg = colors.visualBg },
    LineNr       = { fg = colors.line_fg, bg = colors.bg },
    CursorLineNr = { fg = colors.keyword, bg = colors.bg },
    CursorLine   = { bg = colors.highlight },
    ColorColumn  = { bg = colors.highlight},
    VertSplit    = { fg = colors.line_fg },
    MatchParen   = { bg = colors.visualBg },
    Search       = { bg = colors.search, fg = colors.lualine_fg },
    CurSearch    = { bg = colors.search, fg = colors.lualine_fg },

    NormalFloat  = { fg = colors.fg, bg = colors.bg },
    FloatBoarder = { fg = colors.fg, bg = colors.bg },
    CmpItemKind  = { fg = colors.type },

    Comment    = { fg = colors.comment },
    Number     = { fg = colors.number },
    String     = { fg = colors.string },
    Boolean    = { fg = colors.number },
    Operator   = { fg = colors.fg },
    Constant   = { fg = colors.constant },
    Statement  = { fg = colors.keyword },
    Keyword    = { fg = colors.keyword },
    cStructure = { fg = colors.keyword },
    Identifier = { fg = colors.variable },
    Function   = { fg = colors.func },
    Type       = { fg = colors.type },
    PreProc    = { fg = colors.macro },
    WarningMsg = { fg = colors.warning },
    Error      = { fg = colors.error },

    StatusLine   = { fg = colors.lualine_fg, bg = colors.lualine_bg },
    StatusLIneNC = { fg = colors.line_fg, bg = colors.bg },

    OilFileHidden = { fg = colors.fg },
    OilDirHidden  = { fg = colors.constant },
    OilDir        = { fg = colors.type },

    ["@comment"]          = { link = "Comment" },
    ["@string"]           = { link = "String" },
    ["@number"]           = { link = "Number" },
    ["@boolean"]          = { link = "Boolean" },
    ["@constant"]         = { link = "Constant" },
    ["@function"]         = { link = "Function" },
    ["@function.builtin"] = { link = "Function" },
    ["@variable"]         = { link = "Identifier" },
    ["@type"]             = { link = "Type" },
    ["@keyword"]          = { link = "Keyword" },
    ["@keyword.function"] = { link = "Keyword" },
    ["@field"]            = { link = "Identifier" },
    ["@property"]         = { link = "Identifier" },
    ["@parameter"]        = { link = "Identifier" },

    ["@markup.heading.markdown"]       = { link = "Function" },
    ["@markup.raw.markdown_inline"]    = { link = "Type" },
    ["@markup.strong.markdown_inline"] = { link = "Type" },
    ["@markup.italic.markdown_inline"] = { link = "Comment" },
    ["@markup.list.markdown"]          = { link = "Keyword" },
    ["@markup.list.markdown_inline"]   = { link = "Constant" },
    ["@markup.raw.block.markdown"]     = { link = "NormalFloat" },
    ["@punctuation.special.markdown"]  = { link = "Comment" },
  }
end

return M
