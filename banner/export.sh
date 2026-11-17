#!/bin/sh
# 使い方: sh export.sh  (banner/ で実行) → 1600x900 / 1600x311 の PNG と JPG
C="/c/Program Files/Google/Chrome/Application/chrome.exe"
D=$(cd "$(dirname "$0")" && pwd -W)
for s in 900 311; do
  "$C" --headless=new --disable-gpu --hide-scrollbars --force-device-scale-factor=1 --virtual-time-budget=5000 \
    --window-size=1600,$s --screenshot="$D/banner-1600x$s.png" "file:///$D/banner.html?s=$s" 2>/dev/null
  python -c "from PIL import Image;Image.open(r'$D/banner-1600x$s.png').convert('RGB').save(r'$D/banner-1600x$s.jpg',quality=92)"
done
