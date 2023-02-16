import 'package:flutter/material.dart';

class EqualCurrencyPage3 extends StatelessWidget {
  const EqualCurrencyPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0E1117),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Przykład - Excel cd.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.blueGrey.shade100,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: AssetImage("assets/equal_currency_images/step_2.PNG"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Text(
              "Rata kredytu w Walucie = 10 788,18€ * (((3,5% / 12) *\n(1 + (3,5% / 12)) ^ 60) / ((1 + (3,5% / 12)) ^ 60 - 1))",
              textAlign: TextAlign.justify,
              style: TextStyle(
                foreground: Paint()..color = Colors.white70,
                fontWeight: FontWeight.normal,
                fontSize: 16,
                height: 1.75,
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
              "Rata kredytu po przewalutowaniu = (Rata kredytu\nw walucie * Średni kurs sprzedaży danej waluty)",
              textAlign: TextAlign.justify,
              style: TextStyle(
                foreground: Paint()..color = Colors.white70,
                fontWeight: FontWeight.normal,
                fontSize: 16,
                height: 1.75,
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
