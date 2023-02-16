import 'package:flutter/material.dart';

class EqualPLNPage1 extends StatelessWidget {
  const EqualPLNPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0E1117),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Wzór na wyliczenie raty równej",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.blueGrey.shade100,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: AssetImage("assets/equal_pln_images/step_1.PNG"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Text(
                "R - rata kredytu",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  foreground: Paint()..color = Colors.white70,
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
              ),
            ),
            const Divider(
              height: 40,
              thickness: 1,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Text(
                "N - kwota kredytu",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  foreground: Paint()..color = Colors.white70,
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
              ),
            ),
            const Divider(
              height: 40,
              thickness: 1,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Text(
                "r - oprocentowanie kredytu w skali roku",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  foreground: Paint()..color = Colors.white70,
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
              ),
            ),
            const Divider(
              height: 40,
              thickness: 1,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Text(
                "k - liczba rat w ciągu roku (płatne miesięcznie = 12, półrocznie = 6, kwartalnie = 4, rocznie = 1)",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  foreground: Paint()..color = Colors.white70,
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  height: 1.6,
                ),
              ),
            ),
            const Divider(
              height: 40,
              thickness: 1,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Text(
                "n - liczba rat kredytu (okres kredytowania)",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  foreground: Paint()..color = Colors.white70,
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
              ),
            ),
            const Divider(
              height: 40,
              thickness: 1,
              color: Colors.grey,
            ),
          ],
        ),
    );
  }
}
