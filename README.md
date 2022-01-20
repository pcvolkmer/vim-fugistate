# vim-fugistate

## Usage
This simple plugin provides a function which returns the name of current file with git status if available using
[vim-fugitive](https://github.com/tpope/vim-fugitive) and is intended for statusline integration.

```vim
:echo FugiState()
```

It will show something like `main.c [ M]` for modified file `main.c`.

```vim
:echo FugiStateGitDir()
```

This will show changes, new and unversioned files, e.g. `1 changed, 2 new, 3 unversioned`.

For example, to show the filename with git status using [lightline.vim](https://github.com/itchyny/lightline.vim),
configure as follows.

```vim
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filenamestatus', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'filenamestatus': 'FugiState'
      \ },
      \ }
```

### Filename configuration

The plugin provides `g:fugistate_expand_filename` to modify the value the filename should be expanded to.
Default value is set to `'%:t'` and will show filename without path. Use available values like `'%:p'` for full path
or `''` to use `@%` for directory/filename relative to current working directory.

### Labels

If you want other labels than `changed`, `new` and `unversioned`, add this to your vim config.

```vim
let g:fugistate_label_changed = '✹'
let g:fugistate_label_new = '✚'
let g:fugistate_label_unversioned = '★'
```

## License
This software is released under the MIT License, see LICENSE.
