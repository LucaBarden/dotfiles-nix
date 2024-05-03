return {
    {
        'mbbill/undotree'
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = { "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    }
},
{
    "dstein64/vim-startuptime",
    -- lazy-load on a command
    cmd = "StartupTime",
    -- init is called during startup. Configuration for vim plugins typically should be set in an init function
    init = function()
        vim.g.startuptime_tries = 10
    end,
},
"svermeulen/vim-cutlass",
{
    "tpope/vim-commentary",
    keys = { { "gc", nil, mode = { "n", "x", "o" } } }
},
{
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    keys = {
        {
            "<leader>ol",
            function()
                require("lsp_lines").toggle()
            end,
        },
    },
    config = function()
        require("lsp_lines").setup({})
        vim.diagnostic.config({ virtual_lines = { only_current_line = true } })
    end,
},
{
    "rust-lang/rust.vim",
    ft = "rust",
    init = function ()
        vim.g.rustfmt_autosave = 1
    end
},
{
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    ft = { 'rust' },
    config = function ()
        local rt = require("rustaceanvim")
        local mason_registry = require("mason-registry")
        local cfg = require('rustaceanvim.config')


        local codelldb = mason_registry.get_package("codelldb")
        local extension_path = codelldb:get_install_path() .. "/extension/"
        local codelldb_path = extension_path .. "adapter/codelldb"
        local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"

        vim.g.rustaceanvim = function()
            return {
                dap = {
                    adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
                },
                server = {
                    capabilities = require("cmp_nvim_lsp").default_capabilities(),
                    on_attach = function(_, bufnr)
                        vim.keymap.set("n", "<Leader>k", rt.hover_actions.hover_actions, { buffer = bufnr })
                        vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
                    end,
                },
                tools = {
                    hover_actions = {
                        auto_focus = true,
                    },
                },
            }
        end
    end

},
{
    "folke/trouble.nvim",
    event = "BufRead",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    },
},
{
    'numToStr/Comment.nvim',
    opts = {
        padding = true,
        sticky = true,
        ignore = nil,
        opleader = {
            line = '<gc>',
        },
        mappings = {
            basic = false,
            extra = true,
        },
        post_hook = nil,
    },
    lazy = false,
    config = function ()
        require('Comment').setup()
    end
},
{
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    config = function ()
        local harpoon = require("harpoon")

        vim.keymap.set("n", "<leader>a" , function () harpoon:list():append() end)
        vim.keymap.set("n", "<C-e>", function () harpoon.ui:toggle_quick_menu(harpoon:list()) end)

        vim.keymap.set("n", "<C-j>", function() harpoon:list():select(1) end)
        vim.keymap.set("n", "<C-k>", function() harpoon:list():select(2) end)
        vim.keymap.set("n", "<C-l>", function() harpoon:list():select(3) end)
        vim.keymap.set("n", "<C-ö>", function() harpoon:list():select(4) end)

    end
},
{
    "prettier/vim-prettier",
    pin = true,
    ft = "javascript",
    config = function()
        vim.cmd([[autocmd! BufWritePre,TextChanged,InsertLeave *.js PrettierAsync]])
    end,
},
{
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    lazy = false, -- specify lazy = false because some lazy.nvim distributions set lazy = true by default
    -- tag = "*",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("neorg").setup {
            load = {
                ["core.defaults"] = {}, -- Loads default behaviour
                ["core.concealer"] = {}, -- Adds pretty icons to your documents
                ["core.dirman"] = { -- Manages Neorg workspaces
                config = {
                    workspaces = {
                        notes = "~/notes",
                    },
                },
            },
        },
    }
    end,
  },
  {
      "letieu/harpoon-lualine",
      dependencies = {
          {
              "ThePrimeagen/harpoon",
              branch = "harpoon2",
          }
      },
  }
}




