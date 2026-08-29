# Flutter / Android / Java.

# Flutter
export PATH="$PATH:/Users/rebecca/Developer/flutter/flutter/bin"
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"

# Android SDK paths (hanya aktif bila ANDROID_HOME diset).
if [[ -n "$ANDROID_HOME" ]]; then
  export PATH="$PATH:$ANDROID_HOME/platform-tools"
  export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin"
  export PATH="$PATH:$ANDROID_HOME/emulator"
fi