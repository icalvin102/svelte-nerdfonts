svelte-nerdfonts
================

Nerdfont SVG-Icons for Svelte.js

![](https://raw.githubusercontent.com/icalvin102/svelte-nerdfonts/master/demo/public/usage-general.gif)

Install
-------

Run: 

`npm install --save svelte-nerdfonts`


Usage
-----

``` svelte

<script>
  import Icon from 'svelte-nerdfonts';
  import { vim } from 'svelte-nerdfonts/icons/dev';
  import { heart } from 'svelte-nerdfonts/icons/mdi';
</script>

<Icon data={vim} />
<Icon data={heart} />

```

> (See [cheatsheet](https://icalvin102.github.io/svelte-nerdfonts/)
> to find the icons you are looking for)

### Icons

Icons can be imported directly from an Iconset or from a combined
module prefixed with the name of the iconset.

The iconnames are camelcased versions of the
[nerdfonts cssclassnames](https://www.nerdfonts.com/cheat-sheet).


``` js
// nerd-fonts classname: .nf-linux-archlinux
// all examples will import the same icon

import { default as linuxArchlinux } from 'svelte-nerdfonts/icons/linux/archlinux';
import { archlinux } from 'svelte-nerdfonts/icons/linux';
import { linuxArchlinux } from 'svelte-nerdfonts/icons';

```

> Note: The compiletime depends on the size of the imported iconset.
> Example 1 will be fastest as it only has to import on iconfile.

#### Supported Iconsets

* `svelte-nerdfonts/icons` all icons (prefixed)
* `svelte-nerdfonts/icons/custom` Custom
* `svelte-nerdfonts/icons/dev` Devicons
* `svelte-nerdfonts/icons/fa` Font Awesome
* `svelte-nerdfonts/icons/fae` Font Awesome Extension
* `svelte-nerdfonts/icons/iec` IEC Power Symbols
* `svelte-nerdfonts/icons/indentation`
* `svelte-nerdfonts/icons/linux` Font Linux
* `svelte-nerdfonts/icons/mdi` Material Design
* `svelte-nerdfonts/icons/oct` Octicons
* `svelte-nerdfonts/icons/pl` Powerline Symbols
* `svelte-nerdfonts/icons/ple` PowerLine Extra Symbols
* `svelte-nerdfonts/icons/pom` Pomicons
* `svelte-nerdfonts/icons/seti` Seti UI
* `svelte-nerdfonts/icons/weather` Weather Icons


### fzf.vim completion


If you are using vim/neovim with the
[fzf.vim](https://github.com/junegunn/fzf.vim) plugin 
you can add the following lines to your `.vimrc` to get
a list of all availible icon imports. 

``` vim
" svelte-nerdfonts fzf completion
function! s:join_lines(lines)
    return join(a:lines, "\n") 
endfunction

let snf_sed = 'sed -e ''s/export/import/'' -e ''s/.\//svelte-nerdfonts\/icons\//''' 
let snf_path = '"$(git rev-parse --show-toplevel)/node_modules/svelte-nerdfonts/icons/index.js"'
inoremap <expr> <c-x>i fzf#vim#complete({
    \ 'source': snf_sed . ' ' . snf_path,
    \ 'reducer': function('<sid>join_lines'),
    \ 'options': '--multi'})
```

Press `<c-x>i` in `Insert Mode` to open a fzf window with the possible
icon imports. Select multiple icons with `Tab` or `Shift+Tab` and 
confim with `Enter` to insert the selected imports into you buffer.

> Note: Your svelte project has to be a initialized git repository
> for this to work. 

> Note: Install a nerd-font for icon-previews in the fzf output 

> If you have any suggestions on making this more robust. 
> Please share them :)


Build
-----


``` bash
$ git clone https://github.com/icalvin102/svelte-nerdfonts.git
$ cd svelte-nerdfonts
```

svelte-nerdfonts uses [icalvin102/nerdconvert](https://github.com/icalvin102/nerdconvert)
to generate the icons. This needs `python` and `fontforge` to be installed
on your machine. 

If the dependencies are installed you can simply run:

```
npm run generate
```
or
```
python nerdconvert.py -o es icons/ --fields iconname paths viewbox
```

> (see [nerdconvert#usage](https://github.com/icalvin102/nerdconvert#usage)
> for more details)
