import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'equal_currency_page_1.dart';
import 'equal_currency_page_2.dart';
import 'equal_currency_page_3.dart';
import 'equal_currency_page_4.dart';
import 'equal_currency_page_5.dart';
import 'equal_currency_page_6.dart';
import 'equal_currency_page_7.dart';
import 'equal_currency_page_8.dart';
import 'equal_currency_page_9.dart';

class EqualCurrencyHome extends StatefulWidget {
  const EqualCurrencyHome({super.key});

  @override
  State<EqualCurrencyHome> createState() => _EqualCurrencyHomeState();
}

class _EqualCurrencyHomeState extends State<EqualCurrencyHome> {
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
              setState(() => onLastPage = (index == 8));
            },
            children: const [
              EqualCurrencyPage1(),
              EqualCurrencyPage2(),
              EqualCurrencyPage3(),
              EqualCurrencyPage4(),
              EqualCurrencyPage5(),
              EqualCurrencyPage6(),
              EqualCurrencyPage7(),
              EqualCurrencyPage8(),
              EqualCurrencyPage9(),
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
                  onTap: () => _controller.jumpToPage(8),
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
                  count: 9,
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
