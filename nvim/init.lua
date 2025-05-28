require('config.base')
require('config.lazy_init')
require('config.maps')

local has = function (x)
  return vim.fn.has(x) == 0
end

local is_mac = has 'macunix'

if is_mac then
  require('config.macos')
end
