#!/bin/bash
set -euo pipefail

# install-opencode-bwrap-sandbox.sh
# Sandboxes opencode to the current directory using bubblewrap,
# keeping its real config/cache/auth dirs intact.
# Usage: sudo ./install-opencode-bwrap-sandbox.sh

REAL_BIN="/usr/local/bin/opencode-real"
WRAPPER_BIN="/usr/local/bin/opencode"

# 1. Check prerequisites
if ! command -v bwrap >/dev/null 2>&1; then
    echo "bubblewrap is not installed. Installing..."
    apt update && apt install -y bubblewrap
fi

if ! command -v opencode >/dev/null 2>&1 && [ ! -f "$REAL_BIN" ]; then
    echo "Error: opencode not found (neither 'opencode' nor '$REAL_BIN')." >&2
    echo "Install it first (e.g. npm install -g @opencode/cli)." >&2
    exit 1
fi

# 2. Move the real binary once (idempotent)
if [ ! -f "$REAL_BIN" ]; then
    CURRENT_BIN="$(command -v opencode)"
    echo "Moving $CURRENT_BIN to $REAL_BIN ..."
    mv "$CURRENT_BIN" "$REAL_BIN"
else
    echo "$REAL_BIN already exists, leaving it as is."
fi

# 3. Detect if the binary (or its symlink target) lives outside /usr or /etc.
#    bwrap starts from an empty namespace, so any such extra path must be
#    bound explicitly or the sandboxed exec will fail with ENOENT.
REAL_TARGET="$(readlink -f "$REAL_BIN")"
REAL_TARGET_DIR="$(dirname "$REAL_TARGET")"
EXTRA_BIND_LINE=""
case "$REAL_TARGET_DIR" in
  /usr*|/etc*) ;;  # already covered, nothing to add
  *)
    echo "Detected external target dir, will bind it too: $REAL_TARGET_DIR"
    EXTRA_BIND_LINE="  --ro-bind \"$REAL_TARGET_DIR\" \"$REAL_TARGET_DIR\""
    ;;
esac

# 4. Write the wrapper (placeholder gets substituted below, no risk of
#    breaking the BWRAP_ARGS array syntax)
cat > "$WRAPPER_BIN" << 'EOF'
#!/bin/bash
# Bubblewrap wrapper: only opencode's own dirs + cwd are read-write,
# system dirs are read-only, everything else is invisible.
set -euo pipefail

CONFIG_DIR="$HOME/.config/opencode"
DATA_DIR="$HOME/.local/share/opencode"
STATE_DIR="$HOME/.local/state/opencode"
CACHE_DIR="$HOME/.cache/opencode"

mkdir -p "$CONFIG_DIR" "$DATA_DIR" "$STATE_DIR" "$CACHE_DIR"

BWRAP_ARGS=(
  --unshare-all
  --share-net
  --die-with-parent
  --new-session

  --proc /proc
  --dev /dev
  --tmpfs /tmp

  --ro-bind /usr /usr
  --ro-bind /etc /etc

  # DNS on Ubuntu goes through systemd-resolved: /etc/resolv.conf is a
  # symlink into /run, so /run must be reachable too or DNS resolution
  # (and thus any HTTPS API call) silently fails. --ro-bind-try skips it
  # quietly if the path doesn't exist on other setups.
  --ro-bind-try /run/systemd/resolve /run/systemd/resolve
  --ro-bind-try /run/resolvconf /run/resolvconf
)

for dir in /bin /lib /lib64 /sbin; do
  if [ -e "$dir" ]; then
    if [ -L "$dir" ]; then
      BWRAP_ARGS+=(--symlink "$(readlink "$dir")" "$dir")
    else
      BWRAP_ARGS+=(--ro-bind "$dir" "$dir")
    fi
  fi
done

BWRAP_ARGS+=(
__EXTRA_BIND__
  --bind "$CONFIG_DIR" "$CONFIG_DIR"
  --bind "$DATA_DIR" "$DATA_DIR"
  --bind "$STATE_DIR" "$STATE_DIR"
  --bind "$CACHE_DIR" "$CACHE_DIR"
  --bind "$PWD" "$PWD"
  --chdir "$PWD"
)

exec bwrap "${BWRAP_ARGS[@]}" /usr/local/bin/opencode-real "$@"
EOF

# Substitute the placeholder with the extra bind line (or remove it if empty)
if [ -n "$EXTRA_BIND_LINE" ]; then
    sed -i "s#__EXTRA_BIND__#${EXTRA_BIND_LINE}#" "$WRAPPER_BIN"
else
    sed -i "/__EXTRA_BIND__/d" "$WRAPPER_BIN"
fi

chmod +x "$WRAPPER_BIN"

echo ""
echo "Installation complete."
echo "  - Real binary : $REAL_BIN"
echo "  - Wrapper     : $WRAPPER_BIN"
echo ""
echo "Quick test (from a project directory):"
echo "  cd ~/my-project && opencode"