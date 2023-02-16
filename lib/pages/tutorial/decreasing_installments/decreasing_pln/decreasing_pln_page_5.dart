import 'package:flutter/material.dart';

class DecreasingPLNPage5 extends StatelessWidget {
  const DecreasingPLNPage5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0E1117),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Obliczanie części odsetkowej - Excel",
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
              "Cz. Odsetk. = Rata - Cz. Kapit.\n"
              "Rata nr 0 - Cz. Odsetk. = 1 083,33 zł - 833,33 zł = 250,00 zł",
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
