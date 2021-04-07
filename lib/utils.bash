#!/usr/bin/env bash
if test "$BASH" = "" || "$BASH" -uc "a=();true \"\${a[@]}\"" 2>/dev/null; then
  # Bash 4.4, Zsh
  set -euo pipefail
else
  # Bash 4.3 and older chokes on empty arrays with set -u.
  set -eo pipefail
fi
shopt -s nullglob globstar

require() { hash "$@" || exit 127; }
require curl
require git
require sed
require awk

TOOL_NAME=terraformer
GH_REPO=https://github.com/GoogleCloudPlatform/terraformer

fail() {
  printf >&2 'asdf-%s: %s' "$TOOL_NAME" "$@"
  exit 1
}

curl_opts=(-fsSL)

if [ -n "${GITHUB_API_TOKEN:-}" ]; then
  curl_opts+=(-H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
  sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' | LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_all_versions() {
  git ls-remote --tags --refs "$GH_REPO" | grep -o 'refs/tags/.*' | cut -d/ -f3- | sed 's/^v//'
}

download_release() {
  local version="$1"
  local download_path="$2"

  # i.e. terraformer-all-darwin-amd64
  # i.e. terraformer-all-linux-amd64
  url="$GH_REPO/releases/download/$version/terraformer-all-$(uname -s | tr '[:upper:]' '[:lower:]')-amd64"

  echo "* Downloading $TOOL_NAME release $version..."
  curl "${curl_opts[@]}" -o "$download_path" -C - "$url" || fail "Could not download $url"
}

install_version() {
  local install_type="$1"
  local version="$2"
  local install_path="$3"

  if [[ $install_type != version ]]; then
    fail "asdf-$TOOL_NAME supports release installs only"
  fi

  local release_file="$install_path/$TOOL_NAME"
  (
    mkdir -p "$install_path"
    download_release "$version" "$release_file"
    chmod a+x "$release_file"
    echo "$TOOL_NAME $version installation was successful!"
  ) || (
    rm -rf "$install_path"
    fail "An error ocurred while installing $TOOL_NAME $version."
  )
}
