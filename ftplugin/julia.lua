vim.opt.shiftwidth = 4
vim.g.julia_set_indentation = 4
vim.opt.textwidth = 92

-- This is compatible with the Julia VSCode plugin:
-- https://www.julia-vscode.org/docs/stable/userguide/runningcode/#Julia:-Execute-Code-Cell-in-REPL
vim.b.slime_cell_delimiter = "^\\s*##"
