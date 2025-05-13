-- Main module for the Hello World plugin
local M = {}

function M.frau()
    local manpage = vim.fn.input("Man page: ")
    if manpage ~= "" then
        vim.cmd.tabnew(manpage .. ".c");
        vim.cmd('read !man ' .. manpage);
        vim.cmd('norm! gg')
    end
end

-- Function to set up the plugin (Most package managers expect the plugin to have a setup function)
function M.setup(opts)

    -- Create the user command
    vim.api.nvim_create_user_command("Frau", M.frau, { nargs = "*" })

    -- Set up a key mapping
    local keymap = '<leader>fp'

    -- Create the keymap
    vim.keymap.set('n', keymap, M.frau, {
        desc = "Say hello from our plugin",
        silent = true, -- Prevents the command from being echoed in the command line
    })
end

-- Return the module
return M
