#!/bin/bash

echo "📱 iOS Archive 생성 가이드"
echo "============================"
echo ""
echo "⚠️  이 스크립트는 Apple Developer 계정이 설정된 후 실행하세요."
echo ""
echo "1단계: Xcode에서 Team 설정"
echo "   - Xcode를 열고"
echo "   - Runner > Signing & Capabilities"
echo "   - Team: [Apple Developer 계정 선택]"
echo ""
echo "2단계: 아래 명령어로 자동 빌드 시도"
echo ""

# iOS Archive 자동 생성 시도
echo "🔨 iOS Archive를 생성하고 있습니다..."
echo ""

cd "$(dirname "$0")/ios"

# Clean
echo "1. 클린..."
flutter clean
rm -rf Pods Podfile.lock

# Pub get
echo "2. 패키지 업데이트..."
cd ..
flutter pub get

# Pod install
echo "3. CocoaPods 설치..."
cd ios
pod install

# Archive 생성 (명령줄)
echo "4. Archive 생성 중..."
echo ""
echo "⚠️  주의: Team과 Provisioning Profile이 설정되어 있어야 합니다!"
echo ""

xcodebuild -workspace Runner.xcworkspace \
  -scheme Runner \
  -configuration Release \
  -archivePath build/Runner.xcarchive \
  archive

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Archive 생성 완료!"
    echo "📍 위치: ios/build/Runner.xcarchive"
    echo ""
    echo "다음 단계:"
    echo "1. Xcode Organizer 열기: Window > Organizer"
    echo "2. 생성된 Archive 찾기"
    echo "3. 'Distribute App' 클릭"
    echo "4. App Store Connect 업로드"
else
    echo ""
    echo "❌ Archive 생성 실패"
    echo ""
    echo "해결 방법:"
    echo "1. Xcode에서 직접 Archive 생성:"
    echo "   Product > Archive"
    echo ""
    echo "2. Team 설정 확인:"
    echo "   Runner > Signing & Capabilities > Team 선택"
fi
