<main>
    <section class="icons" class:showlabels="{showLabels}">
        <h1>svelte-nerdfonts cheatsheet</h1>
        {#each Object.entries(groupIcons(displayIcons)) as [group, icons] (group)}
            <h3>{group}</h3>
            {#each icons as icon (icon.fullname) } 
                <IconButton {icon} on:click="{ () => toggle(icon) }" />
            {/each}
        {/each}
    </section>

    <section class="sidebar">
        <input type="text" class="search"
               bind:value="{query}"
                placeholder="Search eg. toggle, javascript, vim..." />
        <Toggle bind:value="{showLabels}">
            Show Labels
        </Toggle>
        <Toggle bind:value="{groupByIconset}">
            Group imports by iconset
        </Toggle>
        <ImportCode icons="{selectedIcons}"
                    group={groupByIconset} />
    </section>
</main>

<svelte:window on:scroll="{ checkBottom }" />

<script>
    import * as icons from '../icons';
    import ImportCode from './ImportCode.svelte';
    import IconButton from './IconButton.svelte';
    import Toggle from './Toggle.svelte';    

    let iconList = Object.entries(icons)
        .map(([k, v]) => {
            v.group = k.match(/^[a-z]*/)[0];
            v.name = k.replace(new RegExp(v.group), '');
            v.name = v.name.replace(/^\w/, (m) => m.toLowerCase());
            v.fullname = k;
            v.selected = false;
            return v;
        });

    let query = '';
    let displayIcons = [];
    let filteredIcons = [];
    let selectedIcons = [];
    let iconCount = 100;
    let showLabels = false;
    let groupByIconset = true;


    $: {
        query;
        search();
    }

    $: {
        displayIcons = filteredIcons.slice(0, iconCount);
    }

    function search(){
        filteredIcons = iconList.filter(icon =>
            icon.fullname.toLowerCase().includes(query)
        );
        iconCount = 100;
    }
    

    function toggle(icon){
        console.log(icon)
        let index = selectedIcons.indexOf(icon);
        if(index >= 0){
            icon.selected = false;
            selectedIcons.splice(index, 1);
            selectedIcons = selectedIcons;
        } else {
            icon.selected = true;
            selectedIcons = [...selectedIcons, icon]
        }
        displayIcons = displayIcons;
    }
    
    function groupIcons(icons){
        return icons.reduce((a, v) => {
            a[v.group] = [...(a[v.group] || []), v];
            return a;
        }, {});
    }

    function checkBottom(){
        let d = document.body.scrollHeight
            - window.scrollY
            - window.innerHeight;

        if(d < 200) {
            iconCount = iconCount+50;
        }
    }

</script>

<style>
    section.sidebar {
        position: fixed;
        width: 350px;
        height: 100vh;
        right: 0;
        top: 0;
        padding: 1em;
        background-color: #eee;
    }

    section.icons {
        position: relative;
        width: calc(100% - (350px + 2em));
    }

    .search {
        width: 100%;
    }
</style>
