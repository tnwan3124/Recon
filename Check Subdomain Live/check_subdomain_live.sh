#!/bin/bash

INPUT_FILE="subdomains_merged.txt"
OUTPUT_DIR="httpx_results"
RAW_RESULT="$OUTPUT_DIR/raw_results.txt"

# TỰ ĐỘNG DÒ ĐƯỜNG DẪN HTTPX CHUẨN
if [ -f "$HOME/go/bin/httpx" ]; then
    HTTPX_BIN="$HOME/go/bin/httpx"
elif [ -f "/go/bin/httpx" ]; then
    HTTPX_BIN="/go/bin/httpx"
else
    echo " Lỗi: Không tìm thấy httpx của ProjectDiscovery."
    exit 1
fi

if [ ! -f "$INPUT_FILE" ]; then
    echo "Lỗi: Không tìm thấy file $INPUT_FILE"
    exit 1
fi

mkdir -p "$OUTPUT_DIR"

echo "=================================================="
echo " Bắt đầu quét với httpx (Chạy Async mặc định)..."
echo "=================================================="

# Bỏ hoàn toàn cờ luồng để chạy mượt mà trên mọi phiên bản
$HTTPX_BIN -l "$INPUT_FILE" -status-code -title -no-color -o "$RAW_RESULT"

echo -e "\n=================================================="
echo "Đang phân loại siêu tốc bằng AWK..."
echo "=================================================="

if [ -f "$RAW_RESULT" ]; then
    awk -v dir="$OUTPUT_DIR" '
    match($0, /\[[0-9]{3}\]/) {
        code = substr($0, RSTART+1, RLENGTH-2)
        print $0 >> (dir "/sub_" code ".txt")
    }' "$RAW_RESULT"
    echo "Đã xong! Check kết quả trong thư mục /$OUTPUT_DIR"
    ls -lh "$OUTPUT_DIR" | grep "sub_"
else
    echo " Lỗi: Không thể tạo được file kết quả thô."
fi
