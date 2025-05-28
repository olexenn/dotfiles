-- Create a function that returns a tagged keymap description
---@param plugin_name string
local plugin_keymap_desc = function(plugin_name)
    ---@param desc string
    return function(desc)
        -- Capitalize plugin name and concat with desc
        -- Examples:
        -- - 'nvim-tree': 'Nvim-tree: ${desc}'
        -- - 'conform': 'Conform: ${desc}'
        return plugin_name:gsub("^%l", string.upper) .. ": " .. desc
    end
end

local function get_pkg_path(pkg, path)
    pcall(require, "mason") -- make sure Mason is loaded. Will fail when generating docs
    local root = vim.env.MASON or (vim.fn.stdpath("data") .. "/mason")
    path = path or ""
    local ret = root .. "/packages/" .. pkg .. "/" .. path
    return ret
end

local desc = plugin_keymap_desc("dap")
local desc_dapui = plugin_keymap_desc("dapui")

local js_filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" }

---@param config {args?:string[]|fun():string[]?}
local function get_args(config)
    local args = type(config.args) == "function" and (config.args() or {}) or config.args or {}
    config = vim.deepcopy(config)
    ---@cast args string[]
    config.args = function()
        local new_args = vim.fn.input("Run with args: ", table.concat(args, " ")) --[[@as string]]
        return vim.split(vim.fn.expand(new_args) --[[@as string]], " ")
    end
    return config
end

local types_enabled = true
local toggle_types = function()
    types_enabled = not types_enabled
    require("dapui").update_render({ max_type_length = types_enabled and -1 or 0 })
end

