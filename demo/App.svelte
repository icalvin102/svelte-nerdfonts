<input type="text" bind:value="{query}"/>
<button on:click="{()=>showLabels = !showLabels}">
    { showLabels ? 'Hide' : 'Show' } Labels
</button>
<main>
    
    <section class="icons" class:showlabels="{showLabels}">
        {#each Object.entries(groupIcons(displayIcons)) as [group, icons]}
            <div>{group}</div>
            {#each icons as icon} 
                <button class="iconbutton" on:click="{ () => toggle(icon) }">
                <Icon data="{icon}" />
                <div class="name">{ icon.name }</div>
                <div class="group">{ icon.group }</div>
            </button>
            {/each}
        {/each}
    </section>

    <section class="code">
        <ImportCode icons="{selectedIcons}" group />
        <ImportCode icons="{selectedIcons}" />
    </section>
</main>

<script>
    import Icon from '../components';
    import * as icons from '../icons';
    import ImportCode from './ImportCode.svelte';
    
    let iconList = Object.entries(icons)
        .map(([k, v]) => {
            v.group = k.split(/[A-Z]/)[0];
            v.name = k.replace(new RegExp(v.group), '');
            v.name = v.name.replace(/^\w/, (m) => m.toLowerCase());
            v.fullname = k;
            return v;
        });

    let query = '';
    let displayIcons = [];
    let selectedIcons = [];
    let showLabels = true;


    $: {
        query;
        search();
    }

    function search(){
        displayIcons = iconList.filter(icon =>
            icon.fullname.toLowerCase().includes(query)
        )//.slice(0, 50); 
    }
    

    function toggle(icon){
        let index = selectedIcons.indexOf(icon);
        if(index >= 0){
            selectedIcons.splice(index, 1);
            selectedIcons = selectedIcons;
        } else {
            selectedIcons = [...selectedIcons, icon]
        }

    }
    
    function groupIcons(icons){
        return icons.reduce((a, v) => {
            a[v.group] = [...(a[v.group] || []), v];
            return a;
        }, {});
    }

</script>

<style>
    main {
        display: grid;
        grid-template-columns: 1fr 350px;
    }

    .iconbutton {
        width: 2em;
        margin: 5px;
        font-size: 2em;
    }

    .showlabels .iconbutton {
        width: 4em;
    }


    .name, .group {
        display: none;
    }

    .showlabels .name,
    .showlabels .group {
        display: block;
    }

    .name {
        margin-top: 10px;
        font-size: 14px;
    }

    .group {
        font-size: 10px;
        font-style: italic;
    }

    section.code {
        display: grid;
        grid-template-columns: 1fr;
        grid-gap: 1em;
    }
</style>
