vim.api.nvim_create_autocmd({"BufWritePost"}, {
  pattern = {"**/ekkenrepo/*/**"},
  command = "silent! !%:p:h/../gen.sh %:p:h",
})
