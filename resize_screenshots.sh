#!/bin/bash

# 스크립트 디렉토리로 이동
cd "$(dirname "$0")"

# 출력 디렉토리 생성
mkdir -p screenshots/appstore/iphone_6.5
mkdir -p screenshots/appstore/iphone_6.7
mkdir -p screenshots/appstore/ipad

echo "=== 스크린샷 리사이즈 시작 ==="

# iPhone 6.5" (1242 × 2688px) - iPhone 11 Pro Max, XS Max
echo "iPhone 6.5\" 크기로 변환 중..."
for file in screenshots/*.jpg; do
    if [[ -f "$file" ]] && [[ ! "$file" =~ "feature_graphic" ]]; then
        filename=$(basename "$file" .jpg)
        sips -z 2688 1242 "$file" --out "screenshots/appstore/iphone_6.5/${filename}_1242x2688.jpg"
        echo "  ✓ ${filename}_1242x2688.jpg"
    fi
done

# iPhone 6.7" (1284 × 2778px) - iPhone 14 Pro Max, 15 Pro Max
echo "iPhone 6.7\" 크기로 변환 중..."
for file in screenshots/*.jpg; do
    if [[ -f "$file" ]] && [[ ! "$file" =~ "feature_graphic" ]]; then
        filename=$(basename "$file" .jpg)
        sips -z 2778 1284 "$file" --out "screenshots/appstore/iphone_6.7/${filename}_1284x2778.jpg"
        echo "  ✓ ${filename}_1284x2778.jpg"
    fi
done

# iPad Pro 12.9" (2048 × 2732px)
echo "iPad 12.9\" (2048 × 2732px) 크기로 변환 중..."
if [ -d "screenshots/ios/ipad" ]; then
    for file in screenshots/ios/ipad/*.png; do
        if [[ -f "$file" ]]; then
            filename=$(basename "$file" .png)
            sips -z 2732 2048 "$file" --out "screenshots/appstore/ipad/${filename}_2048x2732.jpg"
            echo "  ✓ ${filename}_2048x2732.jpg"
        fi
    done
fi

# iPad Pro 12.9" (2064 × 2752px) - 최신
echo "iPad 12.9\" (2064 × 2752px) 크기로 변환 중..."
if [ -d "screenshots/ios/ipad" ]; then
    for file in screenshots/ios/ipad/*.png; do
        if [[ -f "$file" ]]; then
            filename=$(basename "$file" .png)
            sips -z 2752 2064 "$file" --out "screenshots/appstore/ipad/${filename}_2064x2752.jpg"
            echo "  ✓ ${filename}_2064x2752.jpg"
        fi
    done
fi

echo ""
echo "=== 완료! ==="
echo "변환된 파일 위치:"
echo "  • iPhone 6.5\": screenshots/appstore/iphone_6.5/"
echo "  • iPhone 6.7\": screenshots/appstore/iphone_6.7/"
echo "  • iPad: screenshots/appstore/ipad/"
