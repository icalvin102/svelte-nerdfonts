<script>
    import Icon from '../components';
    import { faToggleOn, faToggleOff } from '../icons';

    export let value = false;
</script>

<p class="toggle"
        on:click="{() => value = !value}">
    <Icon data="{value ? faToggleOn : faToggleOff}" />
    <slot />
</p>

<style>
</style>
