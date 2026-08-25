#!/usr/bin/env bash
#
# Builds an unsigned .ipa for sideloading. Requires macOS with Xcode and
# xcodegen (brew install xcodegen).
#
#   ./Scripts/build_ipa.sh          → build/DAWLearn-unsigned.ipa
#
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

SCHEME="DAWLearn"
BUILD_DIR="$ROOT/build"
DERIVED="$BUILD_DIR/DerivedData"
APP_PATH="$DERIVED/Build/Products/Release-iphoneos/$SCHEME.app"
IPA_PATH="$BUILD_DIR/$SCHEME-unsigned.ipa"

if ! command -v xcodegen >/dev/null 2>&1; then
  echo "error: xcodegen not found. Install it with: brew install xcodegen" >&2
  exit 1
fi

echo "==> Generating Xcode project"
xcodegen generate --spec project.yml

echo "==> Building (unsigned, Release, arm64)"
xcodebuild \
  -project "$SCHEME.xcodeproj" \
  -scheme "$SCHEME" \
  -configuration Release \
  -sdk iphoneos \
  -derivedDataPath "$DERIVED" \
  -destination 'generic/platform=iOS' \
  ONLY_ACTIVE_ARCH=NO \
  CODE_SIGN_IDENTITY="" \
  CODE_SIGNING_REQUIRED=NO \
  CODE_SIGNING_ALLOWED=NO \
  CODE_SIGN_ENTITLEMENTS="" \
  build

if [ ! -d "$APP_PATH" ]; then
  echo "error: build produced no .app at $APP_PATH" >&2
  exit 1
fi

echo "==> Packaging $IPA_PATH"
rm -rf "$BUILD_DIR/Payload" "$IPA_PATH"
mkdir -p "$BUILD_DIR/Payload"
cp -R "$APP_PATH" "$BUILD_DIR/Payload/"
( cd "$BUILD_DIR" && zip -qry "$(basename "$IPA_PATH")" Payload )
rm -rf "$BUILD_DIR/Payload"

echo
echo "Done: $IPA_PATH"
echo "Sideload it with AltStore, SideStore, Sideloadly or your signing tool of choice."
