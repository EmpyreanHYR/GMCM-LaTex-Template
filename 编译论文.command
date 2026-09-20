#!/bin/bash
# 在 Finder 中双击即可编译；只处理 GMCM-main.tex。
cd -- "$(dirname -- "${BASH_SOURCE[0]}")" || exit 1

if /bin/bash ./makefiles.sh; then
    /usr/bin/open ./GMCM-main.pdf
else
    gmcm_status=$?
    if [ -t 0 ]; then
        read -r -p '按回车键关闭…' _
    fi
    exit "$gmcm_status"
fi
