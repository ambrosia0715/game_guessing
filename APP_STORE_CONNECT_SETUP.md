# App Store Connect 설정 가이드

## 해결된 문제들

### 1. ✅ Game Center 권한 추가
- `Runner.entitlements` 파일에 `com.apple.developer.game-center` 키를 추가했습니다.

### 2. ✅ NSUserTrackingUsageDescription 제거
- 추적 목적이 아닌 경우 이 키를 제거했습니다.
- SKAdNetwork 식별자를 추가하여 AdMob 광고를 지원합니다.

## App Store Connect에서 수동으로 처리해야 할 사항

### 3. ⚠️ 실시간 재질리기 지원 관련 권한 설정
**해결 방법:**
1. App Store Connect (https://appstoreconnect.apple.com)에 로그인
2. 해당 앱 선택
3. **App 정보** 탭으로 이동
4. **Game Center** 섹션에서 실시간 재질리기 기능 활성화
5. 또는 **기능** 탭에서 관련 권한을 관리

### 4. ⚠️ 가족이나 거래 등급 선택
**해결 방법:**
1. App Store Connect에서 해당 앱 선택
2. **앱 정보** 탭으로 이동
3. **일반 정보** 섹션에서:
   - **연령 등급**: 앱 콘텐츠에 맞는 등급 선택 (예: 4+, 9+, 12+, 17+)
   - **가족 공유**: 필요한 경우 활성화
4. **저장** 클릭

## 다음 단계

1. Xcode에서 프로젝트를 다시 빌드합니다.
2. Archive를 생성합니다.
3. App Store Connect에 업로드합니다.
4. 위의 수동 설정들을 완료합니다.

## 추가 참고사항

- **Game Center가 필요하지 않은 경우**: `Runner.entitlements`에서 해당 키를 제거하세요.
- **AdMob 사용 시**: SKAdNetwork 식별자가 올바르게 설정되어 있는지 확인하세요.
- **개인정보 보호**: 실제로 사용자 추적을 하지 않는다면 ATT 프롬프트는 표시하지 마세요.

## 문제 발생 시

Xcode에서 "Product" > "Clean Build Folder" (Shift + Command + K)를 실행한 후 다시 빌드해보세요.
