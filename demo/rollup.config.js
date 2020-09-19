import svelte from 'rollup-plugin-svelte';
import resolve from '@rollup/plugin-node-resolve';
import commonjs from '@rollup/plugin-commonjs';
import { terser } from 'rollup-plugin-terser';


export default {
	input: 'demo/main.js',
	output: {
		sourcemap: true,
		format: 'iife',
		name: 'app',
		file: 'demo/public/bundle.js'
	},
	plugins: [
		svelte({
			// enable run-time checks when not in production
			// dev: !production,
			// we'll extract any component CSS out into
			// a separate file - better for performance
			css: css => {
				css.write('bundle.css');
			}
		}),

		resolve({
			browser: true,
			dedupe: ['svelte']
		}),
		commonjs(),


		// If we're building for production (npm run build
		// instead of npm run dev), minify
		terser()
	],
	watch: {
		clearScreen: false
	}
};
