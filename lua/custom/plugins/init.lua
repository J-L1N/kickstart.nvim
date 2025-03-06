-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'nvimdev/dashboard-nvim',
    lazy = false,
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
        theme = 'hyper',
      }
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
  },
  {
    'mikavilpas/yazi.nvim',
    event = 'VeryLazy',
    keys = {
      -- 👇 in this section, choose your own keymappings!
      {
        '<leader>.',
        '<cmd>Yazi<cr>',
        desc = 'Open yazi at the current file',
      },
      {
        -- Open in the current working directory
        '<leader>oy',
        '<cmd>Yazi cwd<cr>',
        desc = "Open the file manager in nvim's working directory",
      },
      {
        -- NOTE: this requires a version of yazi that includes
        -- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
        '<c-up>',
        '<cmd>Yazi toggle<cr>',
        desc = 'Resume the last yazi session',
      },
    },
    ---@type YaziConfig
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = false,
      keymaps = {
        show_help = '<f1>',
      },
    },
  },
  {
    'kdheepak/lazygit.nvim',
    lazy = true,
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    -- optional for floating window border decoration
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { '<leader>go', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
  },
  -- {
  --   'nvim-orgmode/orgmode',
  --   event = 'VeryLazy',
  --   ft = { 'org' },
  --   config = function()
  --     -- Setup orgmode
  --     require('orgmode').setup {
  --       org_agenda_files = '~/orgfiles/**/*',
  --       org_default_notes_file = '~/orgfiles/refile.org',
  --     }
  --
  --     -- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
  --     -- add ~org~ to ignore_install
  --     -- require('nvim-treesitter.configs').setup({
  --     --   ensure_installed = 'all',
  --     --   ignore_install = { 'org' },
  --     -- })
  --   end,
  -- },
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        suggestion = {
          auto_trigger = true,
          accept = false,
        },
      }
    end,
  },
  vim.keymap.set('i', '<Tab>', function()
    if require('copilot.suggestion').is_visible() then
      require('copilot.suggestion').accept()
    else
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Tab>', true, false, true), 'n', false)
    end
  end, {
    silent = true,
  }),
  vim.keymap.set('i', '<C-g>', function()
    if require('copilot.suggestion').is_visible() then
      require('copilot.suggestion').dismiss()
    else
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-g>', true, false, true), 'n', false)
    end
  end, {
    silent = true,
  }),
}
