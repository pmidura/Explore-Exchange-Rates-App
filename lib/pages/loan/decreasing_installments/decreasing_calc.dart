import 'package:flutter/material.dart';

import 'decreasing_details_currency.dart';
import 'decreasing_details_pln.dart';

class DecreasingCalc extends StatefulWidget {
  final String firstInstallmentPLN;
  final String secondInstallmentPLN;
  final String differencePLN;
  final String firstInstallmentCurrency;
  final String secondInstallmentCurrency;
  final String differenceCurrency;
  final String interestPLN;
  final String interestCurrency;
  final String dropdownSymbol;

  final List<double> creditAmountPlnDetails;
  final List<double> installmentsPlnDetails;
  final List<double> interestPartPlnDetails;
  final String capitalPlnDetails;
  final List<double> capitalToBeRepaidPlnDetails;

  final List<double> creditAmountCurrencyDetails;
  final List<double> installmentsCurrencyDetails;
  final List<double> interestPartCurrencyDetails;
  final String capitalCurrencyDetails;
  final List<double> capitalToBeRepaidCurrencyDetails;

  const DecreasingCalc({
    Key? key,
    required this.firstInstallmentPLN,
    required this.secondInstallmentPLN,
    required this.differencePLN,
    required this.firstInstallmentCurrency,
    required this.secondInstallmentCurrency,
    required this.differenceCurrency,
    required this.interestPLN,
    required this.interestCurrency,
    required this.creditAmountPlnDetails,
    required this.installmentsPlnDetails,
    required this.interestPartPlnDetails,
    required this.capitalPlnDetails,
    required this.capitalToBeRepaidPlnDetails,
    required this.creditAmountCurrencyDetails,
    required this.installmentsCurrencyDetails,
    required this.interestPartCurrencyDetails,
    required this.capitalCurrencyDetails,
    required this.capitalToBeRepaidCurrencyDetails,
    required this.dropdownSymbol,
  }) : super(key: key);

  @override
  DecreasingCalcState createState() => DecreasingCalcState();
}

class DecreasingCalcState extends State<DecreasingCalc> {
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
                labelText: "Pierwsza rata kredytu w PLN",
                labelStyle: const TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                ),
                helperText: "",
                hintText: '${widget.firstInstallmentPLN} zł',
                hintStyle: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),

            TextFormField(
              decoration: InputDecoration(
                enabled: false,
                labelText: "Druga rata kredytu w PLN",
                labelStyle: const TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                ),
                helperText: "",
                hintText: '${widget.secondInstallmentPLN} zł',
                hintStyle: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),

            TextFormField(
              decoration: InputDecoration(
                enabled: false,
                labelText: "Każda kolejna rata kredytu w PLN jest mniejsza o",
                labelStyle: const TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                ),
                helperText: "",
                hintText: '${widget.differencePLN} zł',
                hintStyle: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),

            TextFormField(
              decoration: InputDecoration(
                enabled: false,
                labelText: "Pierwsza rata kredytu w walucie",
                labelStyle: const TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                ),
                helperText: "",
                hintText: '${widget.firstInstallmentCurrency} ${widget.dropdownSymbol}',
                hintStyle: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),

            TextFormField(
              decoration: InputDecoration(
                enabled: false,
                labelText: "Druga rata kredytu w walucie",
                labelStyle: const TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                ),
                helperText: "",
                hintText: '${widget.secondInstallmentCurrency} ${widget.dropdownSymbol}',
                hintStyle: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),

            TextFormField(
              decoration: InputDecoration(
                enabled: false,
                labelText: "Każda kolejna rata kredytu w walucie jest mniejsza o",
                labelStyle: const TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                ),
                helperText: "",
                hintText: '${widget.differenceCurrency} ${widget.dropdownSymbol}',
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
                        builder: (context) => DecreasingDetailsPLN(
                          creditAmountPlnDetails: widget.creditAmountPlnDetails,
                          installmentsPlnDetails: widget.installmentsPlnDetails,
                          interestPartPlnDetails: widget.interestPartPlnDetails,
                          capitalPlnDetails: widget.capitalPlnDetails,
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
                        builder: (context) => DecreasingDetailsCurrency(
                          creditAmountCurrencyDetails: widget.creditAmountCurrencyDetails,
                          installmentsCurrencyDetails: widget.installmentsCurrencyDetails,
                          interestPartCurrencyDetails: widget.interestPartCurrencyDetails,
                          capitalCurrencyDetails: widget.capitalCurrencyDetails,
                          symbolValue: widget.dropdownSymbol,
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
