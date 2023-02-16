import 'package:flutter/material.dart';

class EqualCurrencyPage6 extends StatelessWidget {
  const EqualCurrencyPage6({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0E1117),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Kapitał pozostały do spłaty - Excel",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.blueGrey.shade100,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.15,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: AssetImage("assets/equal_currency_images/step_3.PNG"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Text(
              "Kapitał do spłaty = Kwota kredytu - Cz. Kapit.\n"
              "Rata nr 1 - Kapitał do spłaty = 10 788,18€ - 164,79€ = 10 623,39€",
              textAlign: TextAlign.justify,
              style: TextStyle(
                foreground: Paint()..color = Colors.white70,
                fontWeight: FontWeight.normal,
                fontSize: 16,
                height: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
