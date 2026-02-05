#!/usr/bin/env bash
set -e
ENV_FILE=".env"
if [ -f "$ENV_FILE" ]; then
  echo ".env 已存在，保留原文件。"
  exit 0
fi

echo "从 Codespaces 环境变量（Secrets）生成 .env（若存在）..."
: > "$ENV_FILE"

# 如果你的 bot 需要其他环境变量，请在这里添加
vars=(BOT_TOKEN DATABASE_URL DISCORD_CLIENT_ID DISCORD_CLIENT_SECRET OTHER_SECRET)

for v in "${vars[@]}"; do
  val="${!v}"
  if [ -n "$val" ]; then
    printf '%s=%s\n' "$v" "$val" >> "$ENV_FILE"
  else
    printf '# %s 未设置\n' "$v" >> "$ENV_FILE"
  fi
done

echo ".env 已写入，请在 Codespace 中检查并补全缺失的值（若有）。"
