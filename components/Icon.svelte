<script>

    export let data;
    let className;

    export { className as class };
    
</script>

<svg aria-label="{data.iconname}"
    viewBox="{data.viewbox}"
    class="icon {className}">
    {#each data.paths as path}
        <path d="{path}"/>
    {/each}
</svg>


<style>
    svg {
        transform: translateY(20%);
        display: inline-block;
        fill: currentColor;
        height: 1em;
        overflow: visible;
    }

</style>
