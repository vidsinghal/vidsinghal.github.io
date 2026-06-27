#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
OUTPUT_DIR="${REPO_ROOT}/files"
CACHE_DIR="${SCRIPT_DIR}/.texlive-cache"

build_project() {
  local project_dir="$1"
  local output_name="$2"
  shift 2

  local build_dir="${project_dir}/build"

  mkdir -p "${build_dir}"
  mkdir -p "${CACHE_DIR}/texmf-var" "${CACHE_DIR}/texmf-config" "${CACHE_DIR}/xdg"

  (
    cd "${project_dir}"
    export TEXMFVAR="${CACHE_DIR}/texmf-var"
    export TEXMFCONFIG="${CACHE_DIR}/texmf-config"
    export TEXMFCACHE="${CACHE_DIR}/texmf-var"
    export XDG_CACHE_HOME="${CACHE_DIR}/xdg"
    latexmk -g "$@" -interaction=nonstopmode -halt-on-error -outdir=build main.tex
  )

  cp "${build_dir}/main.pdf" "${OUTPUT_DIR}/${output_name}"
  echo "Updated ${OUTPUT_DIR}/${output_name}"
}

build_project "${SCRIPT_DIR}/CV" "CV.pdf" -lualatex
build_project "${SCRIPT_DIR}/Resume" "Resume.pdf" -lualatex
