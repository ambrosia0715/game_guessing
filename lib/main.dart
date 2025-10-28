import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:vibration/vibration.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    MobileAds.instance.initialize();
  }
  runApp(const GameGuessingApp());
}

class GameGuessingApp extends StatelessWidget {
  const GameGuessingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '눈치게임',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const StartScreen(),
    );
  }
}

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  int _playerCount = 2;
  List<String> _playerNames = [];

  @override
  void initState() {
    super.initState();
    _initializePlayers();
  }

  void _initializePlayers() {
    _playerNames = List.generate(_playerCount, (index) => '${index + 1}');
  }

  void _startGame() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            GameScreen(playerCount: _playerCount, playerNames: _playerNames),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.purple.shade300,
              Colors.blue.shade400,
              Colors.teal.shade300,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 게임 타이틀
                  Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.orange.shade100,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.orange.shade300,
                              width: 3,
                            ),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.touch_app,
                                  size: 40,
                                  color: Colors.orange.shade700,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '1 2 3',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange.shade700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          '눈치게임',
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),

                  // 참여자 설정
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // 참여자 수 선택
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              '참여자 수: ',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              onPressed: _playerCount > 2
                                  ? () {
                                      setState(() {
                                        _playerCount--;
                                        _initializePlayers();
                                      });
                                    }
                                  : null,
                              icon: const Icon(Icons.remove_circle),
                              iconSize: 30,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade100,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '$_playerCount명',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: _playerCount < 8
                                  ? () {
                                      setState(() {
                                        _playerCount++;
                                        _initializePlayers();
                                      });
                                    }
                                  : null,
                              icon: const Icon(Icons.add_circle),
                              iconSize: 30,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // 참여자 이름 입력
                        const Text(
                          '참여자 이름 (선택사항)',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ...List.generate(_playerCount, (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: '참여자 ${index + 1}',
                                hintText: '이름을 입력하세요 (비워두면 ${index + 1})',
                                border: const OutlineInputBorder(),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _playerNames[index] = value.isEmpty
                                      ? '${index + 1}'
                                      : value;
                                });
                              },
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),

                  // 시작 버튼
                  ElevatedButton(
                    onPressed: _startGame,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 60,
                        vertical: 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      'START',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GameScreen extends StatefulWidget {
  final int playerCount;
  final List<String> playerNames;

  const GameScreen({
    super.key,
    required this.playerCount,
    required this.playerNames,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with TickerProviderStateMixin {
  late int _playerCount;
  late List<String> _playerNames;
  List<bool> _buttonPressed = [];
  final List<Color> _buttonColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.teal,
    Colors.brown,
  ];

  bool _gameStarted = false;
  bool _gameFinished = false;
  String _countText = '';
  List<String> _winners = [];

  // 버튼을 뗀 순서를 추적하기 위한 변수들
  final Map<int, int> _releaseOrder = {}; // 플레이어 인덱스 -> 뗀 순서
  int _releaseCounter = 0;
  bool _isCountingDown = false; // 카운트다운 상태 추적

  // 타이머 관련 변수 제거됨

  // 게임 영역 크기를 저장하는 변수
  double _gameAreaSize = 280;

  late AnimationController _countAnimationController;
  late Animation<double> _scaleAnimation;

  BannerAd? _bannerAd;
  bool _isBannerAdReady = false;

  @override
  void initState() {
    super.initState();
    _playerCount = widget.playerCount;
    _playerNames = List.from(widget.playerNames);
    _buttonPressed = List.generate(_playerCount, (index) => false);
    _initializeCountAnimation();
    _loadBannerAd();
  }

  void _initializeCountAnimation() {
    _countAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.5).animate(
      CurvedAnimation(
        parent: _countAnimationController,
        curve: Curves.elasticOut,
      ),
    );
  }

  // 진동 효과 함수
  void _triggerButtonVibration() {
    Vibration.vibrate(duration: 50); // 짧은 진동
  }

  void _loadBannerAd() {
    if (!kIsWeb) {
      _bannerAd = BannerAd(
        // 실제 AdMob 광고 단위 ID 사용
        adUnitId: 'ca-app-pub-1444459980078427/6697669191',
        request: const AdRequest(),
        size: AdSize.banner,
        listener: BannerAdListener(
          onAdLoaded: (_) => setState(() => _isBannerAdReady = true),
          onAdFailedToLoad: (ad, err) {
            print('AdMob 광고 로드 실패: $err');
            ad.dispose();
          },
        ),
      );
      _bannerAd?.load();
    }
  }

  @override
  void dispose() {
    _countAnimationController.dispose();
    _bannerAd?.dispose();
    super.dispose();
  }

  void _startCountdown() async {
    setState(() {
      _gameStarted = true;
      _gameFinished = false;
      _countText = '';
      _releaseOrder.clear();
      _releaseCounter = 0;
      _isCountingDown = true; // 카운트다운 시작
    });

    final random = Random();
    final totalTime = 3000;
    final delays = <int>[];

    int remainingTime = totalTime;
    for (int i = 0; i < 2; i++) {
      int delay = random.nextInt(remainingTime ~/ (3 - i)) + 200;
      delays.add(delay);
      remainingTime -= delay;
    }
    delays.add(remainingTime);

    for (int i = 1; i <= 3; i++) {
      await Future.delayed(Duration(milliseconds: delays[i - 1]));
      if (!_gameStarted) return;

      setState(() => _countText = i.toString());
      _countAnimationController.reset();
      _countAnimationController.forward();

      if (i == 3) {
        await Future.delayed(const Duration(milliseconds: 300));
        // 3초 카운트 완료 후 눈치게임 시작 (자동 종료 없음)
        setState(() {
          _countText = '';
          _isCountingDown = false; // 카운트다운 완료
        });
        // 게임은 계속 진행되며, 누군가 버튼을 떼거나 마지막 1인이 남을 때까지
      }
    }
  }

  // 30초 타이머 관련 코드 제거됨

  void _checkGameEnd() {
    // 누군가 버튼을 뗐을 때 즉시 게임 종료 여부 확인
    if (_gameFinished) return;

    // 1. 3초 카운트 중에 떼면 즉시 게임 종료
    if (_isCountingDown) {
      _endGame();
      return;
    }

    // 2. 동시에 뗀 사람들이 있는지 확인
    if (_releaseOrder.isNotEmpty) {
      Map<int, List<int>> simultaneousGroups = {};
      _releaseOrder.forEach((playerIndex, order) {
        if (!simultaneousGroups.containsKey(order)) {
          simultaneousGroups[order] = [];
        }
        simultaneousGroups[order]!.add(playerIndex);
      });

      // 2명 이상 동시에 뗀 그룹이 있으면 게임 종료
      for (var group in simultaneousGroups.values) {
        if (group.length > 1) {
          _endGame();
          return;
        }
      }
    }

    // 3. 마지막 1인이 남았는지 확인
    int stillPressedCount = 0;
    for (int i = 0; i < _playerCount; i++) {
      if (_buttonPressed[i]) {
        stillPressedCount++;
      }
    }

    // 마지막 1인이 남았으면 게임 종료
    if (stillPressedCount <= 1) {
      _endGame();
    }
  }

  void _endGame() {
    setState(() {
      _gameStarted = false;
      _gameFinished = true;
    });
    _determineWinners();
  }

  void _determineWinners() {
    // 1. 3초 카운트 중에 뗀 사람들이 걸림
    if (_isCountingDown && _releaseOrder.isNotEmpty) {
      List<String> earlyReleasers = [];
      _releaseOrder.forEach((playerIndex, order) {
        earlyReleasers.add(_playerNames[playerIndex]);
      });

      String result = '${earlyReleasers.join(', ')} 걸림! (카운트 중에 뗐음)';
      setState(() => _winners = [result]);
      return;
    }

    // 2. 동시에 뗀 사람들 확인
    if (_releaseOrder.isNotEmpty) {
      // 같은 순서로 뗀 사람들을 그룹화
      Map<int, List<int>> simultaneousGroups = {};
      _releaseOrder.forEach((playerIndex, order) {
        if (!simultaneousGroups.containsKey(order)) {
          simultaneousGroups[order] = [];
        }
        simultaneousGroups[order]!.add(playerIndex);
      });

      // 2명 이상 동시에 뗀 그룹이 있는지 확인
      for (var group in simultaneousGroups.values) {
        if (group.length > 1) {
          List<String> names = group.map((i) => _playerNames[i]).toList();
          String result = '${names.join(', ')} 걸림! (동시에 뗐음)';
          setState(() => _winners = [result]);
          return;
        }
      }
    }

    // 3. 마지막까지 누르고 있는 사람이 걸림
    List<String> allStillPressed = [];
    for (int i = 0; i < _playerCount; i++) {
      if (_buttonPressed[i]) {
        allStillPressed.add(_playerNames[i]);
      }
    }

    String result;
    if (allStillPressed.length == 1) {
      result = '${allStillPressed[0]} 걸림! (마지막까지 누르고 있었음)';
    } else if (allStillPressed.length > 1) {
      result = '${allStillPressed.join(', ')} 걸림! (마지막까지 누르고 있었음)';
    } else {
      result = '게임 종료 - 승자 없음';
    }

    setState(() => _winners = [result]);
  }

  void _resetGame() {
    setState(() {
      _gameStarted = false;
      _gameFinished = false;
      _countText = '';
      _winners = [];
      _buttonPressed = List.generate(_playerCount, (index) => false);
      _releaseOrder.clear();
      _releaseCounter = 0;
    });
    _countAnimationController.reset();
  }

  Widget _buildGameButtons() {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = MediaQuery.of(context).size.width;
        double screenHeight = MediaQuery.of(context).size.height;

        // 화면 크기에 맞춰 게임 영역을 조정 (설명 영역 고려)
        double availableWidth = screenWidth * 0.9;
        double availableHeight = screenHeight * 0.5; // 높이를 줄여서 설명 영역과 겹치지 않도록
        double gameAreaSize = min(availableWidth, availableHeight);
        gameAreaSize = max(gameAreaSize, 280); // 최소 크기도 줄임

        // 게임 영역 크기를 클래스 변수에 저장
        _gameAreaSize = gameAreaSize;

        // 버튼 크기를 플레이어 수와 화면 크기에 맞춰 동적 조정
        double buttonSize;
        if (_playerCount <= 3) {
          buttonSize = gameAreaSize * 0.18; // 3명 이하는 크게
        } else if (_playerCount <= 5) {
          buttonSize = gameAreaSize * 0.15; // 4-5명은 중간
        } else {
          buttonSize = gameAreaSize * 0.12; // 6명 이상은 작게
        }
        buttonSize = max(buttonSize, 70);
        buttonSize = min(buttonSize, 120);

        // 원형 배치 반지름을 최대한 크게 조정 (버튼이 화면을 벗어나지 않는 선에서)
        double radius = (gameAreaSize / 2) - (buttonSize / 2) - 20; // 여백 20px
        radius = max(radius, gameAreaSize * 0.25); // 최소 반지름 보장

        // 모든 버튼이 눌려있는지 확인
        bool allPressed = true;
        for (int i = 0; i < _playerCount; i++) {
          if (!_buttonPressed[i]) {
            allPressed = false;
            break;
          }
        }

        return Column(
          children: [
            // 게임 설명 영역 (항상 고정된 높이 유지)
            Container(
              height: 100, // 고정 높이로 버튼 위치 변경 방지
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: (!_gameStarted && !_gameFinished)
                  ? BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blue.shade200, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    )
                  : null,
              child: Center(
                child: (!_gameStarted && !_gameFinished)
                    ? Text(
                        allPressed
                            ? '🎮 모든 버튼이 눌렸습니다!\n게임이 곧 시작됩니다...'
                            : '👥 모든 참여자가 버튼을 동시에 누르고\n계속 눌러주세요!\n🎯 모든 버튼이 눌리면 게임 시작\n⏰ 1-2-3 카운트 후 손을 떼세요!',
                        style: TextStyle(
                          fontSize: 12,
                          color: allPressed
                              ? Colors.green.shade700
                              : Colors.blue.shade700,
                          fontWeight: FontWeight.w600,
                          height: 1.3,
                        ),
                        textAlign: TextAlign.center,
                      )
                    : const SizedBox(), // 게임 중/끝났을 때도 같은 높이 유지
              ),
            ),

            // 게임 영역과 설명 영역 사이 간격
            const SizedBox(height: 8),

            // 게임 영역 (버튼들과 오버레이)
            SizedBox(
              width: gameAreaSize,
              height: gameAreaSize,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // 게임 버튼들
                  ...List.generate(_playerCount, (index) {
                    double angle = (2 * pi * index) / _playerCount - pi / 2;
                    double x = radius * cos(angle);
                    double y = radius * sin(angle);

                    return Positioned(
                      left: gameAreaSize / 2 + x - buttonSize / 2,
                      top: gameAreaSize / 2 + y - buttonSize / 2,
                      child: Listener(
                        onPointerDown: (_) {
                          if (!_gameStarted && !_gameFinished) {
                            setState(() => _buttonPressed[index] = true);
                            _triggerButtonVibration(); // 버튼 누를 때 진동

                            // 모든 참여자의 버튼이 눌려있는지 확인
                            bool allPressed = true;
                            for (int i = 0; i < _playerCount; i++) {
                              if (!_buttonPressed[i]) {
                                allPressed = false;
                                break;
                              }
                            }
                            if (allPressed) {
                              _startCountdown();
                            }
                          }
                        },
                        onPointerUp: (_) {
                          if (!_gameStarted && !_gameFinished) {
                            // 게임 시작 전에는 버튼을 떼면 다시 false가 됨
                            setState(() => _buttonPressed[index] = false);
                            _triggerButtonVibration(); // 버튼 뗄 때 진동
                          } else if (_gameStarted && !_gameFinished) {
                            // 게임 중에는 버튼을 떼는 것이 게임의 핵심
                            // 버튼을 뗀 순서를 기록
                            if (_buttonPressed[index] &&
                                !_releaseOrder.containsKey(index)) {
                              _releaseOrder[index] = _releaseCounter++;
                              setState(() => _buttonPressed[index] = false);
                              _triggerButtonVibration(); // 게임 중 버튼 뺄 때 진동

                              // 카운트 중이거나 게임 중에 누군가 떼면 즉시 게임 종료 확인
                              _checkGameEnd();
                            }
                          }
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          width: _buttonPressed[index]
                              ? buttonSize * 0.9
                              : buttonSize,
                          height: _buttonPressed[index]
                              ? buttonSize * 0.9
                              : buttonSize,
                          decoration: BoxDecoration(
                            color: _buttonPressed[index]
                                ? _buttonColors[index].withOpacity(0.9)
                                : _buttonColors[index],
                            shape: BoxShape.circle,
                            border: _buttonPressed[index]
                                ? Border.all(color: Colors.white, width: 3)
                                : null,
                            boxShadow: _buttonPressed[index]
                                ? [
                                    BoxShadow(
                                      color: _buttonColors[index].withOpacity(
                                        0.6,
                                      ),
                                      blurRadius: 15,
                                      spreadRadius: 5,
                                      offset: const Offset(0, 0),
                                    ),
                                  ]
                                : [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                          ),
                          child: Center(
                            child: Text(
                              _playerNames[index],
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: max(buttonSize * 0.16, 12),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),

                  // 30초 타이머 제거됨

                  // 카운트 표시 - 중앙에 오버레이
                  if (_gameStarted && _countText.isNotEmpty)
                    AnimatedBuilder(
                      animation: _scaleAnimation,
                      builder: (context, child) {
                        return Container(
                          width: gameAreaSize * 0.4,
                          height: gameAreaSize * 0.4,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Transform.scale(
                              scale: _scaleAnimation.value,
                              child: Text(
                                _countText,
                                style: const TextStyle(
                                  fontSize: 80,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                  // 결과 표시 - 중앙에 오버레이
                  if (_gameFinished)
                    Container(
                      width: gameAreaSize * 0.8,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.green.shade100.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.green.shade300,
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Text(
                        _winners.first,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('눈치게임'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  _buildGameButtons(),
                  const SizedBox(height: 30),

                  // 컨트롤 버튼
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: _resetGame,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('재시작'),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('시작 화면'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          if (_isBannerAdReady && _bannerAd != null)
            SizedBox(
              width: _bannerAd!.size.width.toDouble(),
              height: _bannerAd!.size.height.toDouble(),
              child: AdWidget(ad: _bannerAd!),
            ),
        ],
      ),
    );
  }
}
