#!/bin/zsh
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

echo "开始运行论文复现流程..."
Rscript --vanilla run_replication.R
echo "复现完成，且一致性测试通过。"
