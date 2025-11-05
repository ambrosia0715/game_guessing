#!/bin/bash

# 비밀번호를 입력받습니다
echo "======================================"
echo "🔐 Android Release Keystore 생성"
echo "======================================"
echo ""
read -sp "생성할 keystore 비밀번호를 입력하세요: " password
echo ""
read -sp "비밀번호를 다시 입력하세요 (확인용): " password2
echo ""

if [ "$password" != "$password2" ]; then
    echo "❌ 비밀번호가 일치하지 않습니다!"
    exit 1
fi

echo ""
echo "📝 Keystore를 생성하고 있습니다..."
echo ""

# keystore 생성 (모든 정보 자동 입력)
keytool -genkey -v \
  -keystore ~/upload-keystore.jks \
  -storetype JKS \
  -keyalg RSA \
  -keysize 2048 \
  -validity 10000 \
  -alias upload \
  -storepass "$password" \
  -keypass "$password" \
  -dname "CN=Ambro, OU=Ambro, O=Ambro, L=Seoul, ST=Seoul, C=KR"

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Keystore가 성공적으로 생성되었습니다!"
    echo "📍 위치: ~/upload-keystore.jks"
    echo ""
    echo "이제 key.properties 파일을 생성합니다..."
    
    # key.properties 파일 생성
    cat > android/key.properties << EOF
storePassword=$password
keyPassword=$password
keyAlias=upload
storeFile=$HOME/upload-keystore.jks
EOF
    
    echo "✅ key.properties 파일이 생성되었습니다!"
    echo "📍 위치: android/key.properties"
    echo ""
    echo "⚠️  중요: 비밀번호를 안전한 곳에 보관하세요!"
    echo "비밀번호: $password"
else
    echo "❌ Keystore 생성에 실패했습니다."
    exit 1
fi
