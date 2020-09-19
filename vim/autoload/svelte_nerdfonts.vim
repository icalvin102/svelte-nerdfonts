function! s:import_to_fzf(importstr)
    let l:g = matchlist(a:importstr, '\v\*(.*)\*')
    let l:n = matchlist(a:importstr, '\v as ([^ ]*) ')
    let l:p = matchlist(a:importstr, '\v''\.\/(.*)''')
    return printf ("%40s %s %s", l:n[1], l:g[1], l:p[1])
endfunction


function! s:fzf_to_import(value)
    let l:values = split(trim(a:value), '\s\+')
    return 'import { default as '. l:values[0] .' } from
        \ ''svelte-nerdfonts/icons/'. l:values[2] . '''; // ' . l:values[1]
endfunction


function! svelte_nerdfonts#get_index_path()
    let l:path = ''
    if exists('g:svelte_nerdfonts_path')
        let l:path = g:svelte_nerdfonts_path . '/icons/index.js'
        if filereadable(l:path)
            return l:path
        endif
        echoe 'g:svelte_nerdfonts_path is set but '. l:path .' is not a file'
    endif

    let l:cmd = 'node -e
        \ ''console.log(require.resolve("svelte-nerdfonts/icons"))'''
    let l:path = systemlist(l:cmd)

    if v:shell_error == 0 && filereadable(l:path[0])
        return l:path[0]
    endif
    return ''
endfunction


function! svelte_nerdfonts#add_imports()
    let l:file_path = svelte_nerdfonts#get_index_path()
    if len(l:file_path) == 0
        echoe '"svelte-nerdfonts" module path not found.
            \ Run "npm i svelte-nerdfonts"
            \ and/or run vim from within the svelte project'
        return
    endif 

    let l:imports = readfile(l:file_path)
    let l:fzf_list = map(l:imports, {k,v -> s:import_to_fzf(v)})
    let l:cl = line('.')

    call fzf#run({
        \ 'source': l:fzf_list,
        \ 'sink*': {l -> append(l:cl, map(l, {k,v -> s:fzf_to_import(v)}))},
        \ 'options': g:svelte_nerdfonts_fzf_options}) 
endfunction


function! svelte_nerdfonts#add_icons()
    let l:cl = line('.')
    let l:cursor = getcurpos()
    let l:importnames = []
    let l:pairend = 'svelte-nerdfonts/icons'
    call cursor(1, 1)

    while 1
        let l:endpos = search(l:pairend, 'W')
        if l:endpos == 0
            break
        endif
        let l:startpos = searchpair('import', '', l:pairend, 'bnr') 
        let l:statement = join(getline(l:startpos, l:endpos))
        let l:importstr = matchlist(l:statement, '\v\{\s*(\S.*\S)\s*\}')
        if len(l:importstr) < 2 
            continue
        endif
        let l:importstr = l:importstr[1]
        let l:singleimports = split(l:importstr, '\v(\s*,\s*)')
        let l:names = map(l:singleimports, {k, v -> matchstr(v, '\v\S+$')})
        let l:importnames += l:names
    endwhile
    
    call cursor(l:cursor[1], l:cursor[2])

    call fzf#run({
      \ 'source':  l:importnames,
      \ 'sink*': {l -> append(l:cl, map(l, '"<Icon data={". v:val ."} />"'))},
      \ 'options': g:svelte_nerdfonts_fzf_options})
endfunction

