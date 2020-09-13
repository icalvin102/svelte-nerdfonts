<script>
    import Icon from '../components';
    export let icon = [];
</script>

<button class="iconbutton"
        class:selected="{icon.selected}"
        on:click>
    <Icon data="{icon}" />
    <div class="name">{ icon.name }</div>
    <div class="group">{ icon.group }</div>
</button>

<style>
    .iconbutton {
        width: 2em;
        margin-right: 5px;
        margin-bottom: 5px;
        font-size: 2em;
    }

    :global(.showlabels) .iconbutton {
        width: 4em;
    }

    .selected {
        background-color: orange;
    }

    .name, .group {
        display: none;
    }

    :global(.showlabels) .name,
    :global(.showlabels) .group {
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
</style>
