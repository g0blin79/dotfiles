#!/usr/bin/env bash
set -euo pipefail

set_gtk_key() {
  local file="$1"
  local key="$2"
  local value="$3"

  mkdir -p "$(dirname "$file")"

  if [ ! -f "$file" ]; then
    printf '[Settings]\n' > "$file"
  fi

  if ! grep -q '^\[Settings\]' "$file"; then
    local tmp
    tmp="$(mktemp)"
    {
      printf '[Settings]\n'
      cat "$file"
    } > "$tmp"
    mv "$tmp" "$file"
  fi

  if grep -q "^${key}=" "$file"; then
    sed -i "s|^${key}=.*|${key}=${value}|" "$file"
  else
    printf '%s=%s\n' "$key" "$value" >> "$file"
  fi
}

apply_gtk_defaults() {
  local file="$1"

  set_gtk_key "$file" "gtk-application-prefer-dark-theme" "true"
  set_gtk_key "$file" "gtk-button-images" "true"
  set_gtk_key "$file" "gtk-cursor-blink" "true"
  set_gtk_key "$file" "gtk-cursor-blink-time" "1000"
  set_gtk_key "$file" "gtk-enable-animations" "true"
  set_gtk_key "$file" "gtk-font-name" "Outfit 10"
  set_gtk_key "$file" "gtk-menu-images" "true"
  set_gtk_key "$file" "gtk-modules" "colorreload-gtk-module:appmenu-gtk-module"
  set_gtk_key "$file" "gtk-primary-button-warps-slider" "true"
  set_gtk_key "$file" "gtk-shell-shows-menubar" "1"
  set_gtk_key "$file" "gtk-toolbar-icon-size" "GTK_ICON_SIZE_LARGE_TOOLBAR"
}

apply_gtk_defaults "$HOME/.config/gtk-3.0/settings.ini"
apply_gtk_defaults "$HOME/.config/gtk-4.0/settings.ini"

echo "GTK defaults applied to:"
echo "- $HOME/.config/gtk-3.0/settings.ini"
echo "- $HOME/.config/gtk-4.0/settings.ini"
