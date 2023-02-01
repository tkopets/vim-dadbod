if exists('g:autoloaded_db_databricks')
  finish
endif
let g:autoloaded_db_databricks = 1


function! db#adapter#databricks#interactive(url) abort
  let params = db#url#parse(a:url)
  let result = ['dbsqlcli']
  if has_key(params, 'host')
    let result = result + ['--hostname', params.host]
  endif
  if has_key(params, 'path')
    let result = result + ['--http-path', params.path]
  endif
  if has_key(params, 'password')
    let result = result + ['--access-token', params.password]
  endif
  return result
endfunction


function! db#adapter#databricks#input(url, in) abort
  let result = db#adapter#databricks#interactive(a:url)
  let result = result + ['--table-format', 'ascii']
  let result = result + ['--execute', a:in]
  return result
endfunction


function! db#adapter#databricks#massage(input) abort
  if a:input =~# ";\s*\n*$"
    return a:input
  endif
  return a:input . "\n;"
endfunction
