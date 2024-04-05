-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'nvim-tree/nvim-tree.lua',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    opts = {},
    config = function()
      require('nvim-tree').setup {
        filters = {
          dotfiles = false,
        },
        disable_netrw = true,
        hijack_netrw = true,
        hijack_cursor = true,
        hijack_unnamed_buffer_when_opening = false,
        sync_root_with_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = false,
        },
        view = {
          adaptive_size = false,
          side = 'left',
          width = 30,
          preserve_window_proportions = true,
        },
        git = {
          enable = true,
          ignore = false,
        },
        filesystem_watchers = {
          enable = true,
        },
        actions = {
          open_file = {
            resize_window = true,
          },
        },
        renderer = {
          root_folder_label = false,
          highlight_git = true,
          highlight_opened_files = 'none',

          indent_markers = {
            enable = true,
          },

          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },

            glyphs = {
              default = '󰈚',
              symlink = '',
              folder = {
                default = '',
                empty = '',
                empty_open = '',
                open = '',
                symlink = '',
                symlink_open = '',
                arrow_open = '',
                arrow_closed = '',
              },
              git = {
                unstaged = '✗',
                staged = '✓',
                unmerged = '',
                renamed = '➜',
                untracked = '★',
                deleted = '',
                ignored = '◌',
              },
            },
          },
        },
      }
      vim.keymap.set('n', '<leader>ot', '<cmd>NvimTreeToggle<CR>')
      vim.keymap.set('n', '<leader>f', '<cmd>NvimTreeFindFile<CR>')
    end,
  },
  {
    'famiu/bufdelete.nvim',
    lazy = false,
    config = function()
      vim.keymap.set('n', '<leader>bc', '<cmd>Bdelete<CR>')
    end,
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
  },
  {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', '<leader>gg', '<cmd>Git<CR>')
    end,
  },
  {
    'akinsho/nvim-bufferline.lua',
    event = 'BufReadPre',
    wants = 'nvim-web-devicons',
    config = function()
      require('bufferline').setup {
        options = {
          numbers = 'none',
          diagnostics = 'nvim_lsp',
          seperator_style = 'padded_slope',
          show_tab_indicators = true,
          show_buffer_close_icons = false,
          show_close_icon = false,
          show_buffer_icons = true,
          diagnostics_indicator = function(count, level)
            local icon = level:match 'error' and ' ' or ''
            return ' ' .. icon .. count
          end,
          indicator = {
            icon = '▎', -- this should be omitted if indicator style is not 'icon'
            style = 'icon',
          },

          left_trunc_marker = '',
          right_trunc_marker = '',
          offsets = {
            {
              filetype = 'NvimTree',
              hightlight = 'Directory',
            },
          },
        },
      }
      vim.keymap.set('n', '<leader>bb', '<cmd>BufferLineCyclePrev<CR>')
      vim.keymap.set('n', '<leader>bn', '<cmd>BufferLineCycleNext<CR>')
      vim.keymap.set('n', '<leader>bp', '<cmd>BufferLinePick<CR>')
    end,
  },
  {
    'aserowy/tmux.nvim',
    config = function()
      return require('tmux').setup()
    end,
  },
  {
    'Shatur/neovim-tasks',
    config = function()
      local path = require 'plenary.path'
      local dap = require('dap').adapters
      require('tasks').setup {
        default_params = { -- Default module parameters with which `neovim.json` will be created.
          cmake = {
            cmd = 'cmake', -- CMake executable to use, can be changed using `:Task set_module_param cmake cmd`.
            build_dir = tostring(path:new('{cwd}', 'build', '{os}-{build_type}')), -- Build directory. The expressions `{cwd}`, `{os}` and `{build_type}` will be expanded with the corresponding text values. Could be a function that return the path to the build directory.
            build_type = 'Debug', -- Build type, can be changed using `:Task set_module_param cmake build_type`.
            dap_name = dap.codelldb, -- DAP configuration name from `require('dap').configurations`. If there is no such configuration, a new one with this name as `type` will be created.
            args = { -- Task default arguments.
              configure = { '-D', 'CMAKE_EXPORT_COMPILE_COMMANDS=1', '-G', 'Ninja' },
            },
          },
        },
        save_before_run = true, -- If true, all files will be saved before executing a task.
        params_file = 'neovim.json', -- JSON file to store module and task parameters.
        quickfix = {
          pos = 'botright', -- Default quickfix position.
          height = 12, -- Default height.
        },
        dap_open_command = function()
          return require('dapui').open()
        end, -- Command to run after starting DAP session. You can set it to `false` if you don't want to open anything or `require('dapui').open` if you are using https://github.com/rcarriga/nvim-dap-ui
      }
    end,
  },
  {
    'chentoast/marks.nvim',
    config = function()
      require('marks').setup {
        -- whether to map keybinds or not. default true
        default_mappings = true,
        -- which builtin marks to show. default {}
        builtin_marks = { '.', '<', '>', '^' },
        -- whether movements cycle back to the beginning/end of buffer. default true
        cyclic = true,
        -- whether the shada file is updated after modifying uppercase marks. default false
        force_write_shada = false,
        -- how often (in ms) to redraw signs/recompute mark positions.
        -- higher values will have better performance but may cause visual lag,
        -- while lower values may cause performance penalties. default 150.
        refresh_interval = 250,
        -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
        -- marks, and bookmarks.
        -- can be either a table with all/none of the keys, or a single number, in which case
        -- the priority applies to all marks.
        -- default 10.
        sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
        -- disables mark tracking for specific filetypes. default {}
        excluded_filetypes = {},
        -- disables mark tracking for specific buftypes. default {}
        excluded_buftypes = {},
        -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
        -- sign/virttext. Bookmarks can be used to group together positions and quickly move
        -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
        -- default virt_text is "".
        bookmark_0 = {
          sign = '⚑',
          virt_text = 'hello world',
          -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
          -- defaults to false.
          annotate = false,
        },
        mappings = {},
      }
    end,
  },
}
