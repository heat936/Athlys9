#!/usr/bin/env bash
set -euo pipefail
APK="target/android/app/build/outputs/apk/debug/app-debug.apk"
test -s "$APK"
timeout 50s adb wait-for-device
timeout 90s adb install -r "$APK"
AAPT=$(find "$ANDROID_HOME/build-tools" -name aapt -type f | sort -V | tail -1)
test -x "$AAPT"
PKG=$("$AAPT" dump badging "$APK" | sed -n "s/package: name='\([^']*\)'.*/\1/p")
test -n "$PKG"
printf 'Installed package: %s\n' "$PKG"
timeout 20s adb shell pm path "$PKG" | grep -q 'package:'
timeout 25s adb shell monkey -p "$PKG" -c android.intent.category.LAUNCHER 1
sleep 9
timeout 25s adb shell dumpsys activity activities > activity.txt
timeout 25s adb shell uiautomator dump /sdcard/athlys-ui.xml || true
timeout 15s adb pull /sdcard/athlys-ui.xml ./athlys-ui.xml || true
timeout 25s adb exec-out screencap -p > athlys-screen.png
timeout 25s adb logcat -d -t 4000 > athlys-logcat.txt
grep -F "$PKG" activity.txt
test -s athlys-screen.png
if grep -A20 "FATAL EXCEPTION" athlys-logcat.txt | grep -F "$PKG"; then
  echo "::error::Athlys native crash detected"
  exit 1
fi
if grep -E 'Capacitor/Console.*(Uncaught|SyntaxError)|Capacitor: JavaScript Error:' athlys-logcat.txt; then
  echo "::error::WebView JavaScript load error detected; native launch alone is not sufficient"
  exit 1
fi
echo "PASS: APK installed, foreground app launched, screenshot present, no native/JS fatal error"
