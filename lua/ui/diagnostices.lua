local signs = {
    Error = vim.icons.diagnostics.Error,
    Warn = vim.icons.diagnostics.Warning,
    Hint = vim.icons.diagnostics.Hint,
    Info = vim.icons.diagnostics.Information,
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
