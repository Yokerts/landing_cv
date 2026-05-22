#!/usr/bin/env bash
set -eu

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DIST="$ROOT/dist"

echo "→ Limpiando dist/"
rm -rf "$DIST"
mkdir -p "$DIST"/{css,js/core,scripts,styles,images,docs,portfolio/web,portfolio/movil}

echo "→ Copiando HTML y assets públicos"
cp "$ROOT/index.html" "$ROOT/favicon.ico" "$ROOT/robots.txt" "$ROOT/sitemap.xml" "$DIST/"
cp "$ROOT/.htaccess" "$DIST/" 2>/dev/null || true

cp -R "$ROOT/css/"* "$DIST/css/"
cp "$ROOT/js/aos.js" "$ROOT/js/now-ui-kit.js" "$DIST/js/"
cp "$ROOT/js/core/"* "$DIST/js/core/"
cp "$ROOT/scripts/main.js" "$DIST/scripts/"
cp "$ROOT/styles/main.css" "$DIST/styles/"
cp "$ROOT/docs/Carlos-Medina-CV.pdf" "$DIST/docs/"

echo "→ Imágenes del sitio (solo las usadas en index.html)"
cp "$ROOT/images/cc-bg-1.jpg" "$DIST/images/"
cp "$ROOT/images/carlosmedina.jpg" "$DIST/images/"
cp "$ROOT/images/contact-dev-bg.jpg" "$DIST/images/"

echo "→ Portafolio"
shopt -s nullglob
for f in "$ROOT/portfolio/web"/*; do
  case "$f" in *.jpg|*.jpeg|*.png|*.JPG|*.JPEG|*.PNG) cp "$f" "$DIST/portfolio/web/" ;; esac
done
for f in "$ROOT/portfolio/movil"/*; do
  case "$f" in *.jpg|*.jpeg|*.png|*.JPG|*.JPEG|*.PNG) cp "$f" "$DIST/portfolio/movil/" ;; esac
done

echo "→ Optimizando imágenes PNG del portafolio (máx. 1400px)"
if command -v sips >/dev/null 2>&1; then
  for img in "$DIST/portfolio"/*/*.png "$DIST/portfolio"/*/*.PNG; do
    [ -f "$img" ] || continue
    sips -Z 1400 "$img" >/dev/null 2>&1 || true
  done
fi

echo "→ Eliminando archivos del sistema"
find "$DIST" -name '.DS_Store' -delete 2>/dev/null || true

SIZE=$(du -sh "$DIST" | cut -f1)
echo ""
echo "✓ Build listo: $DIST ($SIZE)"
echo "  Sube el contenido de dist/ a la raíz de tu hosting."
echo "  Vista previa local: npm run preview"
