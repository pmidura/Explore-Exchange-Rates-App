import 'package:flutter/material.dart';

class DecreasingCurrencyPage9 extends StatelessWidget {
  const DecreasingCurrencyPage9({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0E1117),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Kredyt w Walucie - Raty malejące - cd.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.blueGrey.shade100,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: AssetImage("assets/decreasing_currency_images/step_4.PNG"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Text(
              "5. Nasz pierwszy wiersz powinien wyglądać jak na obrazku powyżej.",
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
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Text(
              "6. Następnie w drugim wierszu w kolumnie {Kwota kredytu} przenosimy wartość z kolumny {Kapitał do spłaty} wiersza pierwszego.",
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
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Text(
              "7. Jeżeli wszystko zrobiliśmy poprawnie, możemy usprawnić naszą pracę. Zaznaczamy rekord kolumny {Kwota kredytu} "
                  "wiersza drugiego i przeciągamy go aż do raty nr 59 (do samego końca). Analogicznie postępujemy w przypadku pozostałych kolumn - "
                  "tym razem od wiersza pierwszego.",
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
