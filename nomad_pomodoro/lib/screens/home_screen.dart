import 'dart:async';
import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const List<int> timeSelect = [5, 1500];
  int totalSeconds = timeSelect[0];
  late Timer timer; //사용자가 버튼 누를 때만 생성되도록 -> 나중에 초기화 된다 -> late로 이를 명시
  bool isRunning = false; //처음에는 시간이 안가니까 true, 최초 1회 누르고 나서야 false
  bool showRestart = false;
  int cycles = 3;
  int rounds = 0;

  void onTick(Timer timer) {
    //1초 1Tick마다 실행할
    setState(() {
      if (totalSeconds == 0) {
        isRunning = false;
        timer.cancel();
        cycles = cycles + 1;
        totalSeconds = timeSelect[0]; // 선택한 타이머 시간으로 다시
      } else {
        totalSeconds = totalSeconds - 1;
      }

      //라운드 1회 추가
      if ((4 / cycles) == 0) {
        rounds = rounds + 1;
        cycles = 0; //사이클은 다시 0으로
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
      showRestart = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onRestartPressed() {
    setState(() {
      totalSeconds = timeSelect[0];
      isRunning = false;
      timer.cancel();
    });
  }

  String format(int secs) {
    var duration = Duration(seconds: secs);
    // var trimmedDuration = duration.toString().split(".")[0].split(":");
    // var hour = trimmedDuration[0];
    // var minute = trimmedDuration[1];
    // var second = trimmedDuration[2];
    var MinuteSecond = duration.toString().split(".")[0].substring(2, 7);
    // print(MinuteSecond);
    return MinuteSecond;
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
                (totalSeconds != 0) ? format(totalSeconds) : "fin",
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: isRunning ? onPausePressed : onStartPressed,
                    icon: isRunning
                        ? Icon(Icons.pause_circle_outline)
                        : Icon(Icons.play_circle_outline),
                    iconSize: 120,
                    color: Theme.of(context).cardColor,
                  ),
                  showRestart
                      ? IconButton(
                          onPressed: onRestartPressed,
                          icon: Icon(Icons.restart_alt_outlined),
                          iconSize: 48,
                          color: Theme.of(context).cardColor.withAlpha(150),
                        )
                      : SizedBox(),
                ],
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "CYCLE",
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
                              "$cycles", //pomodoro를 끝낸 횟수
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
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "ROUND",
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
                              (cycles * 0.25)
                                  .truncate()
                                  .toString(), //pomodoro를 끝낸 횟수
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
