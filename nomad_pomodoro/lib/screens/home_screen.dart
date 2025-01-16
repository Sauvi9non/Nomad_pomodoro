import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int totalSeconds = 1500;
  late Timer timer; //사용자가 버튼 누를 때만 생성되도록 -> 나중에 초기화 된다 -> late로 이를 명시
  bool isRunning = false; //처음에는 시간이 안가니까 true, 최초 1회 누르고 나서야 false

  void onTick(Timer timer) {
    //1초 1Tick마다 실행할
    setState(() {
      totalSeconds = totalSeconds - 1;
      if (totalSeconds == 0) {
        isRunning = false;
        timer.cancel();
      }
    });
  }

  void onStartPressed() {
    //이 메서드는 Timer를 만든다. Timer는 Dart의 표준 라이브러리에 포함
    //타이머가 생성
    //타이머 초기화
    timer = Timer.periodic(Duration(seconds: 1), onTick);
    setState(() {
      isRunning = true; //isPause 상태 반대로
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Flexible(
            //Flexible 하드 코딩되는 값을 만들게 해준다
            //UI를 비율에 기반해서 더 유연하게
            //그리고 그 비율을 설정해줘야한다.
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                (totalSeconds != 0) ? "$totalSeconds" : "fin",
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 89,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Center(
              child: IconButton(
                onPressed: isRunning ? onPausePressed : onStartPressed,
                icon: isRunning
                    ? Icon(Icons.pause_circle_outline)
                    : Icon(Icons.play_circle_outline),
                iconSize: 120,
                color: Theme.of(context).cardColor,
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  //Creates a widget that expands a child of a [Row], [Column], or [Flex]
                  //so that the child fills the available space along the flex widget's main axis.
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "POMODORO",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context)
                                .textTheme
                                .headlineLarge! // !는 확실히 있다고 알려주는(?) ?는 있으면, 없거나 있으면
                                .color,
                          ),
                        ),
                        Text(
                          "0", //pomodoro를 끝낸 횟수
                          style: TextStyle(
                            fontSize: 58,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context)
                                .textTheme
                                .headlineLarge! // !는 확실히 있다고 알려주는(?) ?는 있으면, 없거나 있으면
                                .color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          //Flexible 하드 코딩되는 값을 만들게 해준다 < ? UI를 비율에 기반해서 더 유연하게
        ],
      ),
    );
  }
}
