import { defineConfig } from 'astro/config';
import sitemap from '@astrojs/sitemap';

// https://astro.build/config
export default defineConfig({
  site: 'https://robche.com',
  base: '/robchiral.github.io',
  integrations: [sitemap()],
  build: {
    assets: '_assets'
  }
});
