let g:svelte_nerdfonts_fzf_options = '--multi'

command! SNFAddImport :call svelte_nerdfonts#add_imports()
command! SNFAddIcon :call svelte_nerdfonts#add_icons()

nnoremap <leader>si :SNFAddImport<cr>
nnoremap <leader>sI :SNFAddIcon<cr>
