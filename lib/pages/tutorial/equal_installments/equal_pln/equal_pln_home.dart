import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'equal_pln_page_1.dart';
import 'equal_pln_page_2.dart';
import 'equal_pln_page_3.dart';
import 'equal_pln_page_4.dart';
import 'equal_pln_page_5.dart';
import 'equal_pln_page_6.dart';
import 'equal_pln_page_7.dart';
import 'equal_pln_page_8.dart';

class EqualPLNHome extends StatefulWidget {
  const EqualPLNHome({super.key});

  @override
  State<EqualPLNHome> createState() => _EqualPLNHomeState();
}

class _EqualPLNHomeState extends State<EqualPLNHome> {
  // Controller to keep track of which page we're on
  final PageController _controller = PageController();

  // Keep tracking if we are on the last page or not
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() => onLastPage = (index == 7));
            },
            children: const [
              EqualPLNPage1(),
              EqualPLNPage2(),
              EqualPLNPage3(),
              EqualPLNPage4(),
              EqualPLNPage5(),
              EqualPLNPage6(),
              EqualPLNPage7(),
              EqualPLNPage8(),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.90),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                onLastPage ?
                GestureDetector(
                  child: const Text(''),
                ) :
                GestureDetector(
                  onTap: () => _controller.jumpToPage(7),
                  child: Text(
                    'Pomiń',
                    style: TextStyle(
                      foreground: Paint()..shader = const LinearGradient(
                        colors: <Color>[
                          Color(0xff159DFF),
                          Color(0xff159DAA),
                        ],
                      ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
                SmoothPageIndicator(
                  controller: _controller,
                  count: 8,
                ),
                onLastPage ?
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Text(
                    'Koniec',
                    style: TextStyle(
                      foreground: Paint()..shader = const LinearGradient(
                        colors: <Color>[
                          Color(0xff159DFF),
                          Color(0xff159DAA),
                        ],
                      ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ) :
                GestureDetector(
                  onTap: () {
                    _controller.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                    );
                  },
                  child: Text(
                    'Dalej',
                    style: TextStyle(
                      foreground: Paint()..shader = const LinearGradient(
                        colors: <Color>[
                          Color(0xff159DFF),
                          Color(0xff159DAA),
                        ],
                      ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
