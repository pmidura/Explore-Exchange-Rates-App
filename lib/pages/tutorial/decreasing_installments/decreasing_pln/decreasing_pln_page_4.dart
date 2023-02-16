import 'package:flutter/material.dart';

class DecreasingPLNPage4 extends StatelessWidget {
  const DecreasingPLNPage4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0E1117),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Obliczanie wysokości pierwszej raty",
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
                image: AssetImage("assets/decreasing_pln_images/step_3.PNG"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Text(
              "Aby obliczyć wysokość pierwszej raty należy skorzystać z poznanego wcześniej wzoru.\n\n"
              "(Kwota kredytu wiersza pierwszego / (zablokowana komórka Okres kredytowania(n) - Rata nr wiersza pierwszego)) "
              "+ (zablokowana komórka Oprocentowanie kredytu(r) / 12) * Kwota kredytu wiersza pierwszego",
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
