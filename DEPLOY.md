# Despliegue a producción

Sitio estático (HTML, CSS, JS). No requiere PHP ni base de datos.

## 1. Generar la carpeta de producción

```bash
npm run build
```

Esto crea la carpeta **`dist/`** con solo lo necesario (~tamaño reducido, sin SCSS ni plugins JS sin usar).

## 2. Vista previa local

```bash
npm run preview
```

Abre http://localhost:4173 y revisa portafolio, descarga del PDF y navegación.

## 3. Subir al servidor

Sube **todo el contenido de `dist/`** (no la carpeta `dist` en sí) a la raíz del hosting:

- `public_html/` (cPanel)
- `www/` o `htdocs/`
- Raíz del sitio en Nginx/Apache

Archivos esperados en la raíz del dominio:

```
index.html
favicon.ico
robots.txt
sitemap.xml
.htaccess
css/
js/
scripts/
styles/
images/
portfolio/
docs/
```

## 4. Antes de publicar

1. Edita **`sitemap.xml`** y cambia `https://TU-DOMINIO.com/` por tu dominio real.
2. En **`.htaccess`**, descomenta las líneas de HTTPS cuando tengas SSL activo.
3. Si usas **Herd** en local, en producción el dominio será el de tu hosting (no hace falta Herd).

## 5. Hosting recomendado

Cualquier hosting con archivos estáticos:

| Servicio | Notas |
|----------|--------|
| cPanel / Apache | `.htaccess` incluido |
| Netlify / Vercel | Publicar carpeta `dist`, sin build command |
| GitHub Pages | Rama o carpeta `dist` |
| Cloudflare Pages | Directorio de salida: `dist` |

### Netlify / Vercel

- **Build command:** `npm run build`
- **Publish directory:** `dist`

## 6. Mantener el sitio

- Cambios en diseño (SCSS): edita `styles/main.scss` y vuelve a compilar a `main.css` si usas Sass; o edita `styles/main.css` directamente.
- Nuevas fotos de portafolio: colócalas en `portfolio/web` o `portfolio/movil` y actualiza `index.html`.
- Vuelve a ejecutar `npm run build` antes de cada despliegue.

## 7. No subir a producción

- Carpeta `styles/` (fuentes SCSS), salvo `main.css` que ya va en `dist/styles/`
- `js/plugins/` (no se usan)
- Imágenes antiguas del template en `images/` (project-*.jpg, etc.)
- `node_modules/`, `.git`, archivos `.DS_Store`
