# -------------------------------------------------------------------
# Graphify Docker Integration for Antigravity & agy CLI
# -------------------------------------------------------------------

export GRAPHIFY_DOCKER_DIR="$HOME/.config/graphify"

# 0. Inisialisasi / Build Ulang Docker Image (Untuk Fresh Install / Dotfiles)
graphify-init() {
  echo "📦 [Graphify] Menyiapkan Dockerfile dan Image..."
  mkdir -p "$GRAPHIFY_DOCKER_DIR"
  cat << 'EOF' > "$GRAPHIFY_DOCKER_DIR/Dockerfile"
FROM python:3.12-slim

WORKDIR /app

# Install git untuk clone repo & pip dependencies
RUN apt-get update && apt-get install -y --no-install-recommends git \
    && rm -rf /var/lib/apt/lists/*

# Install graphify langsung dari repo resminya beserta watchdog
RUN pip install --no-cache-dir "graphifyy[mcp]" watchdog

ENTRYPOINT ["graphify"]
CMD ["--help"]
EOF

  docker build -t graphify "$GRAPHIFY_DOCKER_DIR" || {
    echo "❌ [Graphify] Build Docker image gagal!"
    return 1
  }
  echo "✅ [Graphify] Image 'graphify' siap digunakan!"
}

# Helper internal: Pastikan OrbStack & Image sudah siap sebelum dieksekusi
_ensure_graphify_ready() {
  if ! docker info >/dev/null 2>&1; then
    echo "❌ [Graphify] Docker/OrbStack belum berjalan. Buka aplikasi OrbStack terlebih dahulu."
    return 1
  fi

  if ! docker image inspect graphify >/dev/null 2>&1; then
    echo "⚠️  [Graphify] Image 'graphify' belum ada. Menjalankan auto-build..."
    graphify-init || return 1
  fi
}


# 1. Base CLI wrapper
alias graphify='docker run --rm --entrypoint graphify -v "$HOME/.gemini":/home/graphify/.gemini -v "$(pwd)":/app -w /app graphify'

# 2. Build / Update Graph + Inject Context Rule for Antigravity
graphify-build() {
  _ensure_graphify_ready || return 1

  echo "🚀 [Graphify] Extracting codebase AST..."
  docker run --rm --entrypoint graphify -v "$HOME/.gemini":/home/graphify/.gemini -v "$(pwd)":/app -w /app graphify . --code-only || return 1

  echo "📊 [Graphify] Generating GRAPH_REPORT.md & clusters..."
  docker run --rm --entrypoint graphify -v "$HOME/.gemini":/home/graphify/.gemini -v "$(pwd)":/app -w /app graphify cluster-only /app || return 1

  # Pastikan file AGENTS.md ada & berisi instruksi pembacaan graph untuk Antigravity
  if [ ! -f "AGENTS.md" ]; then
    echo "📝 [Graphify] Creating AGENTS.md for Antigravity..."
    cat << 'RULES' > AGENTS.md
# Project Context & Architecture Rules
- Selalu baca file `GRAPH_REPORT.md` dan rujukan data di `graphify-out/` sebagai referensi utama saat menganalisis arsitektur kode, routing, relasi model, controller, dan dependensi proyek.
- Graphify berjalan di dalam container MCP Server. Jangan pernah mencoba menjalankan perintah terminal `which graphify`, `npx graphify`, atau `python3 -m graphify` di host environment. Selalu gunakan MCP tool `graphify/*` atau baca `GRAPH_REPORT.md` secara langsung.
RULES
  elif ! grep -q "GRAPH_REPORT.md" AGENTS.md; then
    echo "📝 [Graphify] Appending graph rules to AGENTS.md..."
    cat << 'RULES' >> AGENTS.md

- Selalu baca file `GRAPH_REPORT.md` dan rujukan data di `graphify-out/` saat menganalisis arsitektur dan relasi codebase.
- Graphify berjalan di dalam container MCP Server. Jangan pernah mencoba menjalankan perintah terminal `which graphify`, `npx graphify`, atau `python3 -m graphify` di host environment. Selalu gunakan MCP tool `graphify/*` atau baca `GRAPH_REPORT.md` secara langsung.
RULES
  fi

  echo "✅ [Graphify] Selesai! Graph siap digunakan oleh Antigravity & agy."
}

# 3. Live Watch Mode (Auto-update graph saat save file / Cmd+S)
graphify-watch() {
  _ensure_graphify_ready || return 1
  echo "👀 [Graphify] Watching for file changes in background (Ctrl+C to stop)..."
  docker run --rm --entrypoint graphify -v "$HOME/.gemini":/home/graphify/.gemini -v "$(pwd)":/app -w /app graphify watch /app
}

# 4. Git Post-Commit Hook (Auto-update graph setiap git commit)
graphify-hook() {
  if [ -d ".git" ]; then
    echo "🔗 [Graphify] Installing git post-commit hook..."
    cat << 'HOOK' > .git/hooks/post-commit
#!/bin/bash
# Auto update graphify on commit
docker run --rm --entrypoint graphify -v "$HOME/.gemini":/home/graphify/.gemini -v "$(pwd)":/app -w /app graphify . --code-only >/dev/null 2>&1
docker run --rm --entrypoint graphify -v "$HOME/.gemini":/home/graphify/.gemini -v "$(pwd)":/app -w /app graphify cluster-only /app >/dev/null 2>&1
HOOK
    chmod +x .git/hooks/post-commit
    echo "✅ [Graphify] Git hook terpasang! Graph akan otomatis diperbarui setiap commit."
  else
    echo "❌ Direktori ini bukan repositori git."
  fi
}