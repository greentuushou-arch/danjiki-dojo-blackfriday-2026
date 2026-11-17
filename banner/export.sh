#!/bin/sh
# 使い方: sh export.sh  (banner/ で実行) → 15%版と10%版の 1600x900 / 1600x311（PNG・JPG）
C="/c/Program Files/Google/Chrome/Application/chrome.exe"
D=$(cd "$(dirname "$0")" && pwd -W)
for c in 15 10; do
  suf=""; [ "$c" = "10" ] && suf="-10off"
  for s in 900 311; do
    "$C" --headless=new --disable-gpu --hide-scrollbars --force-device-scale-factor=1 --virtual-time-budget=5000 \
      --window-size=1600,$s --screenshot="$D/banner-1600x$s$suf.png" "file:///$D/banner.html?s=$s&c=$c" 2>/dev/null
    python -c "from PIL import Image;Image.open(r'$D/banner-1600x$s$suf.png').convert('RGB').save(r'$D/banner-1600x$s$suf.jpg',quality=92)"
  done
done
