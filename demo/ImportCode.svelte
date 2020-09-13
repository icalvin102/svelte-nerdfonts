<script>
    
    export let icons = [];
    export let field = 'fullname';
    export let group = false;

    let codeBlock;

    function createImport(icons, field='fullname', groupname){
        let whitespace = icons.length > 0 ? '\n' : ' ';
        let tab = icons.length > 0 ? '    ' : '';
        let seperator = ',' + whitespace;
        let names = icons.map(i => tab + i[field]);
        
        let output = [
            `<span class="kw">import</span> {`,
            `${whitespace}${names.join(seperator)}${whitespace}`,
            `}`,
            ` <span class="kw">from</span> `,
            `'<span class="s">svelte-nerdfonts/icons`,
            `${ groupname ? '/'+groupname : ''}'</span>`
        ]
        return output.join('');
    }

    function createGroupedImport(icons){
        let grouped = icons.reduce((a, v) => {
            a[v.group] = [...(a[v.group] || []), v];
            return a;
        }, {});

        return Object.entries(grouped)
            .map(([k, v]) => createImport(v, 'name', k))
            .join('\n');
    }
        
</script>

<pre bind:this="{codeBlock}">
{#if group}
{@html createGroupedImport(icons)}
{:else}
{@html createImport(icons, field) }
{/if}
</pre>

<style>
    pre {
        background: #eee;
        padding: 1em;
    }

    :global(.kw) {
        color: red;
    }
    
    :global(.s) {
        color: blue;
    }
</style>
