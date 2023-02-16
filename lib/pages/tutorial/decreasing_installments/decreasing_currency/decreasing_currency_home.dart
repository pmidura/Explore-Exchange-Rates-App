import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'decreasing_currency_page_1.dart';
import 'decreasing_currency_page_2.dart';
import 'decreasing_currency_page_3.dart';
import 'decreasing_currency_page_4.dart';
import 'decreasing_currency_page_5.dart';
import 'decreasing_currency_page_6.dart';
import 'decreasing_currency_page_7.dart';
import 'decreasing_currency_page_8.dart';
import 'decreasing_currency_page_9.dart';
import 'decreasing_currency_page_10.dart';

class DecreasingCurrencyHome extends StatefulWidget {
  const DecreasingCurrencyHome({super.key});

  @override
  State<DecreasingCurrencyHome> createState() => _DecreasingCurrencyHomeState();
}

class _DecreasingCurrencyHomeState extends State<DecreasingCurrencyHome> {
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
              setState(() => onLastPage = (index == 9));
            },
            children: const [
              DecreasingCurrencyPage1(),
              DecreasingCurrencyPage2(),
              DecreasingCurrencyPage3(),
              DecreasingCurrencyPage4(),
              DecreasingCurrencyPage5(),
              DecreasingCurrencyPage6(),
              DecreasingCurrencyPage7(),
              DecreasingCurrencyPage8(),
              DecreasingCurrencyPage9(),
              DecreasingCurrencyPage10(),
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
                  onTap: () => _controller.jumpToPage(9),
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
                  count: 10,
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
