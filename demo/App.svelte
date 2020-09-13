<input type="text" bind:value="{query}"/>
<main>
    {#each displayIcons as [key, value]}
        <button class="red" on:click="{ () => toggle(value) }">
        <Icon data="{value}" />
        <div class="name">{ value.name }</div>
        <div class="group">{ value.group }</div>
    </button>
    {/each}
    
    <pre>{ groupedImports }</pre>
    <pre>{ combinedImports }</pre>
</main>

<script>
    import Icon from '../components';
    import * as icons from '../icons';
    
    let iconList = Object.entries(icons)
        .map(([k, v]) => {
            v.group = k.split(/[A-Z]/)[0];
            v.name = k.replace(new RegExp(v.group), '');
            v.name = v.name.replace(/^\w/, (m) => m.toLowerCase());
            v.fullname = k;
            return [k, v];
        });

    let query = '';
    let displayIcons = [];
    let selectedIcons = [];
    let groupedImports = '';
    let combinedImports = '';


    $: {
        query;
        search();
    }

    function search(){
        displayIcons = iconList.filter(([key, value]) =>
            key.toLowerCase().includes(query)
        ).slice(0, 50); 
    }
    
    function createImport(icons, field='fullname', group){
        let whitespace = icons.length > 2 ? '\n' : ' ';
        let tab = icons.length > 2 ? '    ' : '';
        let seperator = ',' + whitespace;
        let names = icons.map(i => tab + i[field]);
        
        let output = `import {${whitespace}${names.join(seperator)}${whitespace}}`;
        output += ` from 'svelte-nerdfonts/icons${ group ? '/'+group : ''}';`
        return output;
    }

    function toggle(icon){
        let index = selectedIcons.indexOf(icon);
        if(index >= 0){
            selectedIcons.splice(index, 1);
            selectedIcons = selectedIcons;
        } else {
            selectedIcons = [...selectedIcons, icon]
        }

        let grouped = selectedIcons.reduce((a, v) => {
            a[v.group] = [...(a[v.group] || []), v];
            return a;
        }, {});

        groupedImports = Object.entries(grouped)
            .map(([k, v]) => createImport(v, 'name', k))
            .join('\n');
        
        combinedImports = createImport(selectedIcons);

        console.log(groupedImports);
        console.log(combinedImports);
    }

</script>

<style>
    button {
        width: 7em;
        margin: 5px;
    }

    button :global(.icon) {
        display: inline-block;
        width: 3em;
        height: 3em;
    }

    .name {
        margin-top: .5em;
        font-size: 14px;
    }

    .group {
        font-size: .7em;
        font-style: italic;
    }

</style>
