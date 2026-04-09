#!/usr/bin/env bash
# SPDX-License-Identifier: MIT-0
#
# Build script for ansible-openstack-collection.
# Usage: ./scripts/build.sh [--version VERSION | --publish]
#
#   --version  VERSION   Set the version in galaxy.yml and build the tarball.
#                        If omitted, reads current version from galaxy.yml and
#                        prompts for the new version.
#   --publish          Upload the built tarball to Ansible Galaxy.
#   --help             Show this help message.
#
# Output: alwynpan-openstack-{version}.tar.gz in the repository root.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
COLLECTION_DIR="${REPO_ROOT}/alwynpan/openstack"
GALAXY_YML="${COLLECTION_DIR}/galaxy.yml"
OUTPUT_DIR="${REPO_ROOT}"
NAMESPACE="alwynpan"
COLLECTION="openstack"

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

usage() {
  grep "^#" "${BASH_SOURCE[0]}" | sed 's/^# //'
  exit 0
}

current_version() {
  grep "^version:" "${GALAXY_YML}" | awk '{print $2}'
}

set_version() {
  local ver="$1"
  if [[ ! "$ver" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "ERROR: Version must be semantic versioning (e.g. 0.1.1): $ver" >&2
    exit 1
  fi
  sed -i '' "s/^version:.*/version: ${ver}/" "${GALAXY_YML}"
  echo "Version set to ${ver} in galaxy.yml"
}

prompt_version() {
  local cur="$1"
  echo "Current version: ${cur}"
  read -r -p "Enter new version (semver): " new_ver
  if [[ -z "$new_ver" ]]; then
    echo "No version entered. Aborting." >&2
    exit 1
  fi
  echo "$new_ver"
}

build_tarball() {
  local ver="$1"
  local tarball="${OUTPUT_DIR}/${NAMESPACE}-${COLLECTION}-${ver}.tar.gz"

  # Remove old tarball if it exists
  rm -f "${tarball}"

  cd "${COLLECTION_DIR}"
  ansible-galaxy collection build --output-path "${OUTPUT_DIR}" --force

  # Rename to expected name (ansible-galaxy uses namespace-collection-ver.tar.gz)
  local built
  built=$(ls "${OUTPUT_DIR}"/${NAMESPACE}-${COLLECTION}-${ver}.tar.gz 2>/dev/null || true)
  if [[ -z "$built" ]]; then
    echo "ERROR: Build failed — tarball not found." >&2
    exit 1
  fi

  echo ""
  echo "Build complete: ${tarball}"
  echo "$tarball"
}

publish() {
  local tarball="$1"
  echo "Publishing ${tarball} to Ansible Galaxy..."
  ansible-galaxy collection publish "${tarball}"
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

VERSION=""
PUBLISH=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    --version)
      VERSION="${2:-}"
      shift 2 ;;
    --publish)
      PUBLISH=true
      shift ;;
    --help|-h)
      usage ;;
    *)
      echo "Unknown option: $1" >&2
      usage ;;
  esac
done

if [[ -z "$VERSION" ]]; then
  VERSION=$(prompt_version "$(current_version)")
fi

set_version "$VERSION"
TARBALL=$(build_tarball "$VERSION")

if $PUBLISH; then
  publish "$TARBALL"
fi
