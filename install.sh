#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ -f "${SCRIPT_DIR}/marketplace.json" && -d "${SCRIPT_DIR}/zest" ]]; then
  BUNDLE_ROOT="${SCRIPT_DIR}"
else
  BUNDLE_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
fi

SOURCE_PLUGIN_DIR="${BUNDLE_ROOT}/zest"
SOURCE_MARKETPLACE="${BUNDLE_ROOT}/marketplace.json"
SOURCE_PLUGIN_MANIFEST="${SOURCE_PLUGIN_DIR}/.codex-plugin/plugin.json"

if ! command -v node >/dev/null 2>&1; then
  echo "error: node is required to install this plugin" >&2
  exit 1
fi

if [[ ! -d "${SOURCE_PLUGIN_DIR}" ]]; then
  echo "error: plugin folder not found at ${SOURCE_PLUGIN_DIR}" >&2
  echo "run this script from the unzipped release bundle" >&2
  exit 1
fi

if [[ ! -f "${SOURCE_MARKETPLACE}" ]]; then
  echo "error: marketplace.json not found at ${SOURCE_MARKETPLACE}" >&2
  echo "run this script from the unzipped release bundle" >&2
  exit 1
fi

if [[ ! -f "${SOURCE_PLUGIN_MANIFEST}" ]]; then
  echo "error: plugin manifest not found at ${SOURCE_PLUGIN_MANIFEST}" >&2
  echo "run this script from the unzipped release bundle" >&2
  exit 1
fi

PLUGIN_NAME="$(node -p "const fs = require('node:fs'); JSON.parse(fs.readFileSync(process.argv[1], 'utf8')).name" "${SOURCE_PLUGIN_MANIFEST}")"

prompt_scope() {
  echo "Choose install scope:"
  echo "  1) Workspace level (current repo only)"
  echo "  2) Personal level (all repos for this user)"
  printf "Enter 1 or 2: "
  read -r selection

  case "${selection}" in
    1) INSTALL_SCOPE="workspace" ;;
    2) INSTALL_SCOPE="personal" ;;
    *)
      echo "error: invalid selection" >&2
      exit 1
      ;;
  esac
}

prompt_workspace_root() {
  local default_root
  default_root="$(pwd)"

  echo
  echo "Workspace install selected."
  echo "Paste the target repository path."
  printf "Repository path [%s]: " "${default_root}"
  read -r input_path

  if [[ -z "${input_path}" ]]; then
    WORKSPACE_ROOT="${default_root}"
  else
    WORKSPACE_ROOT="${input_path/#\~/${HOME}}"
  fi

  if [[ ! -d "${WORKSPACE_ROOT}" ]]; then
    echo "error: repository path does not exist: ${WORKSPACE_ROOT}" >&2
    exit 1
  fi
}

confirm_replace_plugin_dir() {
  local target_plugin_dir="$1"

  if [[ ! -e "${target_plugin_dir}" ]]; then
    return
  fi

  echo
  echo "A plugin folder already exists at:"
  echo "  ${target_plugin_dir}"
  printf "Replace it with this bundle? [y/N]: "
  read -r overwrite

  case "${overwrite}" in
    y|Y|yes|YES)
      rm -rf "${target_plugin_dir}"
      ;;
    *)
      echo "Installation cancelled."
      exit 0
      ;;
  esac
}

write_marketplace() {
  local target_marketplace="$1"
  local target_plugin_path="$2"

  mkdir -p "$(dirname "${target_marketplace}")"

  if [[ -f "${target_marketplace}" ]]; then
    local backup_path
    backup_path="${target_marketplace}.bak.$(date +%Y%m%d%H%M%S)"
    cp "${target_marketplace}" "${backup_path}"
    echo "Backed up existing marketplace file to:"
    echo "  ${backup_path}"
  fi

  node - "${SOURCE_MARKETPLACE}" "${target_marketplace}" "${PLUGIN_NAME}" "${target_plugin_path}" <<'EOF'
const fs = require("node:fs");

const [sourceMarketplacePath, targetMarketplacePath, pluginName, pluginPath] = process.argv.slice(2);
const sourceMarketplace = JSON.parse(fs.readFileSync(sourceMarketplacePath, "utf8"));

let targetMarketplace = sourceMarketplace;
if (fs.existsSync(targetMarketplacePath)) {
  targetMarketplace = JSON.parse(fs.readFileSync(targetMarketplacePath, "utf8"));
}

const sourcePlugin = Array.isArray(sourceMarketplace.plugins)
  ? sourceMarketplace.plugins.find((entry) => entry?.name === pluginName)
  : undefined;

if (!sourcePlugin) {
  console.error(`error: plugin "${pluginName}" not found in ${sourceMarketplacePath}`);
  process.exit(1);
}

const normalizedPlugin = {
  ...sourcePlugin,
  source: {
    ...sourcePlugin.source,
    source: "local",
    path: pluginPath,
  },
};

const plugins = Array.isArray(targetMarketplace.plugins) ? [...targetMarketplace.plugins] : [];
const existingIndex = plugins.findIndex((entry) => entry?.name === pluginName);

if (existingIndex >= 0) {
  plugins[existingIndex] = {
    ...plugins[existingIndex],
    ...normalizedPlugin,
    source: normalizedPlugin.source,
  };
} else {
  plugins.push(normalizedPlugin);
}

const nextMarketplace = {
  ...targetMarketplace,
  plugins,
};

fs.writeFileSync(targetMarketplacePath, `${JSON.stringify(nextMarketplace, null, 2)}\n`);
EOF
}

