import 'package:flutter/material.dart';

class DecreasingCurrencyPage4 extends StatelessWidget {
  const DecreasingCurrencyPage4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0E1117),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Obliczanie części kapitałowej - Excel",
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
                image: AssetImage("assets/decreasing_currency_images/step_3.PNG"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Text(
              "Zróbmy tabelkę w Excel'u jak powyżej.",
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
              "Aby obliczyć część kapitałową musimy podzielić Początkową kwotę kredytu w Walucie przez Okres kredytowania.\n\n"
              "W tym celu dzielimy wartości zablokowanych komórek (N / n).\n\n"
              "Część kapitałowa w przypadku rat malejących jest taka sama dla każdej raty.",
              textAlign: TextAlign.justify,
              style: TextStyle(
                foreground: Paint()..color = Colors.white70,
                fontWeight: FontWeight.normal,
                fontSize: 16,
                height: 2,
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
