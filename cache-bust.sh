#!/usr/bin/env bash
#
# cache-bust.sh — stamp ?v=<content-hash> onto local CSS links in every HTML file.
#
# Each stylesheet's version is the first 8 chars of its md5, so a link's query
# string only changes when that stylesheet's contents change. Idempotent: running
# it with no CSS changes leaves the HTML untouched. Run before committing
# (the pre-commit hook does this automatically).
#
set -euo pipefail
cd "$(dirname "$0")"

md5_of() {
  if command -v md5 >/dev/null 2>&1; then md5 -q "$1"; else md5sum "$1" | cut -d' ' -f1; fi
}

# Precompute "path hash" for every stylesheet once.
map="$(mktemp)"
trap 'rm -f "$map"' EXIT
while IFS= read -r f; do
  printf '%s %s\n' "$f" "$(md5_of "$f" | cut -c1-8)"
done < <(find styles -name '*.css') > "$map"

# Rewrite/refresh the ?v= token on every local CSS link, looking up each file's hash.
MAP="$map" perl -i -pe '
  BEGIN {
    %H = ();
    open(my $fh, "<", $ENV{MAP}) or die "no hash map";
    while (<$fh>) { my ($p, $h) = split; $H{$p} = $h; }
  }
  s{href="(styles/[^"?]+\.css)(?:\?v=[^"]*)?"}{ defined $H{$1} ? qq{href="$1?v=$H{$1}"} : qq{href="$1"} }ge;
' *.html

echo "Cache-busted CSS links using content hashes."
