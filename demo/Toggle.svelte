<script>
    import Icon from '../components';
    import { toggleOn, toggleOff } from '../icons/fa';

    export let value = false;
</script>

<p class="toggle"
        on:click="{() => value = !value}">
    <Icon data="{value ? toggleOn : toggleOff}" />
    <slot />
</p>

<style>
</style>
