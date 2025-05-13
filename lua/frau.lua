local M = {}

local function splitLines(str)
    local lines = {}
    for line in string.gmatch(str, "[^\r\n]+") do
        table.insert(lines, line)
    end
    return lines
end
function M.frau(args)
    print(args.args)
    local manpage = args.args
    if manpage == "" then
        manpage = vim.fn.input("Man page: ")
        if manpage == "" then
            return
        end
    end
    local manresult = vim.system({ "man", manpage }, { text = true }):wait()
    if manresult.stdout ~= "" then
        vim.cmd("e " .. manpage)
        vim.api.nvim_buf_set_lines(0, 0, 0, false, splitLines(manresult.stdout))
        vim.cmd("norm! gg")
        vim.cmd("set filetype=man")
    end
end

-- Function to set up the plugin (Most package managers expect the plugin to have a setup function)
function M.setup()
    -- Create the user command
    vim.api.nvim_create_user_command("Frau", M.frau, { nargs = "*" })
end

-- Return the module
return M
