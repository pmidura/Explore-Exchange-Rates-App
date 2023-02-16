import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/bid_ask_model.dart';
import '../../network/network_helper.dart';
import '../../validators/string_extensions.dart';

import 'decreasing_installments/decreasing_calc.dart';
import 'equal_installments/equal_calc.dart';

class CurrencyLoanPage extends StatefulWidget {
  const CurrencyLoanPage({Key? key}) : super(key: key);

  @override
  State<CurrencyLoanPage> createState() => _CurrencyLoanPageState();
}

class _CurrencyLoanPageState extends State<CurrencyLoanPage> {
  final _formKey = GlobalKey<FormState>();
  final NetworkHelper _networkHelper = NetworkHelper();
  bool loading = true;

  String dropdownInstallmentValue = 'Równe';
  String dropdownCurrencyValue = 'EUR';
  String dropdownSymbolValue = '';

  List<BidAskModel> bidAskList = [];
  List<String> currenciesList = ['EUR', 'CHF', 'USD'];
  List<String> installmentsList = ['Równe', 'Malejące'];

  TextEditingController loanAmount = TextEditingController();
  TextEditingController loanYearPeriod = TextEditingController();
  TextEditingController loanInterestInPLN = TextEditingController();
  TextEditingController loanInterestInSelectedCurrency = TextEditingController();

  // Raty równe
  String _resultPLN = "";
  String _resultCurrency = "";
  String _interestPLN = "";
  String _interestCurrency = "";
  String _plnEqualsCurrency = "";
  String _percentRateIncrease = "";

  List<double> listOfCreditAmountPLN = [];
  List<double> listOfCreditAmountCurrency = [];
  List<double> listOfInterestPartPLN = [];
  List<double> listOfInterestPartCurrency = [];
  List<double> listOfCapitalPartPLN = [];
  List<double> listOfCapitalPartCurrency = [];
  List<double> listOfCapitalToBeRepaidPLN = [];
  List<double> listOfCapitalToBeRepaidCurrency = [];

  // Raty malejące
  String _firstInstallmentPLN = "";
  String _secondInstallmentPLN = "";
  String _differencePLN = "";
  String _firstInstallmentCurrency = "";
  String _secondInstallmentCurrency = "";
  String _differenceCurrency = "";

  List<double> listOfInstallmentsPLN = [];
  List<double> listOfInstallmentsCurrency = [];

  @override
  void initState() {
    super.initState();
    getBidAskPrice(dropdownCurrencyValue);
  }

  void getBidAskPrice(String selectedCurrency) async {
    var response = await _networkHelper.get(
        "https://api.nbp.pl/api/exchangerates/rates/c/$dropdownCurrencyValue?format=json");

    List<BidAskModel> bidAskData = (json.decode(response.body)['rates'] as List)
        .map((e) => BidAskModel.fromJson(e)).toList();

    if (mounted) {
      setState(() {
        bidAskList = bidAskData;
        loading = false;
      });
    }
  }

