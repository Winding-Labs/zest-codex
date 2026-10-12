// Codex starts the plugin through this file on every OS, so it replaces the
// `sh -c` launcher that native Windows could not run. Plain ES2015 CommonJS on
// purpose: an old Node has to get far enough to print the version message.
"use strict";

var path = require("path");

var MIN_MAJOR = 22;
var MIN_MINOR = 13;
var NODE_VERSION_MESSAGE = "Zest: Node >= 22.13 required. Install from https://nodejs.org";

function isSupportedNode(version) {
  var parts = String(version).split(".");
  var major = Number(parts[0]);
  var minor = Number(parts[1]);
  return major > MIN_MAJOR || (major === MIN_MAJOR && minor >= MIN_MINOR);
}

function launch(argv, nodeVersion) {
  if (!isSupportedNode(nodeVersion)) {
    process.stderr.write(NODE_VERSION_MESSAGE + "\n");
    return 1;
  }

  var entry = argv[2];
  if (!entry) {
    process.stderr.write("Zest: launch.cjs needs an entry, e.g. mcp/server.js\n");
    return 1;
  }

  var entryPath = path.join(__dirname, entry);
  // The bundles read argv as if node had started them directly: the hook takes
  // its event from argv[2], and the daemon manager finds dist/ from argv[1].
  argv.splice(1, 2, entryPath);
  require(entryPath);
  return 0;
}

module.exports = { isSupportedNode: isSupportedNode, launch: launch };

if (require.main === module) {
  var exitCode = launch(process.argv, process.versions.node);
  if (exitCode !== 0) {
    process.exit(exitCode);
  }
}
