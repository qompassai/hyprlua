#!/usr/bin/env bash
# qompassai/hyprlua/scripts/version.sh
# Qompass AI Hyprlua — Version Script
# Copyright (C) 2026 Qompass AI, All rights reserved
# --------------------------------------------------
set -euo pipefail
IFS=$'\n\t'
if [[ -t 1 ]]; then
    RED='\033[0;31m'
    YELLOW='\033[0;33m'
    GREEN='\033[0;32m'
    CYAN='\033[0;36m'
    BOLD='\033[1m'
    RESET='\033[0m'
else
    RED=''
    YELLOW=''
    GREEN=''
    CYAN=''
    BOLD=''
    RESET=''
fi
info()
{
    echo -e "${CYAN}${BOLD}[info]${RESET}  $*"
}
ok()
{
    echo -e "${GREEN}${BOLD}[ ok ]${RESET}  $*"
}
warn()
{
    echo -e "${YELLOW}${BOLD}[warn]${RESET}  $*"
}
die()
{
    echo -e "${RED}${BOLD}[err ]${RESET}  $*" >&2
    exit 1
}
DRY_RUN=0
SKIP_PIN=0
usage()
{
    cat << EOF
${BOLD}Usage:${RESET} $0 [options] <new-version>
${BOLD}Options:${RESET}
  -d, --dry-run     Show what would change without modifying files
  -s, --skip-pin    Skip hyprpm.toml commit pin resolution
  -h, --help        Show this help
${BOLD}Example:${RESET}
  $0 0.2.0
  $0 --dry-run 0.2.0
EOF
    exit 0
}
while [[ $# -gt 0 ]]; do
    case "$1" in
        -d | --dry-run)
            DRY_RUN=1
            shift
            ;;
        -s | --skip-pin)
            SKIP_PIN=1
            shift
            ;;
        -h | --help) usage ;;
        -*) die "Unknown flag: $1" ;;
        *) break ;;
    esac
done
[[ $# -eq 1 ]] || usage
NEW_VERSION="$1"
[[ $NEW_VERSION =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]] \
    || die "Version must be X.Y.Z format (got '$NEW_VERSION')"
require()
{
    command -v "$1" &> /dev/null || die "Required tool not found: $1"
}
require git
require sed
require grep
require pkg-config
if ! git diff --quiet --exit-code; then
    warn "Working tree has unstaged changes — proceed anyway? [y/N]"
    read -r response
    [[ ${response,,} == "y" ]] || die "Aborted."
fi
HYPRLAND_VERSION=$(pkg-config --modversion hyprland 2> /dev/null || echo "unknown")
TODAY=$(date +%Y-%m-%d)
CURRENT_VERSION=$(grep -oP '(?<=project\(hyprlua VERSION )[0-9]+\.[0-9]+\.[0-9]+' CMakeLists.txt \
    || die "Could not find version in CMakeLists.txt")
[[ $NEW_VERSION != "$CURRENT_VERSION" ]] \
    || die "New version ($NEW_VERSION) is same as current ($CURRENT_VERSION)"
PLUGIN_COMMIT=$(git rev-parse HEAD)
PLUGIN_SHORT=$(git rev-parse --short HEAD)
HYPRLAND_COMMIT=""
if [[ $SKIP_PIN -eq 0 ]]; then
    if command -v gh &> /dev/null && [[ $HYPRLAND_VERSION != "unknown" ]]; then
        info "Resolving Hyprland commit for v${HYPRLAND_VERSION}..."
        HYPRLAND_COMMIT=$(gh api \
            "repos/hyprwm/Hyprland/commits/v${HYPRLAND_VERSION}" \
            --jq '.sha' 2> /dev/null || true)
        [[ -n $HYPRLAND_COMMIT ]] \
            && ok "Hyprland commit: ${HYPRLAND_COMMIT:0:12}..." \
            || warn "Could not resolve Hyprland commit hash via gh CLI"
    else
        warn "gh CLI unavailable or Hyprland version unknown — skipping commit pin"
    fi
fi
if [[ $DRY_RUN -eq 1 ]]; then
    echo ""
    echo -e "${BOLD}${YELLOW}── Dry run — no files will be modified ──${RESET}"
    echo ""
    echo -e "  ${CYAN}CMakeLists.txt${RESET}   version ${CURRENT_VERSION} → ${NEW_VERSION}"
    echo -e "  ${CYAN}CHANGELOG.md${RESET}     new section [${NEW_VERSION}] - ${TODAY}"
    if [[ -n $HYPRLAND_COMMIT ]]; then
        echo -e "  ${CYAN}hyprpm.toml${RESET}      commit pin: Hyprland ${HYPRLAND_COMMIT:0:12} / plugin ${PLUGIN_SHORT}"
    else
        echo -e "  ${CYAN}hyprpm.toml${RESET}      skipped (no commit hash resolved)"
    fi
    echo ""
    exit 0
fi
info "Bumping ${CURRENT_VERSION} → ${NEW_VERSION} (Hyprland ${HYPRLAND_VERSION})"
sed -i \
    "s/project(hyprlua VERSION ${CURRENT_VERSION}/project(hyprlua VERSION ${NEW_VERSION}/" \
    CMakeLists.txt
ok "CMakeLists.txt updated"
if [[ -n $HYPRLAND_COMMIT ]]; then
    sed -i \
        "/^commit_pins = \[/,/^\]/{s|^\]$|    [\"${HYPRLAND_COMMIT}\", \"${PLUGIN_COMMIT}\"],\n]|}" \
        hyprpm.toml
    ok "hyprpm.toml commit pin added"
else
    warn "hyprpm.toml — skipped (no commit hash resolved)"
fi
CHANGELOG_ENTRY="## [${NEW_VERSION}] - ${TODAY} (Hyprland ${HYPRLAND_VERSION})\n\n### Added\n-\n\n### Changed\n-\n\n### Fixed\n-\n"
sed -i "5s|^|${CHANGELOG_ENTRY}\n|" CHANGELOG.md
ok "CHANGELOG.md new section inserted"
echo ""
echo -e "${BOLD}${GREEN}── Version bump complete ──────────────────${RESET}"
echo ""
echo -e "  ${CYAN}From:${RESET}      ${CURRENT_VERSION}"
echo -e "  ${CYAN}To:${RESET}        ${NEW_VERSION}"
echo -e "  ${CYAN}Hyprland:${RESET}  ${HYPRLAND_VERSION}"
echo -e "  ${CYAN}Date:${RESET}      ${TODAY}"
echo ""
echo -e "${BOLD}Next steps:${RESET}"
echo "  1. Fill in CHANGELOG.md entries for ${NEW_VERSION}"
echo "  2. git add CMakeLists.txt hyprpm.toml CHANGELOG.md"
echo "  3. git commit -m \"chore: bump version to ${NEW_VERSION}\""
echo "  4. git tag -a v${NEW_VERSION} -m \"v${NEW_VERSION} — Hyprland ${HYPRLAND_VERSION}\""
echo "  5. git push && git push origin v${NEW_VERSION}"
echo ""
