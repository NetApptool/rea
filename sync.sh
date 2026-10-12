#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

echo "=== [$(date '+%Y-%m-%d %H:%M:%S')] 检查并同步 upstream (morluto/rea) ==="
git fetch upstream --tags
git fetch upstream main

BRANCH=$(git branch --show-current)
if [ "$BRANCH" = "main" ]; then
    echo "正在合并 upstream/main 到当前 main 分支..."
    git merge upstream/main --no-edit || {
        echo "合并冲突！请手动检查冲突解决后提交。"
        exit 1
    }
else
    echo "当前处于非 main 分支 ($BRANCH)，跳过自动合并。"
fi

echo "正在推送到 GitHub (NetApptool/rea)..."
git push origin main
git push origin --tags

echo "=== [$(date '+%Y-%m-%d %H:%M:%S')] 同步完成 ==="
