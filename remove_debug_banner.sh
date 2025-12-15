#!/bin/bash

# DEBUG 배너가 있는 스크린샷에서 배너 부분을 크롭하는 스크립트

echo "=== DEBUG 배너 제거 시작 ==="

# 입력 디렉토리
INPUT_DIR="screenshots"
OUTPUT_DIR="screenshots/no_debug"

mkdir -p "$OUTPUT_DIR"

# iPhone 스크린샷 처리 (상단 50px 제거 - DEBUG 배너 영역)
for file in "$INPUT_DIR"/*.jpg; do
    if [[ -f "$file" ]]; then
        filename=$(basename "$file")
        
        # 이미지 크기 확인
        width=$(sips -g pixelWidth "$file" | tail -1 | awk '{print $2}')
        height=$(sips -g pixelHeight "$file" | tail -1 | awk '{print $2}')
        
        # 상단 50px 제거 (DEBUG 배너가 있는 부분)
        new_height=$((height - 50))
        
        # 크롭 (상단 50px 제거)
        sips --cropToHeightWidth $new_height $width "$file" --out "$OUTPUT_DIR/$filename"
        
        echo "  ✓ $filename 처리 완료 (${width}x${height} → ${width}x${new_height})"
    fi
done

echo ""
echo "=== 완료! ==="
echo "처리된 파일: $OUTPUT_DIR/"
