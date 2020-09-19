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

![](https://raw.githubusercontent.com/icalvin102/svelte-nerdfonts/master/demo/public/svelte_nerdfont_vim_fzf.gif)

If you are using vim/neovim with 
[fzf.vim](https://github.com/junegunn/fzf.vim)
you can install the `svelte_nerdfonts.vim` plugin 
to find, import and add icons more efficently.

Install with [vim-plug](https://github.com/junegunn/vim-plug)

``` vim
Plug 'icalvin102/svelte-nerdfonts', { 'rtp': 'vim' }

```

Or install the `vim` directory manually.

The plugin will give you the `:SNFAddImport` and `:SNFAddIcon`
commands which are mapped to `<leader>si` and `<leader>sI` by default.

* `:SNFAddImport` Find icons and add ESM import statements.
* `:SNFAddIcon` Search through imported icons and add `Icon` component

Multiple selection is possible with `Tab` (select down)
and `Shift+Tab` (select up). Press `Enter` to confirm and insert
the selected icons into your buffer.

> **Note**: Install a nerd-font for icon-previews in the fzf output 


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
