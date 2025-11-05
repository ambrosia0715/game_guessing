#!/bin/bash

# Android Release Keystore 생성 스크립트

echo "🔐 Android Release Keystore 생성을 시작합니다..."
echo ""
echo "다음 정보를 입력해주세요:"
echo "- 비밀번호: 안전한 비밀번호 (최소 6자)"
echo "- 이름: 개발자 또는 회사 이름"
echo "- 조직: Ambro"
echo "- 도시, 시/도, 국가 코드 등"
echo ""

# keystore 생성
keytool -genkey -v -keystore ~/upload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload

echo ""
echo "✅ Keystore가 생성되었습니다!"
echo "📍 위치: ~/upload-keystore.jks"
echo ""
echo "⚠️  중요: 이 파일과 비밀번호를 안전하게 보관하세요!"
echo "분실 시 앱 업데이트가 불가능합니다."
