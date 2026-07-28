vim.cmd("autocmd!")

vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

vim.wo.number = true
vim.opt.relativenumber = true

vim.opt.guicursor = "n-v-c-i-ci-ve-sm:block,r-cr-o:hor20"

vim.opt.textwidth = 80
vim.opt.colorcolumn = "+1"
vim.opt.clipboard = "unnamedplus"

vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.hlsearch = true
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 2
vim.opt.expandtab = true
vim.opt.scrolloff = 10
vim.opt.shell = 'zsh'
vim.opt.backupskip = { '/tmp/*', '/private/tmp/*' }
vim.opt.inccommand = 'split'
vim.opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.wrap = false -- No Wrap lines
vim.opt.backspace = { 'start', 'eol', 'indent' }
vim.opt.path:append { '**' } -- Finding files - Search down into subfolders
vim.opt.wildignore:append { '*/node_modules/*' }

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = '*',
  command = "set nopaste"
})

-- Add asterisks in block comments
vim.opt.formatoptions:append { 'r' }

vim.cmd('filetype plugin indent on')


-- mouse support
vim.cmd([[set mouse=a]])

-- diagnostic windo
vim.diagnostic.config({
  float = {
    border = "rounded",
    sources = "if_many",
    header = ''
  },
})

-- set filetype detection for c/cpp headers
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.h",
  callback = function ()
    vim.bo.filetype = "c" 
  end
})
