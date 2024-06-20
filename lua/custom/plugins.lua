local lazy_plugins = {
  -- Feline
  {
    'famiu/feline.nvim',
    config = function()
      local feline = require('feline')

      local components = {
        active = {{}, {}}, -- Two sections for the active statusline
        inactive = {{}, {}}, -- Two sections for the inactive statusline
      }

      -- Function to get the competitest_title variable
      local function get_competitest_title()
        local buf_num = vim.api.nvim_get_current_buf()
        local ok, title = pcall(vim.api.nvim_buf_get_var, buf_num, 'competitest_title')
        if ok then
          return title
        else
          return ''
        end
      end

      -- Define your custom component
      local custom_title_component = {
        provider = get_competitest_title,
        hl = {
          fg = 'white',
          bg = 'blue',
        },
        left_sep = ' ',
        right_sep = ' ',
      }

      -- Add your component to the active statusline
      table.insert(components.active[1], custom_title_component)

      -- Setup Feline with your custom components
      feline.setup({
        components = components,
      })
    end
  },
  -- Leap  
  {
    lazy = false,
    "ggandor/leap.nvim"
  },
  {
    'MunifTanjim/nui.nvim',
    lazy = false,  -- Load it eagerly if required
  },
  -- Competitest (for C++)
  {
    "xeluxee/competitest.nvim",
    requires = "MunifTanjim/nui.nvim",
    lazy = false,
    config = function()
      local ok, competitest = pcall(require, "competitest")
      if not ok then
        return
      end
      competitest.setup({
        local_config_file_name = ".competitest.lua",
        floating_border = "rounded",
        floating_border_highlight = "FloatBorder",
        picker_ui = {
          width = 0.2,
          height = 0.3,
          mappings = {
            focus_next = { "j", "<down>", "<Tab>" },
            focus_prev = { "k", "<up>", "<S-Tab>" },
            close = { "<esc>", "<C-c>", "q", "Q" },
            submit = { "<cr>" },
          },
        },
        editor_ui = {
          popup_width = 0.4,
          popup_height = 0.6,
          show_nu = true,
          show_rnu = false,
          normal_mode_mappings = {
            switch_window = { "<C-h>", "<C-l>", "<C-i>" },
            save_and_close = "<C-s>",
            cancel = { "q", "Q" },
          },
          insert_mode_mappings = {
            switch_window = { "<C-h>", "<C-l>", "<C-i>" },
            save_and_close = "<C-s>",
            cancel = "<C-q>",
          },
        },
        runner_ui = {
          interface = "split",
          selector_show_nu = false,
          selector_show_rnu = false,
          show_nu = false,
          show_rnu = false,
          mappings = {
            run_again = "R",
            run_all_again = "<C-r>",
            kill = "K",
            kill_all = "<C-k>",
            view_input = { "i", "I" },
            view_output = { "a", "A" },
            view_stdout = { "o", "O" },
            view_stderr = { "e", "E" },
            toggle_diff = { "d", "D" },
            close = { "q", "Q" },
          },
          viewer = {
            width = 0.5,
            height = 0.5,
            show_nu = true,
            show_rnu = false,
            close_mappings = { "q", "Q" },
          },
        },
        popup_ui = {
          total_width = 0.8,
          total_height = 0.8,
          layout = {
            { 4, "tc" },
            { 5, { { 1, "so" }, { 1, "si" } } },
            { 5, { { 1, "eo" }, { 1, "se" } } },
          },
        },
        split_ui = {
          position = "right",
          relative_to_editor = true,
          total_width = .5,
          vertical_layout = {
            { 1, "tc" },
            { 1, { { 1, "so" }, { 1, "eo" } } },
            { 1, { { 1, "si" }, { 1, "se" } } },
          },
          total_height = 0.4,
          horizontal_layout = {
            { 2, "tc" },
            { 3, { { 1, "so" }, { 1, "si" } } },
            { 3, { { 1, "eo" }, { 1, "se" } } },
          },
        },
        save_current_file = true,
        save_all_files = false,
        compile_directory = ".",
        compile_command = {
          cpp = {
            exec = "g++-14",
            args = { "-std=c++17", "-Wall", "-DLOCAL", "$(FNAME)", "-o", "$(FNOEXT)" },
          },
          rust = { exec = "rustc", args = { "$(FNAME)" } },
          java = { exec = "javac", args = { "$(FNAME)" } },
        },
        running_directory = ".",
        run_command = {
          c = { exec = "./$(FNOEXT)" },
          cpp = { exec = "./$(FNOEXT)" },
          rust = { exec = "./$(FNOEXT)" },
          python = { exec = "python3", args = { "$(FNAME)" } },
          java = { exec = "java", args = { "$(FNOEXT)" } },
        },
        multiple_testing = -1,
        maximum_time = 5000,
        output_compare_method = "squish",
        view_output_diff = false,
        testcases_directory = ".",
        testcases_use_single_file = true,
        testcases_auto_detect_storage = true,
        testcases_single_file_format = "$(FNOEXT).testcases",
        testcases_input_file_format = "$(FNOEXT)_input$(TCNUM).txt",
        testcases_output_file_format = "$(FNOEXT)_output$(TCNUM).txt",
        companion_port = 27121,
        receive_print_message = true,
        template_file = { cpp = "~/downloads/code/CP/template.cpp" },
        evaluate_template_modifiers = false,
        date_format = "%c",
        received_files_extension = "cpp",
        received_problems_path = "$(HOME)/downloads/code/cp/In Progress/$(JAVA_TASK_CLASS).$(FEXT)",
        received_problems_prompt_path = false,
        received_contests_directory = "$(HOME)/downloads/code/cp/In Progress/$(CONTEST)",
        received_contests_problems_path = "$(JAVA_TASK_CLASS).$(FEXT)",
        received_contests_prompt_directory = false,
        received_contests_prompt_extension = true,
        open_received_problems = false,
        open_received_contests = true,
        replace_received_testcases = false,
      })

    end,
  },
  -- LSP
  {
    lazy = false,
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
    end,
  },
  -- Presence
  {
    "jiriks74/presence.nvim",
    event = "UIEnter",
  },
}

return lazy_plugins