rewrite_mcp_config() {
  local target_plugin_dir="$1"
  local target_mcp_config="${target_plugin_dir}/.mcp.json"

  if [[ ! -f "${target_mcp_config}" ]]; then
    echo "error: MCP config not found at ${target_mcp_config}" >&2
    exit 1
  fi

  node - "${target_mcp_config}" "${target_plugin_dir}" <<'EOF'
const fs = require("node:fs");
const path = require("node:path");

const [mcpConfigPath, pluginDir] = process.argv.slice(2);
const config = JSON.parse(fs.readFileSync(mcpConfigPath, "utf8"));

if (!config.mcpServers || typeof config.mcpServers !== "object") {
  console.error(`error: invalid MCP config in ${mcpConfigPath}`);
  process.exit(1);
}

for (const serverConfig of Object.values(config.mcpServers)) {
  if (!serverConfig || typeof serverConfig !== "object") {
    continue;
  }

  if (serverConfig.command === "node" && Array.isArray(serverConfig.args)) {
    serverConfig.args = serverConfig.args.map((value) => {
      if (typeof value !== "string") {
        return value;
      }

      return value.startsWith("./") ? path.join(pluginDir, value.slice(2)) : value;
    });
  }
}

fs.writeFileSync(mcpConfigPath, `${JSON.stringify(config, null, 2)}\n`);
EOF
}

clear_plugin_cache() {
  local cache_root="${HOME}/.codex/plugins/cache"
  local legacy_cache_dir="${cache_root}/zest-alpha/${PLUGIN_NAME}"

  if [[ -d "${legacy_cache_dir}" ]]; then
    echo "Removing stale plugin cache at:"
    echo "  ${legacy_cache_dir}"
    rm -rf "${legacy_cache_dir}"
  fi
}

install_workspace() {
  prompt_workspace_root
  TARGET_PLUGIN_DIR="${WORKSPACE_ROOT}/plugins/${PLUGIN_NAME}"
  TARGET_MARKETPLACE="${WORKSPACE_ROOT}/.agents/plugins/marketplace.json"
  TARGET_PLUGIN_PATH="./plugins/${PLUGIN_NAME}"
}

install_personal() {
  TARGET_PLUGIN_DIR="${HOME}/.codex/plugins/${PLUGIN_NAME}"
  TARGET_MARKETPLACE="${HOME}/.agents/plugins/marketplace.json"
  TARGET_PLUGIN_PATH="./.codex/plugins/${PLUGIN_NAME}"
}

prompt_scope

case "${INSTALL_SCOPE}" in
  workspace)
    install_workspace
    ;;
  personal)
    install_personal
    ;;
esac

echo
echo "Installing Zest plugin..."
echo "  Scope:       ${INSTALL_SCOPE}"
echo "  Plugin dir:  ${TARGET_PLUGIN_DIR}"
echo "  Marketplace: ${TARGET_MARKETPLACE}"

confirm_replace_plugin_dir "${TARGET_PLUGIN_DIR}"
clear_plugin_cache

mkdir -p "$(dirname "${TARGET_PLUGIN_DIR}")"
cp -R "${SOURCE_PLUGIN_DIR}" "${TARGET_PLUGIN_DIR}"
rewrite_mcp_config "${TARGET_PLUGIN_DIR}"
write_marketplace "${TARGET_MARKETPLACE}" "${TARGET_PLUGIN_PATH}"

echo
echo "Install complete."
echo "Next steps:"
echo "  1. Restart Codex."
echo "  2. Open the plugin directory and verify Zest appears."
echo "  3. Ask Codex: Log me into Zest"