  void calculateLoan() {
    listOfCreditAmountPLN.clear();
    listOfCreditAmountCurrency.clear();
    listOfInterestPartPLN.clear();
    listOfInterestPartCurrency.clear();
    listOfCapitalPartPLN.clear();
    listOfCapitalPartCurrency.clear();
    listOfCapitalToBeRepaidPLN.clear();
    listOfCapitalToBeRepaidCurrency.clear();
    listOfInstallmentsPLN.clear();
    listOfInstallmentsCurrency.clear();

    if (dropdownCurrencyValue == 'EUR') {
      dropdownSymbolValue = '€';
    }
    else if (dropdownCurrencyValue == 'CHF') {
      dropdownSymbolValue = '₣';
    }
    else if (dropdownCurrencyValue == 'USD') {
      dropdownSymbolValue = '\$';
    }

    int N = int.parse(loanAmount.text); // Kwota kredytu
    double r = double.parse(loanInterestInPLN.text) / 100; // Oprocentowanie kredytu w PLN
    double rCurrency = double.parse(loanInterestInSelectedCurrency.text) / 100; // Oprocentowanie kredytu w walucie
    int k = 12; // Liczba rat w ciągu roku
    int n = int.parse(loanYearPeriod.text) * k; // Liczba rat kredytu (okres kredytowania)

    double rk = r / k;
    double rCurrencyk = rCurrency / k;
    num rkn = pow((1 + rk), n);
    num rCurrencykn = pow((1 + rCurrencyk), n);

    if (dropdownInstallmentValue == 'Równe') {
      // Rata kredytu w PLN
      double loanInstallmentPLN = N * ((rk * rkn) / ((rkn) - 1));
      _resultPLN = loanInstallmentPLN.toStringAsFixed(2);

      // Rata kredytu w walucie
      double loanInCurrency = (N / bidAskList.first.bid); // * bidAskList.first.ask;
      double installmentCurrency = loanInCurrency * ((rCurrencyk * rCurrencykn) / ((rCurrencykn) - 1));
      // double installmentCurrencyPLN = installmentCurrency * bidAskList.first.ask;
      // print(installmentCurrencyPLN.toStringAsFixed(2));
      _resultCurrency = installmentCurrency.toStringAsFixed(2);

      // Suma odsetek dla kredytu w PLN
      listOfCreditAmountPLN.insert(0, N.toDouble()); // Lista kwot kredytu w PLN
      listOfInterestPartPLN.insert(0, rk * listOfCreditAmountPLN[0]); // Lista części odsetkowej kredytu w PLN
      listOfCapitalPartPLN.insert(0, loanInstallmentPLN - listOfInterestPartPLN[0]); // Lista części kapitałowej kredytu w PLN
      listOfCapitalToBeRepaidPLN.insert(0, listOfCreditAmountPLN[0] - listOfCapitalPartPLN[0]); // Lista kapitału pozostałego do spłaty
      for (int i = 1; i < n; i++) {
        listOfCreditAmountPLN.insert(i, listOfCapitalToBeRepaidPLN[i - 1]);
        listOfInterestPartPLN.insert(i, rk * listOfCreditAmountPLN[i]);
        listOfCapitalPartPLN.insert(i, loanInstallmentPLN - listOfInterestPartPLN[i]);
        listOfCapitalToBeRepaidPLN.insert(i, listOfCreditAmountPLN[i] - listOfCapitalPartPLN[i]);
      }
      var sumOfInterestPartPLN = listOfInterestPartPLN.reduce((value, element) => value + element);
      _interestPLN = sumOfInterestPartPLN.toStringAsFixed(2);

      // Suma odsetek dla kredytu w walucie
      listOfCreditAmountCurrency.insert(0, loanInCurrency); // Lista kwot kredytu w walucie
      listOfInterestPartCurrency.insert(0, rCurrencyk * listOfCreditAmountCurrency[0]); // Lista części odsetkowej kredytu w walucie
      listOfCapitalPartCurrency.insert(0, installmentCurrency - listOfInterestPartCurrency[0]); // Lista części kapitałowej kredytu w walucie
      listOfCapitalToBeRepaidCurrency.insert(0, listOfCreditAmountCurrency[0] - listOfCapitalPartCurrency[0]); // Lista kapitału pozostałego do spłaty
      for (int i = 1; i < n; i++) {
        listOfCreditAmountCurrency.insert(i, listOfCapitalToBeRepaidCurrency[i - 1]);
        listOfInterestPartCurrency.insert(i, rCurrencyk * listOfCreditAmountCurrency[i]);
        listOfCapitalPartCurrency.insert(i, installmentCurrency - listOfInterestPartCurrency[i]);
        listOfCapitalToBeRepaidCurrency.insert(i, listOfCreditAmountCurrency[i] - listOfCapitalPartCurrency[i]);
      }
      var sumOfInterestPartCurrency = listOfInterestPartCurrency.reduce((value, element) => value + element);
      _interestCurrency = sumOfInterestPartCurrency.toStringAsFixed(2);

      // Wysokość kursu, przy którym wysokość raty w PLN zrówna się z ratą w walucie
      double plnEqualsCurrency = (loanInstallmentPLN / installmentCurrency);
      _plnEqualsCurrency = plnEqualsCurrency.toStringAsFixed(4);

      // O ile % musi wzrosnąć kurs, aby zrównały się raty w PLN i w walucie
      double rateIncrease = ((plnEqualsCurrency * 100) / bidAskList.first.ask) - 100;
      _percentRateIncrease = rateIncrease.toStringAsFixed(2);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EqualCalc(
            resultPLN: _resultPLN,
            resultCurrency: _resultCurrency,
            interestPLN: _interestPLN,
            interestCurrency: _interestCurrency,
            plnEqualsCurrency: _plnEqualsCurrency,
            percentRateIncrease: _percentRateIncrease,
            creditAmountPlnDetails: listOfCreditAmountPLN,
            creditAmountCurrencyDetails: listOfCreditAmountCurrency,
            interestPartPlnDetails: listOfInterestPartPLN,
            interestPartCurrencyDetails: listOfInterestPartCurrency,
            capitalPartPlnDetails: listOfCapitalPartPLN,
            capitalPartCurrencyDetails: listOfCapitalPartCurrency,
            capitalToBeRepaidPlnDetails: listOfCapitalToBeRepaidPLN,
            capitalToBeRepaidCurrencyDetails: listOfCapitalToBeRepaidCurrency,
            dropdownSymbol: dropdownSymbolValue,
          ),
        ),
      );
    }
    else {
      listOfCreditAmountPLN.insert(0, N.toDouble()); // Lista kwot kredytu w PLN
      listOfInstallmentsPLN.insert(0, (N / n) * (1 + (n - 1 + 1) * rk)); // Lista rat kredytu w PLN
      double capitalPartPLN = (N / n); // Część kapitałowa kredytu w PLN
      listOfInterestPartPLN.insert(0, (listOfInstallmentsPLN[0] - capitalPartPLN)); // Lista części odsetkowej kredytu w PLN
      listOfCapitalToBeRepaidPLN.insert(0, (listOfCreditAmountPLN[0] - capitalPartPLN)); // Lista kapitału pozostałego do spłaty

      // Pierwsza rata kredytu w PLN
      _firstInstallmentPLN = listOfInstallmentsPLN[0].toStringAsFixed(2);

      for (int i = 1; i < n; i++) {
        listOfCreditAmountPLN.insert(i, listOfCapitalToBeRepaidPLN[i - 1]);
        listOfInstallmentsPLN.insert(i, (N / n) * (1 + (n - (i + 1) + 1) * rk));
        listOfInterestPartPLN.insert(i, (listOfInstallmentsPLN[i] - capitalPartPLN));
        listOfCapitalToBeRepaidPLN.insert(i, (listOfCreditAmountPLN[i]) - capitalPartPLN);
      }

      // Druga rata kredytu w PLN
      _secondInstallmentPLN = listOfInstallmentsPLN[1].toStringAsFixed(2);

      // O ile jest mniejsza każda kolejna rata kredytu w PLN od poprzedniej
      _differencePLN = (listOfInstallmentsPLN[0] - listOfInstallmentsPLN[1]).toStringAsFixed(2);

      // Suma odsetek dla kredytu w PLN
      var sumOfInterestPartPLN = listOfInterestPartPLN.reduce((value, element) => value + element);
      _interestPLN = sumOfInterestPartPLN.toStringAsFixed(2);

      listOfCreditAmountCurrency.insert(0, (N.toDouble() / bidAskList.first.bid)); // Lista kwot kredytu w walucie
      listOfInstallmentsCurrency.insert(0, ((N / bidAskList.first.bid) / n) * (1 + (n - 1 + 1) * rCurrencyk)); // Lista rat kredytu w walucie
      double capitalPartCurrency = (listOfCreditAmountCurrency[0] / n); // Część kapitałowa kredytu w walucie
      listOfInterestPartCurrency.insert(0, (listOfInstallmentsCurrency[0] - capitalPartCurrency)); // Lista części odsetkowej kredytu w walucie
      listOfCapitalToBeRepaidCurrency.insert(0, (listOfCreditAmountCurrency[0] - capitalPartCurrency)); // Lista kapitału pozostałego do spłaty

      // Pierwsza rata kredytu w walucie
      _firstInstallmentCurrency = listOfInstallmentsCurrency[0].toStringAsFixed(2);

      for (int i = 1; i < n; i++) {
        listOfCreditAmountCurrency.insert(i, listOfCapitalToBeRepaidCurrency[i - 1]);
        listOfInstallmentsCurrency.insert(i, ((N / bidAskList.first.bid) / n) * (1 + (n - (i + 1) + 1) * rCurrencyk));
        listOfInterestPartCurrency.insert(i, (listOfInstallmentsCurrency[i] - capitalPartCurrency));
        listOfCapitalToBeRepaidCurrency.insert(i, (listOfCreditAmountCurrency[i]) - capitalPartCurrency);
      }

      // Druga rata kredytu w walucie
      _secondInstallmentCurrency = listOfInstallmentsCurrency[1].toStringAsFixed(2);

      // O ile jest mniejsza każda kolejna rata kredytu w walucie od poprzedniej
      _differenceCurrency = ((listOfInstallmentsCurrency[0] - listOfInstallmentsCurrency[1])).toStringAsFixed(2);

      // Suma odsetek dla kredytu w walucie
      var sumOfInterestPartCurrency = listOfInterestPartCurrency.reduce((value, element) => value + element);
      _interestCurrency = sumOfInterestPartCurrency.toStringAsFixed(2);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DecreasingCalc(
            firstInstallmentPLN: _firstInstallmentPLN,
            secondInstallmentPLN: _secondInstallmentPLN,
            differencePLN: _differencePLN,
            firstInstallmentCurrency: _firstInstallmentCurrency,
            secondInstallmentCurrency: _secondInstallmentCurrency,
            differenceCurrency: _differenceCurrency,
            interestPLN: _interestPLN,
            interestCurrency: _interestCurrency,
            creditAmountPlnDetails: listOfCreditAmountPLN,
            installmentsPlnDetails: listOfInstallmentsPLN,
            interestPartPlnDetails: listOfInterestPartPLN,
            capitalPlnDetails: capitalPartPLN.toStringAsFixed(2),
            capitalToBeRepaidPlnDetails: listOfCapitalToBeRepaidPLN,
            creditAmountCurrencyDetails: listOfCreditAmountCurrency,
            installmentsCurrencyDetails: listOfInstallmentsCurrency,
            interestPartCurrencyDetails: listOfInterestPartCurrency,
            capitalCurrencyDetails: capitalPartCurrency.toStringAsFixed(2),
            capitalToBeRepaidCurrencyDetails: listOfCapitalToBeRepaidCurrency,
            dropdownSymbol: dropdownSymbolValue,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xff0E1117),
        body: Container(
          margin: const EdgeInsets.only(top: 50.0, bottom: 50.0),
          child: Form(
            key: _formKey,
            child: ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.all(32.0),
              children: <Widget>[
                // CreditAmountField
                TextFormField(
                  controller: loanAmount,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (s) {
                    if (s!.isWhitespace()) {
                      return "To pole jest wymagane!";
                    }
                    else if (int.parse(s).toInt() <= 0) {
                      return "Kwota kredytu musi być większa niż 0!";
                    }
                    return null;
                  },
                  maxLength: 10,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  decoration: const InputDecoration(
                    labelText: "Kwota kredytu",
                    helperText: "",
                    hintText: "",
                    suffix: Text("zł"),
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),

                // CreditDurationField
                TextFormField(
                  controller: loanYearPeriod,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (s) {
                    if (s!.isWhitespace()) {
                      return "To pole jest wymagane!";
                    }
                    else if (int.parse(s).toInt() <= 0) {
                      return "Okres (w latach) musi być większy niż 0!";
                    }
                    return null;
                  },
                  maxLength: 2,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  decoration: const InputDecoration(
                    labelText: "Okres (w latach)",
                    helperText: "",
                    hintText: "",
                    suffix: Text("lat"),
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),

                // InstallmentsTypeField
                DropdownButtonFormField(
                  decoration: const InputDecoration(
                    labelText: "Rodzaj rat",
                    helperText: "",
                    hintText: "",
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  value: dropdownInstallmentValue,
                  dropdownColor: const Color(0xff0E1117),
                  onChanged: (String? newValue) {
                    if (mounted) {
                      setState(() {
                        dropdownInstallmentValue = newValue!;
                      });
                    }
                  },
                  items: installmentsList.map<DropdownMenuItem<String>>((String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                    ),
                  )).toList(),
                ),

                // InterestLoanRateInPLNField
                TextFormField(
                  controller: loanInterestInPLN,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
                  validator: (s) {
                    if (s!.isWhitespace()) {
                      return "To pole jest wymagane!";
                    }
                    else if (!s.isValidDouble()) {
                      return "Niepoprawny format liczby!";
                    }
                    else if (double.parse(s).toDouble() <= 0.0) {
                      return "Oprocentowanie musi być większe niż 0,00%!";
                    }
                    return null;
                  },
                  maxLength: 5,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  decoration: const InputDecoration(
                    labelText: "Oprocentowanie kredytu w PLN",
                    helperText: "",
                    hintText: "",
                    suffix: Text("%"),
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),

                // CurrencyField
                DropdownButtonFormField(
                  decoration: const InputDecoration(
                    labelText: "Waluta",
                    helperText: "",
                    hintText: "",
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  value: dropdownCurrencyValue,
                  dropdownColor: const Color(0xff0E1117),
                  onChanged: (String? newValue) {
                    if (mounted) {
                      setState(() {
                        loading = true;
                        dropdownCurrencyValue = newValue!;
                        getBidAskPrice(dropdownCurrencyValue);
                      });
                    }
                  },
                  items: currenciesList.map<DropdownMenuItem<String>>((String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                    ),
                  )).toList(),
                ),

                // InterestLoanRateInSelectedCurrencyField
                TextFormField(
                  controller: loanInterestInSelectedCurrency,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
                  validator: (s) {
                    if (s!.isWhitespace()) {
                      return "To pole jest wymagane!";
                    }
                    else if (!s.isValidDouble()) {
                      return "Niepoprawny format liczby!";
                    }
                    else if (double.parse(s).toDouble() <= 0.0) {
                      return "Oprocentowanie musi być większe niż 0,00%!";
                    }
                    return null;
                  },
                  maxLength: 5,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  decoration: const InputDecoration(
                    labelText: "Oprocentowanie kredytu w wybranej walucie",
                    helperText: "",
                    hintText: "",
                    suffix: Text("%"),
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),

                // AVGBuyingRateOfGivenCurrencyField
                loading ?
                const LinearProgressIndicator(
                  backgroundColor: Color(0xff4338CA),
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xff6D28D9)),
                ) :
                TextFormField(
                  decoration: InputDecoration(
                    enabled: false,
                    labelText: "Średni kurs kupna danej waluty",
                    helperText: "",
                    hintText: '${bidAskList.first.bid} zł',
                    hintStyle: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),

                // AVGSellingRateOfGivenCurrencyField
                loading ?
                const LinearProgressIndicator(
                  backgroundColor: Color(0xff4338CA),
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xff6D28D9)),
                ) :
                TextFormField(
                  decoration: InputDecoration(
                    enabled: false,
                    labelText: "Średni kurs sprzedaży danej waluty",
                    helperText: "",
                    hintText: '${bidAskList.first.ask} zł',
                    hintStyle: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),

                // Submit Button
                Center(
                  child: Container(
                    width: 200,
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
                        'Oblicz',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        final isValid = _formKey.currentState!.validate();
                        if (isValid == true) {
                          calculateLoan();
                        }
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
        ),
      ),
    );
  }
}
