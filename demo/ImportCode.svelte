<script>
    import { clippy } from '../icons/oct';
    import Icon from '../components';
    export let icons = [];
    export let field = 'fullname';
    export let group = false;

    let codeBlock;
    let importCode = '';

    function createImport(icons, field='fullname', groupname){
        let whitespace = icons.length > 0 ? '\n' : ' ';
        let tab = icons.length > 0 ? '    ' : '';
        let seperator = ',' + whitespace;
        let names = icons.map(i => tab + i[field]);
        
        let output = [
            `import {`,
            `${whitespace}${names.join(seperator)}${whitespace}`,
            `}`,
            ` from `,
            `'svelte-nerdfonts/icons`,
            `${ groupname ? '/'+groupname : ''}';`
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

    function syntax(codeString){
        return codeString
            .replace(/(import|from)/g, '<span class="kw">$1</span>')
            .replace(/('.*?')/g, '<span class="s">$1</span>')
    }

    function copyToClipboard(){
        codeBlock.select();
        document.execCommand('copy');
        console.log(codeBlock.value);
    }

    $: {
        if(group){
            importCode = createGroupedImport(icons);
        } else {
            importCode = createImport(icons, field);
        }
    }

</script>

{#if icons.length > 0}
    <pre>
        {@html syntax(importCode) }
    </pre>

    <button on:click="{copyToClipboard}">
        <Icon data="{clippy}" /> Copy to Clipboard
    </button>
    <textarea readonly bind:this="{codeBlock}">{importCode}</textarea>
{/if}

<style>

    :global(.kw) {
        color: red;
    }
    
    :global(.s) {
        color: blue;
    }

    textarea {
        position: absolute;
        left: -9999px;
    }
</style>
