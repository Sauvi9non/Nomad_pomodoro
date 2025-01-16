import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                "25:00",
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
                onPressed: () {},
                icon: Icon(Icons.play_circle_outline),
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
