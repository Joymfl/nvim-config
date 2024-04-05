return {
  'konapun/vacuumline.nvim',
  dependencies = {
    'glepnir/galaxyline.nvim',
  },
  config = function()
    require('vacuumline').setup {
      theme = require 'vacuumline.theme.nord',
    }
  end,
}