return {
  "mfussenegger/nvim-dap",
  lazy = true,
  dependencies = {
    { "theHamsta/nvim-dap-virtual-text", opts = {} },
    { "nvim-neotest/nvim-nio" },

    {
       "rcarriga/nvim-dap-ui",
        keys = {
            {"<leader>duo", function() require("dapui").toggle() end, desc = desc_dapui("Toggle")},
            {"<leader>due", function() require("dapui").eval() end, desc = desc_dapui("Eval"), mode = {"n", "v"}},
            -- See https://github.com/rcarriga/nvim-dap-ui/issues/161#issuecomment-1304500935
            {"<leader>dut", function() toggle_types() end, desc = desc_dapui("Toggle types")},
        },
        ---@type dapui.Config
        opts = {
            floating = { border = "single" },
            layouts = {
              {
                  elements = {
                      { id = "scopes", size = 0.25 },
                      { id = "breakpoints", size = 0.25 },
                      { id = "stacks", size = 0.25 },
                      { id = "watches", size = 0.25 },
                  },
                  position = "left",
                  size = 40,
              },
              {
                  elements = {
                      { id = "console", size = 0.6 },
                      { id = "repl", size = 0.4 },
                  },
                  position = "bottom",
                  size = 10,
              },
          },
      },
    },
  },
  keys = {
    {"<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = desc("Breakpoint Condition")},
    {"<leader>db", function() require("dap").toggle_breakpoint() end, desc = desc("Toggle Breakpoint")},
    {"<leader>dc", function() require("dap").continue() end, desc = desc("Continue")},
    {"<leader>da", function() require("dap").continue({before = get_args}) end, desc = desc("Run with Args")},
    {"<leader>dC", function() require("dap").run_to_cursor() end, desc = desc("Run to Cursor")},
    {"<leader>dg", function() require("dap").goto_() end, desc = desc("Go to line (no execute)")},
    {"<leader>dj", function() require("dap").down() end, desc = desc("Down")},
    {"<leader>dk", function() require("dap").up() end, desc = desc("Up")},
    {"<leader>dl", function() require("dap").run_last() end, desc = desc("Run Last")},
    {"<leader>di", function() require("dap").step_into() end, desc = desc("Step Into")},
    {"<leader>dO", function() require("dap").step_out() end, desc = desc("Step Out")},
    {"<leader>do", function() require("dap").step_over() end, desc = desc("Step Over")},
    {"<leader>dp", function() require("dap").pause() end, desc = desc("Pause")},
    {"<leader>dr", function() require("dap").repl.toggle() end, desc = desc("Toggle REPL")},
    {"<leader>ds", function() require("dap").session() end, desc = desc("Session")},
    {"<leader>dt", function() require("dap").terminate() end, desc = desc("Terminate")},
    {"<leader>Td", function() require("neotest").run.run({strategy = "dap"}) end, desc = desc("Debug Nearest")},
    {"<leader>dwh", function() require("dap.ui.widgets").hover() end, desc = desc("Widget - Hover")},
    {
      "<leader>dws",
      function()
        local widgets = require("dap.ui.widgets")
        -- widgets.sidebar(widgets.scopes,
        --     {width = math.floor(vim.o.columns * 0.20)},
        --     'aboveleft vsplit'
        -- ).toggle()
        widgets.centered_float(widgets.scopes, { border = "single" })
      end,
      desc = desc("Widget - Scopes"),
    },
  },
  config = function ()
    local dap = require("dap")
    local dapui = require("dapui")

    dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open({}) end

    if not dap.adapters["node"] then
      dap.adapters["node"] = function(cb, config)
        if config.type == "node" then
          config.type = "pwa-node"
        end
        local nativeAdapter = dap.adapters["pwa-node"]
        if type(nativeAdapter) == "function" then
          nativeAdapter(cb, config)
        else
          cb(nativeAdapter)
        end
      end
    end

    vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

    -- setup dap config by VsCode launch.json file
    local dap_vscode = require("dap.ext.vscode")
    local json = require("plenary.json")
    ---@diagnostic disable-next-line: duplicate-set-field
    dap_vscode.json_decode = function(str)
      return vim.json.decode(json.json_strip_comments(str, {}))
    end

    dap_vscode.type_to_filetypes["node"] = js_filetypes

    if not dap.adapters["pwa-node"] then
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = {
            get_pkg_path("js-debug-adapter", "/js-debug/src/dapDebugServer.js"),
            "${port}",
          },
        },
      }
    end

    if not dap.adapters["pwa-chrome"] then
      dap.adapters["pwa-chrome"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = {
            get_pkg_path("js-debug-adapter", "/js-debug/src/dapDebugServer.js"),
            "${port}",
          },
        },
      }
    end

    if not dap.adapters["node"] then
      dap.adapters["node"] = function(cb, config)
        if config.type == "node" then
          config.type = "pwa-node"
        end
        local nativeAdapter = dap.adapters["pwa-node"]
        if type(nativeAdapter) == "function" then
          nativeAdapter(cb, config)
        else
          cb(nativeAdapter)
        end
      end
    end

    if not dap.adapters["chrome"] then
      dap.adapters["chrome"] = function(cb, config)
        if config.type == "chrome" then
          config.type = "pwa-chrome"
        end
        local nativeAdapter = dap.adapters["pwa-chrome"]
        if type(nativeAdapter) == "function" then
          nativeAdapter(cb, config)
        else
          cb(nativeAdapter)
        end
      end
    end

    for _, language in ipairs(js_filetypes) do
          dap.configurations[language] = {
              -- Debug single nodejs files
              {
                  name = "Launch file",
                  type = "pwa-node",
                  request = "launch",
                  program = "${file}",
                  cwd = "${workspaceFolder}",
                  args = { "${file}" },
                  sourceMaps = true,
                  sourceMapPathOverrides = {
                      ["./*"] = "${workspaceFolder}/src/*",
                  },
              },
              -- Debug nodejs processes (make sure to add --inspect when you run the process)
              {
                  name = "Attach",
                  type = "pwa-node",
                  request = "attach",
                  processId = require("dap.utils").pick_process,
                  cwd = "${workspaceFolder}",
                  sourceMaps = true,
              },
              {
                  name = "Debug Jest Tests",
                  type = "pwa-node",
                  request = "launch",
                  runtimeExecutable = "node",
                  runtimeArgs = { "${workspaceFolder}/node_modules/.bin/jest", "--runInBand" },
                  rootPath = "${workspaceFolder}",
                  cwd = "${workspaceFolder}",
                  console = "integratedTerminal",
                  internalConsoleOptions = "neverOpen",
                  -- args = {'${file}', '--coverage', 'false'},
                  -- sourceMaps = true,
                  -- skipFiles = {'node_internals/**', 'node_modules/**'},
              },
              {
                  name = "Debug Vitest Tests",
                  type = "pwa-node",
                  request = "launch",
                  cwd = vim.fn.getcwd(),
                  program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
                  args = { "run", "${file}" },
                  autoAttachChildProcesses = true,
                  smartStep = true,
                  skipFiles = { "<node_internals>/**", "node_modules/**" },
              },
              -- Debug web applications (client side)
              {
                  name = "Launch & Debug Chrome",
                  type = "pwa-chrome",
                  request = "launch",
                  url = function()
                      local co = coroutine.running()
                      return coroutine.create(function()
                          vim.ui.input({ prompt = "Enter URL: ", default = "http://localhost:3000" }, function(url)
                              if url == nil or url == "" then
                                  return
                              else
                                  coroutine.resume(co, url)
                              end
                          end)
                      end)
                  end,
                  webRoot = vim.fn.getcwd(),
                  protocol = "inspector",
                  sourceMaps = true,
                  userDataDir = false,
                  resolveSourceMapLocations = {
                      "${workspaceFolder}/**",
                      "!**/node_modules/**",
                  },

                  -- From https://github.com/lukas-reineke/dotfiles/blob/master/vim/lua/plugins/dap.lua
                  -- To test how it behaves
                  rootPath = "${workspaceFolder}",
                  cwd = "${workspaceFolder}",
                  console = "integratedTerminal",
                  internalConsoleOptions = "neverOpen",
                  sourceMapPathOverrides = {
                      ["./*"] = "${workspaceFolder}/src/*",
                  },
              },
              {
                  name = "----- ↑ launch.json configs (if available) ↑ -----",
                  type = "",
                  request = "launch",
              },
          }
      end
  end
}
