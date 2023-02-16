import 'package:flutter/material.dart';

import 'equal_details_currency.dart';
import 'equal_details_pln.dart';

class EqualCalc extends StatefulWidget {
  final String resultPLN;
  final String resultCurrency;
  final String interestPLN;
  final String interestCurrency;
  final String plnEqualsCurrency;
  final String percentRateIncrease;
  final String dropdownSymbol;

  final List<double> creditAmountPlnDetails;
  final List<double> interestPartPlnDetails;
  final List<double> capitalPartPlnDetails;
  final List<double> capitalToBeRepaidPlnDetails;

  final List<double> creditAmountCurrencyDetails;
  final List<double> interestPartCurrencyDetails;
  final List<double> capitalPartCurrencyDetails;
  final List<double> capitalToBeRepaidCurrencyDetails;

  const EqualCalc({
    Key? key,
    required this.resultPLN,
    required this.resultCurrency,
    required this.interestPLN,
    required this.interestCurrency,
    required this.plnEqualsCurrency,
    required this.percentRateIncrease,
    required this.creditAmountPlnDetails,
    required this.creditAmountCurrencyDetails,
    required this.interestPartPlnDetails,
    required this.interestPartCurrencyDetails,
    required this.capitalPartPlnDetails,
    required this.capitalPartCurrencyDetails,
    required this.capitalToBeRepaidPlnDetails,
    required this.capitalToBeRepaidCurrencyDetails,
    required this.dropdownSymbol,
  }) : super(key: key);

  @override
  EqualCalcState createState() => EqualCalcState();
}

class EqualCalcState extends State<EqualCalc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0E1117),
      body: Container(
        margin: const EdgeInsets.only(top: 50.0, bottom: 50.0),
        child: ListView(
          padding: const EdgeInsets.all(32.0),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                enabled: false,
                labelText: "Rata kredytu w PLN",
                labelStyle: const TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                ),
                helperText: "",
                hintText: '${widget.resultPLN} zł',
                hintStyle: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),

            TextFormField(
              decoration: InputDecoration(
                enabled: false,
                labelText: "Rata kredytu w walucie",
                labelStyle: const TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                ),
                helperText: "",
                hintText: '${widget.resultCurrency} ${widget.dropdownSymbol}',
                hintStyle: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),

            TextFormField(
              decoration: InputDecoration(
                enabled: false,
                labelText: "Suma odsetek dla kredytu w PLN",
                labelStyle: const TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                ),
                helperText: "",
                hintText: '${widget.interestPLN} zł',
                hintStyle: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),

            TextFormField(
              decoration: InputDecoration(
                enabled: false,
                labelText: "Suma odsetek dla kredytu w walucie",
                labelStyle: const TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                ),
                helperText: "",
                hintText: '${widget.interestCurrency} ${widget.dropdownSymbol}',
                hintStyle: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),

            TextFormField(
              decoration: InputDecoration(
                enabled: false,
                labelText: "Rata w walucie = rata PLN, jeśli kurs sprzedaży =",
                labelStyle: const TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                ),
                helperText: "",
                hintText: '${widget.plnEqualsCurrency} zł',
                hintStyle: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),

            double.parse(widget.percentRateIncrease).toDouble() < 0 ?
            TextFormField(
              decoration: InputDecoration(
                enabled: false,
                label: RichText(
                  text: const TextSpan(
                    text: "Rata w walucie = rata PLN, jeśli kurs ",
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: "spadnie ",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.red,
                        ),
                      ),
                      TextSpan(
                        text: "o",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                helperText: "",
                hintText: '${widget.percentRateIncrease} %',
                hintStyle: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ) :
            TextFormField(
              decoration: InputDecoration(
                enabled: false,
                label: RichText(
                  text: const TextSpan(
                    text: "Rata w walucie = rata PLN, jeśli kurs ",
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: "wzrośnie ",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.green,
                        ),
                      ),
                      TextSpan(
                        text: "o",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                helperText: "",
                hintText: '${widget.percentRateIncrease} %',
                hintStyle: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),

            // Loan In PLN Details Button
            Center(
              child: Container(
                width: 320,
                height: 50,
                decoration: const ShapeDecoration(
                  shape: StadiumBorder(),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xff4338CA), Color(0xff6D28D9)],
                  ),
                ),
                child: MaterialButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: const StadiumBorder(),
                  child: const Text(
                    'Pokaż szczegóły (kredyt w PLN)',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EqualDetailsPLN(
                          resultPLN: widget.resultPLN,
                          creditAmountPlnDetails: widget.creditAmountPlnDetails,
                          interestPartPlnDetails: widget.interestPartPlnDetails,
                          capitalPartPlnDetails: widget.capitalPartPlnDetails,
                          capitalToBeRepaidPlnDetails: widget.capitalToBeRepaidPlnDetails,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Loan In Currency Details Button
            Center(
              child: Container(
                width: 320,
                height: 50,
                decoration: const ShapeDecoration(
                  shape: StadiumBorder(),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xff4338CA), Color(0xff6D28D9)],
                  ),
                ),
                child: MaterialButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: const StadiumBorder(),
                  child: const Text(
                    'Pokaż szczegóły (kredyt w walucie)',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EqualDetailsCurrency(
                          resultCurrency: widget.resultCurrency,
                          symbolValue: widget.dropdownSymbol,
                          creditAmountCurrencyDetails: widget.creditAmountCurrencyDetails,
                          interestPartCurrencyDetails: widget.interestPartCurrencyDetails,
                          capitalPartCurrencyDetails: widget.capitalPartCurrencyDetails,
                          capitalToBeRepaidCurrencyDetails: widget.capitalToBeRepaidCurrencyDetails,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ].map((child) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: child,
          ),
          ).toList(),
        ),
      ),
    );
  }
}
