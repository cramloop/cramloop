#!/usr/bin/env bash
# Copy cramloop skills to ~/.claude (physical copy).
# Overwrites any existing files in the target location.

set -e

CRAMLOOP_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE="${CRAMLOOP_ROOT}/skills"
TARGET_BASE="${HOME}/.claude/skills"

if [[ ! -d "$SOURCE" ]]; then
  echo "Error: skills folder not found at $SOURCE" >&2
  exit 1
fi

mkdir -p "$TARGET_BASE"

# Shared reference copied into each skill's references folder
REFERENCE_FILE="${CRAMLOOP_ROOT}/skills/references/docling.md"

# Copy each individual skill folder
for skill_dir in "$SOURCE"/*/; do
  if [[ ! -d "$skill_dir" ]]; then
    continue
  fi

  skill_name="$(basename "$skill_dir")"

  # Skip references directory (not a skill folder)
  if [[ "$skill_name" == "references" ]]; then
    echo "Skipping $skill_name (not a skill folder)"
    continue
  fi

  skill_source="$skill_dir"
  skill_target="${TARGET_BASE}/${skill_name}"

  echo "Copying $skill_name..."

  # Remove existing target if it exists (to ensure clean copy)
  if [[ -e "$skill_target" ]]; then
    if [[ -d "$skill_target" ]]; then
      rm -rf "$skill_target"
    else
      rm -f "$skill_target"
    fi
  fi

  # Copy the entire skill folder
  cp -r "$skill_source" "$skill_target"
  echo "  Copied $skill_source -> $skill_target"

  # Copy references/docling.md into the skill's references folder
  if [[ -f "$REFERENCE_FILE" ]]; then
    skill_ref_dir="${skill_target}/references"
    mkdir -p "$skill_ref_dir"
    skill_ref_file="${skill_ref_dir}/docling.md"
    if [[ -e "$skill_ref_file" ]]; then
      rm -f "$skill_ref_file"
    fi
    cp "$REFERENCE_FILE" "$skill_ref_file"
    echo "  Copied reference file: $skill_ref_file"
  fi
done

if [[ ! -f "$REFERENCE_FILE" ]]; then
  echo "Warning: Reference file not found at $REFERENCE_FILE" >&2
fi

echo "Copy complete."
