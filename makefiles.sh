#!/bin/bash
set -euo pipefail

# Finder 启动 Terminal 时也能找到 MacTeX。
export PATH="/Library/TeX/texbin:/opt/homebrew/bin:${PATH:-/usr/bin:/bin}"
cd -- "$(dirname -- "${BASH_SOURCE[0]}")"

if [ "$#" -ne 0 ]; then
    printf '本脚本只编译 GMCM-main.tex，无需参数。\n' >&2
    exit 2
fi
if ! command -v latexmk >/dev/null 2>&1; then
    printf '未找到 latexmk，请先安装 MacTeX。\n' >&2
    exit 127
fi
if [ ! -f GMCM-main.tex ]; then
    printf '未找到主文件 GMCM-main.tex。\n' >&2
    exit 1
fi

# 所有辅助文件只写入本次临时目录，不散落在论文目录。
gmcm_build_dir=$(mktemp -d "${TMPDIR:-/tmp}/gmcm-build.XXXXXX")
trap 'rm -rf -- "$gmcm_build_dir"' EXIT
trap 'exit 130' INT
trap 'exit 143' TERM

printf '正在编译 GMCM-main.tex（XeLaTeX + BibTeX）…\n'
if latexmk -norc -r .latexmkrc -outdir="$gmcm_build_dir" GMCM-main.tex \
    > "$gmcm_build_dir/build.log" 2>&1; then
    cp -- "$gmcm_build_dir/GMCM-main.pdf" GMCM-main.pdf
    rm -f -- GMCM-build-error.log
    printf '编译成功：%s/GMCM-main.pdf\n' "$PWD"
    printf '编译辅助文件已自动清理。\n'
else
    gmcm_status=$?
    cp -- "$gmcm_build_dir/build.log" GMCM-build-error.log
    printf '编译失败，原有 PDF 保持不变。错误日志：%s/GMCM-build-error.log\n' "$PWD" >&2
    tail -n 25 GMCM-build-error.log >&2
    exit "$gmcm_status"
fi
