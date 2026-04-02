-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

vim.opt.cinoptions = vim.opt.cinoptions + "L0"

-- Make line numbers default
vim.opt.relativenumber = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.opt.relativenumber = true

-- You can als
-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

-- Enable break indent
vim.opt.breakindent = true

vim.opt.smartindent = true
vim.opt.cindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "  ", trail = " ", nbsp = " " }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 20

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error("Error cloning lazy.nvim:\n" .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require("lazy").setup {
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to force a plugin to be loaded.
  --

  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`. This is equivalent to the following Lua:
  --    require('gitsigns').setup({ ... })
  --
  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
    },
  },

  { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `config` key, the configuration only runs
  -- after the plugin has been loaded:
  --  config = function() ... end

  { -- Useful plugin to show you pending keybinds.
    "folke/which-key.nvim",
    event = "VimEnter", -- Sets the loading event to 'VimEnter'
    opts = {
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default whick-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = "<Up> ",
          Down = "<Down> ",
          Left = "<Left> ",
          Right = "<Right> ",
          C = "<C-…> ",
          M = "<M-…> ",
          D = "<D-…> ",
          S = "<S-…> ",
          CR = "<CR> ",
          Esc = "<Esc> ",
          ScrollWheelDown = "<ScrollWheelDown> ",
          ScrollWheelUp = "<ScrollWheelUp> ",
          NL = "<NL> ",
          BS = "<BS> ",
          Space = "<Space> ",
          Tab = "<Tab> ",
          F1 = "<F1>",
          F2 = "<F2>",
          F3 = "<F3>",
          F4 = "<F4>",
          F5 = "<F5>",
          F6 = "<F6>",
          F7 = "<F7>",
          F8 = "<F8>",
          F9 = "<F9>",
          F10 = "<F10>",
          F11 = "<F11>",
          F12 = "<F12>",
        },
      },

      -- Document existing key chains
      spec = {
        { "<leader>c", group = "[C]ode", mode = { "n", "x" } },
        { "<leader>d", group = "[D]ocument" },
        { "<leader>r", group = "[R]ename" },
        { "<leader>s", group = "[S]earch" },
        { "<leader>w", group = "[W]orkspace" },
        { "<leader>t", group = "[T]oggle" },
        { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
      },
    },
  },

  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
      -- configurations go here
    },
    config = function()
      require("barbecue").setup {
        create_autocmd = false, -- prevent barbecue from updating itself automatically
      }

      vim.api.nvim_create_autocmd({
        "WinScrolled", -- or WinResized on NVIM-v0.9 and higher
        "BufWinEnter",
        "CursorHold",
        "InsertLeave",

        -- include this if you have set `show_modified` to `true`
        -- "BufModifiedSet",
      }, {
        group = vim.api.nvim_create_augroup("barbecue.updater", {}),
        callback = function()
          require("barbecue.ui").update()
        end,
      })
    end,
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = "markdown",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-mini/mini.nvim",
    },
    config = function()
      require("render-markdown").setup {
        latex = {
          enabled = true,
          render_modes = true,
          converter = { "utftex", "latex2text" },
          highlight = "RenderMarkdownMath",
          position = "center",
          top_pad = 0,
          bottom_pad = 0,
        },
      }
      require("render-markdown").enable()
    end,
  },

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  { -- Fuzzy Finder (files, lsp, etc)
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        "nvim-telescope/telescope-fzf-native.nvim",

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = "make",

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable "make" == 1
        end,
      },
      { "nvim-telescope/telescope-ui-select.nvim" },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require("telescope").setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        -- pickers = {}
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "ui-select")

      -- See `:help telescope.builtin`
      local builtin = require "telescope.builtin"
      vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
      vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
      vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
      vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
      vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
      vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
      vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
      vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
      vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set("n", "<leader>/", function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = "[/] Fuzzily search in current buffer" })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set("n", "<leader>s/", function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = "Live Grep in Open Files",
        }
      end, { desc = "[S]earch [/] in Open Files" })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set("n", "<leader>sn", function()
        builtin.find_files { cwd = vim.fn.stdpath "config" }
      end, { desc = "[S]earch [N]eovim files" })
    end,
  },

  -- LSP Plugins
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true },
  {
    -- Main LSP Configuration
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { "williamboman/mason.nvim", config = true, lazy = false },
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { "j-hui/fidget.nvim", opts = {} },

      -- Allows extra capabilities provided by nvim-cmp
      "hrsh7th/cmp-nvim-lsp",
    },

    -- lazy.nvim
    {
      "folke/noice.nvim",
      event = "VeryLazy",
      opts = {
        -- add any options here
      },
      dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
        -- OPTIONAL:
        --   `nvim-notify` is only needed, if you want to use the notification view.
        --   If not available, we use `mini` as the fallback
      },
    },
    config = function()
      -- Brief aside: **What is LSP?**
      --
      -- LSP is an initialism you've probably heard, but might not understand what it is.
      --
      -- LSP stands for Language Server Protocol. It's a protocol that helps editors
      -- and language tooling communicate in a standardized fashion.
      --
      -- In general, you have a "server" which is some tool built to understand a particular
      -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
      -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
      -- processes that communicate with some "client" - in this case, Neovim!
      --
      -- LSP provides Neovim with features like:
      --  - Go to definition
      --  - Find references
      --  - Autocompletion
      --  - Symbol Search
      --  - and more!
      --
      -- Thus, Language Servers are external tools that must be installed separately from
      -- Neovim. This is where `mason` and related plugins come into play.
      --
      -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
      -- and elegantly composed help section, `:help lsp-vs-treesitter`

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

          -- Find references for the word under your cursor.
          map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
              group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = "kickstart-lsp-highlight", buffer = event2.buf }
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map("<leader>th", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, "[T]oggle Inlay [H]ints")
          end
        end,
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        clangd = {
          on_attach = on_attach,
          cmd = { "clangd" },
          filetypes = { "c", "cpp", "objc", "objcpp" },
          root_dir = vim.loop.cwd,
        },
        -- gopls = {},
        pyright = {},
        -- rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`tsserver`) will work just fine
        tsserver = {},
        --

        lua_ls = {
          -- cmd = {...},
          -- filetypes = { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace",
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      --  To check the current status of installed tools and/or manually install
      --  other tools, you can run
      --    :Mason
      --
      --  You can press `g?` for help in this menu.
      require("mason").setup()
      require("mason-lspconfig").setup {
        ensure_installed = { "clangd" },
      }
      require("noice").setup {
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      }

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        "stylua", -- Used to format Lua code
      })
      require("mason-tool-installer").setup { ensure_installed = ensure_installed }

      require("mason-lspconfig").setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
      }
    end,
  },

  { -- Autoformat
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format { async = true, lsp_format = "fallback" }
        end,
        mode = "",
        desc = "[F]ormat buffer",
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        local lsp_format_opt
        if disable_filetypes[vim.bo[bufnr].filetype] then
          lsp_format_opt = "never"
        else
          lsp_format_opt = "fallback"
        end
        return {
          timeout_ms = 500,
          lsp_format = lsp_format_opt,
        }
      end,
      formatters_by_ft = {
        lua = { "stylua" },
        cpp = { "clang-format" },
        c = { "clang-format" },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },
  { -- Autocompletion
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        "L3MON4D3/LuaSnip",
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has "win32" == 1 or vim.fn.executable "make" == 0 then
            return
          end
          return "make install_jsregexp"
        end)(),
        dependencies = {
          {
            "rafamadriz/friendly-snippets",
            config = function()
              require("luasnip.loaders.from_vscode").lazy_load()
            end,
          },
        },
      },
      "saadparwaiz1/cmp_luasnip",

      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
    },
    config = function()
      -- See `:help cmp`
      local cmp = require "cmp"
      local luasnip = require "luasnip"
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = "menu,menuone,noinsert" },

        experimental = {
          ghost_text = true, -- enables inline autosuggestions
        },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert {
          -- Select the [n]ext item
          ["<C-n>"] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          ["<C-p>"] = cmp.mapping.select_prev_item(),

          -- Scroll the documentation window [b]ack / [f]orward
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          ["<C-y>"] = cmp.mapping.confirm { select = true },

          -- If you prefer more traditional completion keymaps,
          -- you can uncomment the following lines
          --['<CR>'] = cmp.mapping.confirm { select = true },
          --['<Tab>'] = cmp.mapping.select_next_item(),
          --['<S-Tab>'] = cmp.mapping.select_prev_item(),

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ["<C-Space>"] = cmp.mapping.complete {},

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          ["<C-l>"] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { "i", "s" }),
          ["<C-h>"] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { "i", "s" }),

          -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
          --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        },
        sources = {
          {
            name = "lazydev",
            -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
            group_index = 0,
          },
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
        },
      }
    end,
  },

  {
    "rose-pine/neovim",
    name = "rose-pine-dawn", -- optional, can be anything
    priority = 1000,
    config = function()
      -- Enable true color support
      vim.opt.termguicolors = true

      -- Full setup
      require("rose-pine").setup {
        variant = "auto", -- auto, main, moon, or dawn
        dark_variant = "main",

        dim_inactive_windows = false,
        extend_background_behind_borders = true,

        enable = {
          terminal = true,
          legacy_highlights = true,
          migrations = true,
        },

        styles = {
          bold = true,
          italic = true,
          transparency = false,
        },

        groups = {
          border = "muted",
          link = "iris",
          panel = "surface",

          error = "love",
          hint = "iris",
          info = "foam",
          note = "pine",
          todo = "rose",
          warn = "gold",

          git_add = "foam",
          git_change = "rose",
          git_delete = "love",
          git_dirty = "rose",
          git_ignore = "muted",
          git_merge = "iris",
          git_rename = "pine",
          git_stage = "iris",
          git_text = "rose",
          git_untracked = "subtle",

          h1 = "iris",
          h2 = "foam",
          h3 = "rose",
          h4 = "gold",
          h5 = "pine",
          h6 = "foam",
        },

        palette = {
          -- moon = {
          --     base = '#18191a',
          --     overlay = '#363738',
          -- },
        },

        highlight_groups = {
          -- Custom highlight overrides (optional)
        },

        before_highlight = function(group, highlight, palette)
          -- Optional modifications before applying highlights
        end,
      }

      -- Activate colorscheme
      vim.cmd "colorscheme rose-pine"
    end,
  },

  -- Highlight todo, notes, etc in comments
  {
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
  },

  {
    "nvim-neorg/neorg",
    lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = "*", -- Pin Neorg to the latest stable release
    config = true,
  },
  {
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
    config = function()
      require("peek").setup()
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
  },

  { -- Collection of various small independent plugins/modules
    "echasnovski/mini.nvim",
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require("mini.surround").setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require "mini.statusline"
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return "%2l:%-2v"
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"

      npairs.setup {
        check_ts = true,
      }
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  { -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs", -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = {
        "bash",
        "cpp",
        "python",
        "zig",
        "c",
        "diff",
        "html",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "query",
        "vim",
        "vimdoc",
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { "ruby" },
      },
      indent = { enable = true, disable = { "c", "cpp" } },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },

  -- The following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.autopairs',
  -- require 'kickstart.plugins.neo-tree',
  -- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps
  --
  require "kickstart.plugins.obsidian",

  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
}

vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.md",
  callback = function()
    local template_path = "~/.config/nvim/templates/markdown_template.md"
    local template = io.open(vim.fn.expand(template_path), "r")
    local content = template:read "*a"
    template:close()

    -- Replace {{date}} with the current date
    local current_date = os.date "%Y-%m-%d"
    content = content:gsub("{{date}}", current_date)

    vim.api.nvim_buf_set_lines(0, 0, 0, false, vim.split(content, "\n"))
  end,
})

vim.opt.conceallevel = 1
vim.opt.tabstop = 4 -- Number of visual spaces per TAB
vim.opt.shiftwidth = 4 -- Number of spaces per indentation level
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.scrolloff = 20 -- all the time you have to leave the space!
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

-- C++ 26
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.ixx", "*.cppm" },
  command = "set filetype=cpp",
})

-- Snippets
require("luasnip.loaders.from_lua").lazy_load {
  paths = "~/.config/nvim/snippets",
}

-- init.lua
local lspconfig = require "lspconfig"

-- Setup clangd
vim.lsp.config.clangd = {
  cmd = {
    "clangd",
    "--clang-tidy",
    "--background-index",
    "--offset-encoding=utf-8",
  },
  root_markers = { ".clangd", "compile_commands.json" },
  filetypes = { "c", "cpp" },
}

vim.lsp.enable "clangd"

-- Disable automatic comment leader on new lines with 'o'
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*", -- all filetypes
  callback = function()
    vim.opt_local.formatoptions:remove "o"
  end,
})
require("render-markdown").setup {
  -- Whether markdown should be rendered by default.
  enabled = true,
  -- Vim modes that will show a rendered view of the markdown file, :h mode(), for all enabled
  -- components. Individual components can be enabled for other modes. Remaining modes will be
  -- unaffected by this plugin.
  render_modes = { "n", "c", "t" },
  -- Milliseconds that must pass before updating marks, updates occur.
  -- within the context of the visible window, not the entire buffer.
  debounce = 100,
  -- Pre configured settings that will attempt to mimic various target user experiences.
  -- User provided settings will take precedence.
  -- | obsidian | mimic Obsidian UI                                          |
  -- | lazy     | will attempt to stay up to date with LazyVim configuration |
  -- | none     | does nothing                                               |
  preset = "none",
  -- The level of logs to write to file: vim.fn.stdpath('state') .. '/render-markdown.log'.
  -- Only intended to be used for plugin development / debugging.
  log_level = "error",
  -- Print runtime of main update method.
  -- Only intended to be used for plugin development / debugging.
  log_runtime = false,
  -- Filetypes this plugin will run on.
  file_types = { "markdown" },
  -- Maximum file size (in MB) that this plugin will attempt to render.
  -- File larger than this will effectively be ignored.
  max_file_size = 10.0,
  -- Takes buffer as input, if it returns true this plugin will not attach to the buffer.
  ignore = function()
    return false
  end,
  -- Whether markdown should be rendered when nested inside markdown, i.e. markdown code block
  -- inside markdown file.
  nested = true,
  -- Additional events that will trigger this plugin's render loop.
  change_events = {},
  -- Whether the treesitter highlighter should be restarted after this plugin attaches to its
  -- first buffer for the first time. May be necessary if this plugin is lazy loaded to clear
  -- highlights that have been dynamically disabled.
  restart_highlighter = false,
  injections = {
    -- Out of the box language injections for known filetypes that allow markdown to be interpreted
    -- in specified locations, see :h treesitter-language-injections.
    -- Set enabled to false in order to disable.

    gitcommit = {
      enabled = true,
      query = [[
                ((message) @injection.content
                    (#set! injection.combined)
                    (#set! injection.include-children)
                    (#set! injection.language "markdown"))
            ]],
    },
  },
  patterns = {
    -- Highlight patterns to disable for filetypes, i.e. lines concealed around code blocks

    markdown = {
      disable = true,
      directives = {
        { id = 17, name = "conceal_lines" },
        { id = 18, name = "conceal_lines" },
      },
    },
  },
  anti_conceal = {
    -- This enables hiding added text on the line the cursor is on.
    enabled = true,
    -- Modes to disable anti conceal feature.
    disabled_modes = false,
    -- Number of lines above cursor to show.
    above = 0,
    -- Number of lines below cursor to show.
    below = 0,
    -- Which elements to always show, ignoring anti conceal behavior. Values can either be
    -- booleans to fix the behavior or string lists representing modes where anti conceal
    -- behavior will be ignored. Valid values are:
    --   bullet
    --   callout
    --   check_icon, check_scope
    --   code_background, code_border, code_language
    --   dash
    --   head_background, head_border, head_icon
    --   indent
    --   latex
    --   link
    --   quote
    --   sign
    --   table_border
    --   virtual_lines
    ignore = {
      code_background = true,
      indent = true,
      sign = true,
      virtual_lines = true,
    },
  },
  padding = {
    -- Highlight to use when adding whitespace, should match background.
    highlight = "Normal",
  },
  latex = {
    -- Turn on / off latex rendering.
    enabled = true,
    -- Additional modes to render latex.
    render_modes = false,
    -- Executable used to convert latex formula to rendered unicode.
    -- If a list is provided the commands run in order until the first success.
    converter = { "utftex", "latex2text" },
    -- Highlight for latex blocks.
    highlight = "RenderMarkdownMath",
    -- Determines where latex formula is rendered relative to block.
    -- | above  | above latex block                               |
    -- | below  | below latex block                               |
    -- | center | centered with latex block (must be single line) |
    position = "center",
    -- Number of empty lines above latex blocks.
    top_pad = 0,
    -- Number of empty lines below latex blocks.
    bottom_pad = 0,
  },
  on = {
    -- Called when plugin initially attaches to a buffer.
    attach = function() end,
    -- Called before adding marks to the buffer for the first time.
    initial = function() end,
    -- Called after plugin renders a buffer.
    render = function() end,
    -- Called after plugin clears a buffer.
    clear = function() end,
  },
  completions = {
    -- Settings for blink.cmp completions source
    blink = { enabled = false },
    -- Settings for coq_nvim completions source
    coq = { enabled = false },
    -- Settings for in-process language server completions
    lsp = { enabled = false },
    filter = {
      callout = function()
        -- example to exclude obsidian callouts
        -- return value.category ~= 'obsidian'
        return true
      end,
      checkbox = function()
        return true
      end,
    },
  },
  heading = {
    -- Useful context to have when evaluating values.
    -- | level    | the number of '#' in the heading marker         |
    -- | sections | for each level how deeply nested the heading is |

    -- Turn on / off heading icon & background rendering.
    enabled = true,
    -- Additional modes to render headings.
    render_modes = false,
    -- Turn on / off atx heading rendering.
    atx = true,
    -- Turn on / off setext heading rendering.
    setext = true,
    -- Turn on / off sign column related rendering.
    sign = true,
    -- Replaces '#+' of 'atx_h._marker'.
    -- Output is evaluated depending on the type.
    -- | function | `value(context)`              |
    -- | string[] | `cycle(value, context.level)` |
    icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
    -- Determines how icons fill the available space.
    -- | right   | '#'s are concealed and icon is appended to right side                      |
    -- | inline  | '#'s are concealed and icon is inlined on left side                        |
    -- | overlay | icon is left padded with spaces and inserted on left hiding additional '#' |
    position = "overlay",
    -- Added to the sign column if enabled.
    -- Output is evaluated by `cycle(value, context.level)`.
    signs = { "󰫎 " },
    -- Width of the heading background.
    -- | block | width of the heading text |
    -- | full  | full width of the window  |
    -- Can also be a list of the above values evaluated by `clamp(value, context.level)`.
    width = "full",
    -- Amount of margin to add to the left of headings.
    -- Margin available space is computed after accounting for padding.
    -- If a float < 1 is provided it is treated as a percentage of available window space.
    -- Can also be a list of numbers evaluated by `clamp(value, context.level)`.
    left_margin = 0,
    -- Amount of padding to add to the left of headings.
    -- Output is evaluated using the same logic as 'left_margin'.
    left_pad = 0,
    -- Amount of padding to add to the right of headings when width is 'block'.
    -- Output is evaluated using the same logic as 'left_margin'.
    right_pad = 0,
    -- Minimum width to use for headings when width is 'block'.
    -- Can also be a list of integers evaluated by `clamp(value, context.level)`.
    min_width = 0,
    -- Determines if a border is added above and below headings.
    -- Can also be a list of booleans evaluated by `clamp(value, context.level)`.
    border = false,
    -- Always use virtual lines for heading borders instead of attempting to use empty lines.
    border_virtual = false,
    -- Highlight the start of the border using the foreground highlight.
    border_prefix = false,
    -- Used above heading for border.
    above = "▄",
    -- Used below heading for border.
    below = "▀",
    -- Highlight for the heading icon and extends through the entire line.
    -- Output is evaluated by `clamp(value, context.level)`.
    backgrounds = {
      "RenderMarkdownH1Bg",
      "RenderMarkdownH2Bg",
      "RenderMarkdownH3Bg",
      "RenderMarkdownH4Bg",
      "RenderMarkdownH5Bg",
      "RenderMarkdownH6Bg",
    },
    -- Highlight for the heading and sign icons.
    -- Output is evaluated using the same logic as 'backgrounds'.
    foregrounds = {
      "RenderMarkdownH1",
      "RenderMarkdownH2",
      "RenderMarkdownH3",
      "RenderMarkdownH4",
      "RenderMarkdownH5",
      "RenderMarkdownH6",
    },
    -- Define custom heading patterns which allow you to override various properties based on
    -- the contents of a heading.
    -- The key is for healthcheck and to allow users to change its values, value type below.
    -- | pattern    | matched against the heading text @see :h lua-patterns |
    -- | icon       | optional override for the icon                        |
    -- | background | optional override for the background                  |
    -- | foreground | optional override for the foreground                  |
    custom = {},
  },
  paragraph = {
    -- Useful context to have when evaluating values.
    -- | text | text value of the node |

    -- Turn on / off paragraph rendering.
    enabled = true,
    -- Additional modes to render paragraphs.
    render_modes = false,
    -- Amount of margin to add to the left of paragraphs.
    -- If a float < 1 is provided it is treated as a percentage of available window space.
    -- Output is evaluated depending on the type.
    -- | function | `value(context)` |
    -- | number   | `value`          |
    left_margin = 0,
    -- Amount of padding to add to the first line of each paragraph.
    -- Output is evaluated using the same logic as 'left_margin'.
    indent = 0,
    -- Minimum width to use for paragraphs.
    min_width = 0,
  },
  code = {
    -- Turn on / off code block & inline code rendering.
    enabled = true,
    -- Additional modes to render code blocks.
    render_modes = false,
    -- Turn on / off sign column related rendering.
    sign = true,
    -- Whether to conceal nodes at the top and bottom of code blocks.
    conceal_delimiters = true,
    -- Turn on / off language heading related rendering.
    language = true,
    -- Determines where language icon is rendered.
    -- | right | right side of code block |
    -- | left  | left side of code block  |
    position = "left",
    -- Whether to include the language icon above code blocks.
    language_icon = true,
    -- Whether to include the language name above code blocks.
    language_name = true,
    -- Whether to include the language info above code blocks.
    language_info = true,
    -- Amount of padding to add around the language.
    -- If a float < 1 is provided it is treated as a percentage of available window space.
    language_pad = 0,
    -- A list of language names for which background highlighting will be disabled.
    -- Likely because that language has background highlights itself.
    -- Use a boolean to make behavior apply to all languages.
    -- Borders above & below blocks will continue to be rendered.
    disable_background = { "diff" },
    -- Width of the code block background.
    -- | block | width of the code block  |
    -- | full  | full width of the window |
    width = "full",
    -- Amount of margin to add to the left of code blocks.
    -- If a float < 1 is provided it is treated as a percentage of available window space.
    -- Margin available space is computed after accounting for padding.
    left_margin = 0,
    -- Amount of padding to add to the left of code blocks.
    -- If a float < 1 is provided it is treated as a percentage of available window space.
    left_pad = 0,
    -- Amount of padding to add to the right of code blocks when width is 'block'.
    -- If a float < 1 is provided it is treated as a percentage of available window space.
    right_pad = 0,
    -- Minimum width to use for code blocks when width is 'block'.
    min_width = 0,
    -- Determines how the top / bottom of code block are rendered.
    -- | none  | do not render a border                               |
    -- | thick | use the same highlight as the code body              |
    -- | thin  | when lines are empty overlay the above & below icons |
    -- | hide  | conceal lines unless language name or icon is added  |
    border = "hide",
    -- Used above code blocks to fill remaining space around language.
    language_border = "█",
    -- Added to the left of language.
    language_left = "",
    -- Added to the right of language.
    language_right = "",
    -- Used above code blocks for thin border.
    above = "▄",
    -- Used below code blocks for thin border.
    below = "▀",
    -- Turn on / off inline code related rendering.
    inline = true,
    -- Icon to add to the left of inline code.
    inline_left = "",
    -- Icon to add to the right of inline code.
    inline_right = "",
    -- Padding to add to the left & right of inline code.
    inline_pad = 0,
    -- Priority to assign to code background highlight.
    priority = 140,
    -- Highlight for code blocks.
    highlight = "RenderMarkdownCode",
    -- Highlight for code info section, after the language.
    highlight_info = "RenderMarkdownCodeInfo",
    -- Highlight for language, overrides icon provider value.
    highlight_language = nil,
    -- Highlight for border, use false to add no highlight.
    highlight_border = "RenderMarkdownCodeBorder",
    -- Highlight for language, used if icon provider does not have a value.
    highlight_fallback = "RenderMarkdownCodeFallback",
    -- Highlight for inline code.
    highlight_inline = "RenderMarkdownCodeInline",
    -- Determines how code blocks & inline code are rendered.
    -- | none     | { enabled = false }                           |
    -- | normal   | { language = false }                          |
    -- | language | { disable_background = true, inline = false } |
    -- | full     | uses all default values                       |
    style = "full",
  },
  dash = {
    -- Useful context to have when evaluating values.
    -- | width | width of the current window |

    -- Turn on / off thematic break rendering.
    enabled = true,
    -- Additional modes to render dash.
    render_modes = false,
    -- Replaces '---'|'***'|'___'|'* * *' of 'thematic_break'.
    -- The icon gets repeated across the window's width.
    icon = "─",
    -- Width of the generated line.
    -- If a float < 1 is provided it is treated as a percentage of available window space.
    -- Output is evaluated depending on the type.
    -- | function | `value(context)`    |
    -- | number   | `value`             |
    -- | full     | width of the window |
    width = "full",
    -- Amount of margin to add to the left of dash.
    -- If a float < 1 is provided it is treated as a percentage of available window space.
    left_margin = 0,
    -- Priority to assign to dash.
    priority = nil,
    -- Highlight for the whole line generated from the icon.
    highlight = "RenderMarkdownDash",
  },
  document = {
    -- Turn on / off document rendering.
    enabled = true,
    -- Additional modes to render document.
    render_modes = false,
    -- Ability to conceal arbitrary ranges of text based on lua patterns, @see :h lua-patterns.
    -- Relies entirely on user to set patterns that handle their edge cases.
    conceal = {
      -- Matched ranges will be concealed using character level conceal.
      char_patterns = {},
      -- Matched ranges will be concealed using line level conceal.
      line_patterns = {},
    },
  },
  bullet = {
    -- Useful context to have when evaluating values.
    -- | level | how deeply nested the list is, 1-indexed          |
    -- | index | how far down the item is at that level, 1-indexed |
    -- | value | text value of the marker node                     |

    -- Turn on / off list bullet rendering
    enabled = true,
    -- Additional modes to render list bullets
    render_modes = false,
    -- Replaces '-'|'+'|'*' of 'list_item'.
    -- If the item is a 'checkbox' a conceal is used to hide the bullet instead.
    -- Output is evaluated depending on the type.
    -- | function   | `value(context)`                                    |
    -- | string     | `value`                                             |
    -- | string[]   | `cycle(value, context.level)`                       |
    -- | string[][] | `clamp(cycle(value, context.level), context.index)` |
    icons = { "●", "○", "◆", "◇" },
    -- Replaces 'n.'|'n)' of 'list_item'.
    -- Output is evaluated using the same logic as 'icons'.
    ordered_icons = function(ctx)
      local value = vim.trim(ctx.value)
      local index = tonumber(value:sub(1, #value - 1))
      return ("%d."):format(index > 1 and index or ctx.index)
    end,
    -- Padding to add to the left of bullet point.
    -- Output is evaluated depending on the type.
    -- | function | `value(context)` |
    -- | integer  | `value`          |
    left_pad = 0,
    -- Padding to add to the right of bullet point.
    -- Output is evaluated using the same logic as 'left_pad'.
    right_pad = 0,
    -- Highlight for the bullet icon.
    -- Output is evaluated using the same logic as 'icons'.
    highlight = "RenderMarkdownBullet",
    -- Highlight for item associated with the bullet point.
    -- Output is evaluated using the same logic as 'icons'.
    scope_highlight = {},
    -- Priority to assign to scope highlight.
    scope_priority = nil,
  },
  checkbox = {
    -- Checkboxes are a special instance of a 'list_item' that start with a 'shortcut_link'.
    -- There are two special states for unchecked & checked defined in the markdown grammar.

    -- Turn on / off checkbox state rendering.
    enabled = true,
    -- Additional modes to render checkboxes.
    render_modes = false,
    -- Render the bullet point before the checkbox.
    bullet = false,
    -- Padding to add to the left of checkboxes.
    left_pad = 0,
    -- Padding to add to the right of checkboxes.
    right_pad = 1,
    unchecked = {
      -- Replaces '[ ]' of 'task_list_marker_unchecked'.
      icon = "󰄱 ",
      -- Highlight for the unchecked icon.
      highlight = "RenderMarkdownUnchecked",
      -- Highlight for item associated with unchecked checkbox.
      scope_highlight = nil,
    },
    checked = {
      -- Replaces '[x]' of 'task_list_marker_checked'.
      icon = "󰱒 ",
      -- Highlight for the checked icon.
      highlight = "RenderMarkdownChecked",
      -- Highlight for item associated with checked checkbox.
      scope_highlight = nil,
    },
        -- Define custom checkbox states, more involved, not part of the markdown grammar.
        -- As a result this requires neovim >= 0.10.0 since it relies on 'inline' extmarks.
        -- The key is for healthcheck and to allow users to change its values, value type below.
        -- | raw             | matched against the raw text of a 'shortcut_link'           |
        -- | rendered        | replaces the 'raw' value when rendering                     |
        -- | highlight       | highlight for the 'rendered' icon                           |
        -- | scope_highlight | optional highlight for item associated with custom checkbox |
        -- stylua: ignore
        custom = {
            todo = { raw = '[-]', rendered = '󰥔 ', highlight = 'RenderMarkdownTodo', scope_highlight = nil },
        },
    -- Priority to assign to scope highlight.
    scope_priority = nil,
  },
  quote = {
    -- Turn on / off block quote & callout rendering.
    enabled = true,
    -- Additional modes to render quotes.
    render_modes = false,
    -- Replaces '>' of 'block_quote'.
    icon = "▋",
    -- Whether to repeat icon on wrapped lines. Requires neovim >= 0.10. This will obscure text
    -- if incorrectly configured with :h 'showbreak', :h 'breakindent' and :h 'breakindentopt'.
    -- A combination of these that is likely to work follows.
    -- | showbreak      | '  ' (2 spaces)   |
    -- | breakindent    | true              |
    -- | breakindentopt | '' (empty string) |
    -- These are not validated by this plugin. If you want to avoid adding these to your main
    -- configuration then set them in win_options for this plugin.
    repeat_linebreak = false,
    -- Highlight for the quote icon.
    -- If a list is provided output is evaluated by `cycle(value, level)`.
    highlight = {
      "RenderMarkdownQuote1",
      "RenderMarkdownQuote2",
      "RenderMarkdownQuote3",
      "RenderMarkdownQuote4",
      "RenderMarkdownQuote5",
      "RenderMarkdownQuote6",
    },
  },
  pipe_table = {
    -- Turn on / off pipe table rendering.
    enabled = true,
    -- Additional modes to render pipe tables.
    render_modes = false,
    -- Pre configured settings largely for setting table border easier.
    -- | heavy  | use thicker border characters     |
    -- | double | use double line border characters |
    -- | round  | use round border corners          |
    -- | none   | does nothing                      |
    preset = "none",
    -- Determines how individual cells of a table are rendered.
    -- | overlay | writes completely over the table, removing conceal behavior and highlights |
    -- | raw     | replaces only the '|' characters in each row, leaving the cells unmodified |
    -- | padded  | raw + cells are padded to maximum visual width for each column             |
    -- | trimmed | padded except empty space is subtracted from visual width calculation      |
    cell = "padded",
    -- Adjust the computed width of table cells using custom logic.
    cell_offset = function()
      return 0
    end,
    -- Amount of space to put between cell contents and border.
    padding = 1,
    -- Minimum column width to use for padded or trimmed cell.
    min_width = 0,
        -- Characters used to replace table border.
        -- Correspond to top(3), delimiter(3), bottom(3), vertical, & horizontal.
        -- stylua: ignore
        border = {
            '┌', '┬', '┐',
            '├', '┼', '┤',
            '└', '┴', '┘',
            '│', '─',
        },
    -- Turn on / off top & bottom lines.
    border_enabled = true,
    -- Always use virtual lines for table borders instead of attempting to use empty lines.
    -- Will be automatically enabled if indentation module is enabled.
    border_virtual = false,
    -- Gets placed in delimiter row for each column, position is based on alignment.
    alignment_indicator = "━",
    -- Highlight for table heading, delimiter, and the line above.
    head = "RenderMarkdownTableHead",
    -- Highlight for everything else, main table rows and the line below.
    row = "RenderMarkdownTableRow",
    -- Highlight for inline padding used to add back concealed space.
    filler = "RenderMarkdownTableFill",
    -- Determines how the table as a whole is rendered.
    -- | none   | { enabled = false }        |
    -- | normal | { border_enabled = false } |
    -- | full   | uses all default values    |
    style = "full",
  },
  callout = {
    -- Callouts are a special instance of a 'block_quote' that start with a 'shortcut_link'.
    -- The key is for healthcheck and to allow users to change its values, value type below.
    -- | raw        | matched against the raw text of a 'shortcut_link', case insensitive |
    -- | rendered   | replaces the 'raw' value when rendering                             |
    -- | highlight  | highlight for the 'rendered' text and quote markers                 |
    -- | quote_icon | optional override for quote.icon value for individual callout       |
    -- | category   | optional metadata useful for filtering                              |

    note = {
      raw = "[!NOTE]",
      rendered = "󰋽 Note",
      highlight = "RenderMarkdownInfo",
      category = "github",
    },
    tip = {
      raw = "[!TIP]",
      rendered = "󰌶 Tip",
      highlight = "RenderMarkdownSuccess",
      category = "github",
    },
    important = {
      raw = "[!IMPORTANT]",
      rendered = "󰅾 Important",
      highlight = "RenderMarkdownHint",
      category = "github",
    },
    warning = {
      raw = "[!WARNING]",
      rendered = "󰀪 Warning",
      highlight = "RenderMarkdownWarn",
      category = "github",
    },
    caution = {
      raw = "[!CAUTION]",
      rendered = "󰳦 Caution",
      highlight = "RenderMarkdownError",
      category = "github",
    },
    -- Obsidian: https://help.obsidian.md/Editing+and+formatting/Callouts
    abstract = {
      raw = "[!ABSTRACT]",
      rendered = "󰨸 Abstract",
      highlight = "RenderMarkdownInfo",
      category = "obsidian",
    },
    summary = {
      raw = "[!SUMMARY]",
      rendered = "󰨸 Summary",
      highlight = "RenderMarkdownInfo",
      category = "obsidian",
    },
    tldr = {
      raw = "[!TLDR]",
      rendered = "󰨸 Tldr",
      highlight = "RenderMarkdownInfo",
      category = "obsidian",
    },
    info = {
      raw = "[!INFO]",
      rendered = "󰋽 Info",
      highlight = "RenderMarkdownInfo",
      category = "obsidian",
    },
    todo = {
      raw = "[!TODO]",
      rendered = "󰗡 Todo",
      highlight = "RenderMarkdownInfo",
      category = "obsidian",
    },
    hint = {
      raw = "[!HINT]",
      rendered = "󰌶 Hint",
      highlight = "RenderMarkdownSuccess",
      category = "obsidian",
    },
    success = {
      raw = "[!SUCCESS]",
      rendered = "󰄬 Success",
      highlight = "RenderMarkdownSuccess",
      category = "obsidian",
    },
    check = {
      raw = "[!CHECK]",
      rendered = "󰄬 Check",
      highlight = "RenderMarkdownSuccess",
      category = "obsidian",
    },
    done = {
      raw = "[!DONE]",
      rendered = "󰄬 Done",
      highlight = "RenderMarkdownSuccess",
      category = "obsidian",
    },
    question = {
      raw = "[!QUESTION]",
      rendered = "󰘥 Question",
      highlight = "RenderMarkdownWarn",
      category = "obsidian",
    },
    help = {
      raw = "[!HELP]",
      rendered = "󰘥 Help",
      highlight = "RenderMarkdownWarn",
      category = "obsidian",
    },
    faq = {
      raw = "[!FAQ]",
      rendered = "󰘥 Faq",
      highlight = "RenderMarkdownWarn",
      category = "obsidian",
    },
    attention = {
      raw = "[!ATTENTION]",
      rendered = "󰀪 Attention",
      highlight = "RenderMarkdownWarn",
      category = "obsidian",
    },
    failure = {
      raw = "[!FAILURE]",
      rendered = "󰅖 Failure",
      highlight = "RenderMarkdownError",
      category = "obsidian",
    },
    fail = {
      raw = "[!FAIL]",
      rendered = "󰅖 Fail",
      highlight = "RenderMarkdownError",
      category = "obsidian",
    },
    missing = {
      raw = "[!MISSING]",
      rendered = "󰅖 Missing",
      highlight = "RenderMarkdownError",
      category = "obsidian",
    },
    danger = {
      raw = "[!DANGER]",
      rendered = "󱐌 Danger",
      highlight = "RenderMarkdownError",
      category = "obsidian",
    },
    error = {
      raw = "[!ERROR]",
      rendered = "󱐌 Error",
      highlight = "RenderMarkdownError",
      category = "obsidian",
    },
    bug = {
      raw = "[!BUG]",
      rendered = "󰨰 Bug",
      highlight = "RenderMarkdownError",
      category = "obsidian",
    },
    example = {
      raw = "[!EXAMPLE]",
      rendered = "󰉹 Example",
      highlight = "RenderMarkdownHint",
      category = "obsidian",
    },
    quote = {
      raw = "[!QUOTE]",
      rendered = "󱆨 Quote",
      highlight = "RenderMarkdownQuote",
      category = "obsidian",
    },
    cite = {
      raw = "[!CITE]",
      rendered = "󱆨 Cite",
      highlight = "RenderMarkdownQuote",
      category = "obsidian",
    },
  },
  link = {
    -- Turn on / off inline link icon rendering.
    enabled = true,
    -- Additional modes to render links.
    render_modes = false,
    -- How to handle footnote links, start with a '^'.
    footnote = {
      -- Turn on / off footnote rendering.
      enabled = true,
      -- Inlined with content.
      icon = "󰯔 ",
      -- Replace value with superscript equivalent.
      superscript = true,
      -- Added before link content.
      prefix = "",
      -- Added after link content.
      suffix = "",
    },
    -- Inlined with 'image' elements.
    image = "󰥶 ",
    -- Inlined with 'email_autolink' elements.
    email = "󰀓 ",
    -- Fallback icon for 'inline_link' and 'uri_autolink' elements.
    hyperlink = "󰌹 ",
    -- Applies to the inlined icon as a fallback.
    highlight = "RenderMarkdownLink",
    -- Applies to the link title.
    highlight_title = "RenderMarkdownLinkTitle",
    -- Applies to WikiLink elements.
    wiki = {
      icon = "󱗖 ",
      body = function()
        return nil
      end,
      highlight = "RenderMarkdownWikiLink",
      scope_highlight = nil,
    },
    -- Define custom destination patterns so icons can quickly inform you of what a link
    -- contains. Applies to 'inline_link', 'uri_autolink', and wikilink nodes. When multiple
    -- patterns match a link the one with the longer pattern is used.
    -- The key is for healthcheck and to allow users to change its values, value type below.
    -- | pattern   | matched against the destination text                            |
    -- | icon      | gets inlined before the link text                               |
    -- | kind      | optional determines how pattern is checked                      |
    -- |           | pattern | @see :h lua-patterns, is the default if not set       |
    -- |           | suffix  | @see :h vim.endswith()                                |
    -- | priority  | optional used when multiple match, uses pattern length if empty |
    -- | highlight | optional highlight for 'icon', uses fallback highlight if empty |
    custom = {
      web = { pattern = "^http", icon = "󰖟 " },
      apple = { pattern = "apple%.com", icon = " " },
      discord = { pattern = "discord%.com", icon = "󰙯 " },
      github = { pattern = "github%.com", icon = "󰊤 " },
      gitlab = { pattern = "gitlab%.com", icon = "󰮠 " },
      google = { pattern = "google%.com", icon = "󰊭 " },
      hackernews = { pattern = "ycombinator%.com", icon = " " },
      linkedin = { pattern = "linkedin%.com", icon = "󰌻 " },
      microsoft = { pattern = "microsoft%.com", icon = " " },
      neovim = { pattern = "neovim%.io", icon = " " },
      reddit = { pattern = "reddit%.com", icon = "󰑍 " },
      slack = { pattern = "slack%.com", icon = "󰒱 " },
      stackoverflow = { pattern = "stackoverflow%.com", icon = "󰓌 " },
      steam = { pattern = "steampowered%.com", icon = " " },
      twitter = { pattern = "x%.com", icon = " " },
      wikipedia = { pattern = "wikipedia%.org", icon = "󰖬 " },
      youtube = { pattern = "youtube[^.]*%.com", icon = "󰗃 " },
      youtube_short = { pattern = "youtu%.be", icon = "󰗃 " },
    },
  },
  sign = {
    -- Turn on / off sign rendering.
    enabled = true,
    -- Applies to background of sign text.
    highlight = "RenderMarkdownSign",
  },
  inline_highlight = {
    -- Mimics Obsidian inline highlights when content is surrounded by double equals.
    -- The equals on both ends are concealed and the inner content is highlighted.

    -- Turn on / off inline highlight rendering.
    enabled = true,
    -- Additional modes to render inline highlights.
    render_modes = false,
    -- Applies to background of surrounded text.
    highlight = "RenderMarkdownInlineHighlight",
    -- Define custom highlights based on text prefix.
    -- The key is for healthcheck and to allow users to change its values, value type below.
    -- | prefix    | matched against text body, @see :h vim.startswith() |
    -- | highlight | highlight for text body                             |
    custom = {},
  },
  indent = {
    -- Mimic org-indent-mode behavior by indenting everything under a heading based on the
    -- level of the heading. Indenting starts from level 2 headings onward by default.

    -- Turn on / off org-indent-mode.
    enabled = false,
    -- Additional modes to render indents.
    render_modes = false,
    -- Amount of additional padding added for each heading level.
    per_level = 2,
    -- Heading levels <= this value will not be indented.
    -- Use 0 to begin indenting from the very first level.
    skip_level = 1,
    -- Do not indent heading titles, only the body.
    skip_heading = false,
    -- Prefix added when indenting, one per level.
    icon = "▎",
    -- Priority to assign to extmarks.
    priority = 0,
    -- Applied to icon.
    highlight = "RenderMarkdownIndent",
  },
  html = {
    -- Turn on / off all HTML rendering.
    enabled = true,
    -- Additional modes to render HTML.
    render_modes = false,
    comment = {
      -- Useful context to have when evaluating values.
      -- | text | text value of the comment node |

      -- Turn on / off HTML comment concealing.
      conceal = true,
      -- Text to inline before the concealed comment.
      -- Output is evaluated depending on the type.
      -- | function | `value(context)` |
      -- | string   | `value`          |
      -- | nil      | nothing          |
      text = nil,
      -- Highlight for the inlined text.
      highlight = "RenderMarkdownHtmlComment",
    },
    -- HTML tags whose start and end will be hidden and icon shown.
    -- The key is matched against the tag name, value type below.
    -- | icon            | optional icon inlined at start of tag           |
    -- | highlight       | optional highlight for the icon                 |
    -- | scope_highlight | optional highlight for item associated with tag |
    tag = {},
  },
  win_options = {
    -- Window options to use that change between rendered and raw view.

    -- @see :h 'conceallevel'
    conceallevel = {
      -- Used when not being rendered, get user setting.
      default = vim.o.conceallevel,
      -- Used when being rendered, concealed text is completely hidden.
      rendered = 3,
    },
    -- @see :h 'concealcursor'
    concealcursor = {
      -- Used when not being rendered, get user setting.
      default = vim.o.concealcursor,
      -- Used when being rendered, show concealed text in all modes.
      rendered = "",
    },
  },
  overrides = {
    -- More granular configuration mechanism, allows different aspects of buffers to have their own
    -- behavior. Values default to the top level configuration if no override is provided. Supports
    -- the following fields:
    --   enabled, render_modes, debounce, anti_conceal, bullet, callout, checkbox, code, dash,
    --   document, heading, html, indent, inline_highlight, latex, link, padding, paragraph,
    --   pipe_table, quote, sign, win_options, yaml

    -- Override for different buflisted values, @see :h 'buflisted'.
    buflisted = {},
    -- Override for different buftype values, @see :h 'buftype'.
    buftype = {
      nofile = {
        render_modes = true,
        padding = { highlight = "NormalFloat" },
        sign = { enabled = false },
      },
    },
    -- Override for different filetype values, @see :h 'filetype'.
    filetype = {},
    -- Override for preview buffer.
    preview = {
      render_modes = true,
    },
  },
  custom_handlers = {
    -- Mapping from treesitter language to user defined handlers.
    -- @see [Custom Handlers](doc/custom-handlers.md)
  },
  yaml = {
    -- Turn on / off all yaml rendering.
    enabled = true,
    -- Additional modes to render yaml.
    render_modes = false,
  },
}
