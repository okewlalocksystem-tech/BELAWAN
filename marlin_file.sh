#!/bin/bash

# === SET TIMEZONE MANUAL UNTUK SCRIPT ===
export TZ="Asia/Jakarta"

# === CONFIG TELEGRAM ===
BOT_TOKEN="8232567412:AAFTgT8hqIfroCZ3DYNQHm8Ap7PhtDrWPQ0"
CHAT_ID="6262233604"

# === DIRECTORY YANG MAU DI CEK ===
TARGET_DIR="/home/u122046868/domains/"

# === CEK FILE YANG DIUBAH HARI INI ===
TODAY=$(date +"%Y-%m-%d")

FILES=$(find "$TARGET_DIR" -type f \
  -newermt "$TODAY 00:00:00" ! -newermt "$TODAY 23:59:59" \
  -not -path "*/cache/*" | head -n 50)

# Jika tidak ada file baru → keluar
if [ -z "$FILES" ]; then
  exit 0
fi

# === KIRIM KE TELEGRAM ===
for file in $FILES; do
  curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
    -d chat_id="$CHAT_ID" \
    -d text="📄 File diubah: $file"
done
