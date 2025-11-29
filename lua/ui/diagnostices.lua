local signs = {
	Error = vim.icons.diagnostics.Error,
	Warn = vim.icons.diagnostics.Warning,
	Hint = vim.icons.diagnostics.Hint,
	Info = vim.icons.diagnostics.Information,
}


local function DiagnosticSigns() 
    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    return {

    }
end

vim.diagnostic.config({
	underline = false,
	signs = false,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = true,
		header = "",
		prefix = "",
	},
})

DiagnosticSigns()

-- for type, icon in pairs(signs) do
-- 	local hl = "DiagnosticSign" .. type
-- 	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
-- end
