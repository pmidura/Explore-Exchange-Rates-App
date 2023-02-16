import 'package:flutter/material.dart';

class EqualCurrencyPage7 extends StatelessWidget {
  const EqualCurrencyPage7({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0E1117),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Kredyt w Walucie - Raty równe - Excel cd.",
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
                image: AssetImage("assets/equal_currency_images/step_4.PNG"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Text(
              "1. Rozpisujemy tabelkę w naszym przypadku dla 60 rat.",
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
              "2. Raty są równe, więc każdy rekord kolumny {Rata} będzie taki sam.",
              textAlign: TextAlign.justify,
              style: TextStyle(
                foreground: Paint()..color = Colors.white70,
                fontWeight: FontWeight.normal,
                fontSize: 16,
                height: 1.5,
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
              "3. W kolumnie {Cz. Odsetk.} zaznaczamy {Kwotę kredytu} dla danej raty i mnożymy ją przez zablokowaną komórkę {r_mies}.",
              textAlign: TextAlign.justify,
              style: TextStyle(
                foreground: Paint()..color = Colors.white70,
                fontWeight: FontWeight.normal,
                fontSize: 16,
                height: 1.5,
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
              "4. W kolumnie {Cz. Kapit.} odejmujemy rekord {Rata} od rekordu {Cz. Odsetk.} dla danej raty.",
              textAlign: TextAlign.justify,
              style: TextStyle(
                foreground: Paint()..color = Colors.white70,
                fontWeight: FontWeight.normal,
                fontSize: 16,
                height: 1.5,
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
              "5. W kolumnie {Kapitał do spłaty} odejmujemy {Kwotę kredytu} od {Cz. Kapit.} dla danej raty.",
              textAlign: TextAlign.justify,
              style: TextStyle(
                foreground: Paint()..color = Colors.white70,
                fontWeight: FontWeight.normal,
                fontSize: 16,
                height: 1.5,
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
