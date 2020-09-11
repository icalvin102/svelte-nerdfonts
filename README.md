# svelte-nerdfonts
Nerdfont SVG-Icons for Svelte.js

# Install

Run: 

`npm install --save svelte-nerdfonts`


# Usage

``` svelte

<script>
  import Icon from 'svelte-nerdfonts';
  import { vim } from 'svelte-nerdfonts/icons/dev';
  import { heart } from 'svelte-nerdfonts/icons/mdi';
</script>

<Icon data={vim} />
<Icon data={heart} />

```

## Icons

Icons can be imported directly from an Iconset or from a combined
module prefixed with the name of the iconset.

The iconnames are camelcased versions of the
[nerdfonts cssclassnames](https://www.nerdfonts.com/cheat-sheet).


``` js
// nerd-fonts classname: .nf-linux-archlinux
// both will import the same icon

import { archlinux } from 'svelte-nerdfonts/icons/linux';
import { linuxArchlinux } from 'svelte-nerdfonts/icons';

```

### Supported Iconsets

```
'svelte-nerdfonts/icons'
'svelte-nerdfonts/icons/custom'
'svelte-nerdfonts/icons/dev'
'svelte-nerdfonts/icons/fa'
'svelte-nerdfonts/icons/fae'
'svelte-nerdfonts/icons/iec'
'svelte-nerdfonts/icons/indentation'
'svelte-nerdfonts/icons/linux'
'svelte-nerdfonts/icons/mdi'
'svelte-nerdfonts/icons/oct'
'svelte-nerdfonts/icons/pl'
'svelte-nerdfonts/icons/ple'
'svelte-nerdfonts/icons/pom'
'svelte-nerdfonts/icons/seti'
'svelte-nerdfonts/icons/weather'
```


# Build


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
