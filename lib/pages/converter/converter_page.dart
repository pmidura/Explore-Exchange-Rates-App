import 'dart:convert';
import 'dart:math' as math;

import 'package:engineer_final/pages/converter/data/converter_currencies.dart';
import 'package:engineer_final/validators/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradient_progress_indicator/widget/gradient_progress_indicator_widget.dart';

import '../../models/mid_model.dart';
import '../../network/network_helper.dart';

class ConverterPage extends StatefulWidget {
  const ConverterPage({Key? key}) : super(key: key);

  @override
  State<ConverterPage> createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  @override
  void initState() {
    getRatesFromApi();
    super.initState();
  }

  String convertFromValue = 'EUR';
  String convertToValue = 'PLN';
  String amount = '1';
  double selectedPrice = 0.00;

  TextEditingController convertAmount = TextEditingController(text: '1');

  List<MidModel> currencyData = [];
  List<MidModel> currencyData2 = [];
  final NetworkHelper _networkHelper = NetworkHelper();

  bool loading = true;

  void getRatesFromApi() async {
    selectedPrice = 0.00;

    if (convertFromValue == 'PLN' && convertToValue == 'PLN') {
      if (mounted) {
        setState(() {
          if (selectedPrice == 0.00) {
            String tempAmount = '1';
            selectedPrice = double.parse(tempAmount);
          }
          else {
            selectedPrice = double.parse(amount);
          }
        });
      }
    }
    else {
      var responseFrom = await _networkHelper.get(
          "https://api.nbp.pl/api/exchangerates/rates/a/$convertFromValue?format=json");
      var responseTo = await _networkHelper.get(
          "https://api.nbp.pl/api/exchangerates/rates/a/$convertToValue?format=json");

      if (convertFromValue != 'PLN' && convertToValue != 'PLN') {
        List<MidModel> tempDataFrom = (json.decode(responseFrom.body)['rates'] as List)
            .map((e) => MidModel.fromJson(e)).toList();
        List<MidModel> tempDataTo = (json.decode(responseTo.body)['rates'] as List)
            .map((e) => MidModel.fromJson(e)).toList();

        if (mounted) {
          setState(() {
            currencyData = tempDataFrom;
            currencyData2 = tempDataTo;
            selectedPrice = (currencyData.first.mid / currencyData2.first.mid);
          });
        }
      }
      else if (convertFromValue == 'PLN') {
        List<MidModel> tempData = (json.decode(responseTo.body)['rates'] as List)
            .map((e) => MidModel.fromJson(e)).toList();

        if (mounted) {
          setState(() {
            currencyData = tempData;
            if (selectedPrice == 0.00) {
              String tempAmount = '1';
              selectedPrice = (double.parse(tempAmount) / currencyData.first.mid);
            }
            else {
              selectedPrice = (double.parse(amount) / currencyData.first.mid);
            }
          });
        }
      }
      else if (convertFromValue != 'PLN') {
        List<MidModel> tempData = (json.decode(responseFrom.body)['rates'] as List)
            .map((e) => MidModel.fromJson(e)).toList();

        if (mounted) {
          setState(() {
            currencyData = tempData;
            selectedPrice = currencyData.first.mid;
          });
        }
      }
    }
    if (mounted) {
      setState(() => loading = false);
    }
  }

  void changeSelected(bool isFrom, String currency) {
    loading = true;
    if (isFrom && (convertFromValue != currency || convertFromValue == currency)) {
      convertFromValue = currency;
      getRatesFromApi();
    }
    else if (!isFrom && (convertToValue != currency || convertToValue == currency)) {
      convertToValue = currency;
      getRatesFromApi();
    }
  }

  void switchCurrencies() {
    loading = true;
    String convertFromValueTemp = convertFromValue;
    convertFromValue = convertToValue;
    convertToValue = convertFromValueTemp;
    getRatesFromApi();
  }

  void changeAmount(String value) {
    int index = amount.indexOf(',');
    if (value == '0' && amount == '0') {
    }
    else if (amount == '0' && value != ',' && mounted) {
      setState((){
        amount = value;
      });
    }
    else if (amount.isEmpty && value == ',' && mounted) {
      setState((){
        amount = '0,';
      });
    }
    else if (!amount.contains(',') && value == ',' && amount.isNotEmpty && mounted) {
      setState((){
        amount = '$amount$value';
      });
    }
    else if (value != '' && amount.contains(',') && amount.length - index < 3 && mounted) {
      setState((){
        amount = '$amount$value';
      });
    }
    else if (value != ',' && !amount.contains(',') && mounted) {
      setState((){
        amount = '$amount$value';
      });
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
          child: ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.all(32.0),
            children: <Widget>[
              // Calculation
              Center(
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  shadowColor: Colors.grey[600],
                  color: Colors.black54,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: loading ? const GradientProgressIndicator(
                        radius: 20,
                        duration: 1,
                        strokeWidth: 5,
                        gradientStops: [
                          0.2,
                          0.8,
                        ],
                        gradientColors: [
                          Color(0xff4338CA),
                          Color(0xff6D28D9),
                        ],
                        child: Text(''),
                      ) :
                      Text(
                        convertAmount.text.isEmpty
                        ? '0,00 $convertFromValue \n=\n 0,00 $convertToValue'
                        : '${(double.parse(convertAmount.text.replaceAll(',', '.')).toStringAsFixed(2)).replaceAll('.', ',')} $convertFromValue \n=\n ${(double.parse(convertAmount.text.replaceAll(',', '.')) * selectedPrice).toStringAsFixed(4).replaceAll('.', ',')} $convertToValue',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 50),

              // Convert From
              DropdownButtonFormField(
                decoration: const InputDecoration(
                  labelText: "Konwertuj z",
                  helperText: "",
                  hintText: "",
                ),
                style: const TextStyle(
                  color: Colors.white,
                ),
                value: convertFromValue,
                dropdownColor: const Color(0xff0E1117),
                onChanged: (String? newValue) {
                  if (mounted) {
                    setState(() {
                      convertFromValue = newValue!;
                      changeSelected(true, convertFromValue);
                    });
                  }
                },
                items: converterCurrencies.map<DropdownMenuItem<String>>((String value) => DropdownMenuItem<String>(
                  value: value.substring(0, 3),
                  child: Text(
                    value,
                  ),
                )).toList(),
                selectedItemBuilder: (context) => converterCurrencies.map((text) => Center(
                  child: Text(
                    text.substring(0, 3),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                )).toList(),
              ),

              // Switch Currencies
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green[900],
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                      ),
                      onPressed: () => switchCurrencies(),
                      icon: Transform.rotate(
                        angle: 90 * math.pi / 180,
                        child: const Icon(
                          Icons.compare_arrows,
                          size: 24.0,
                        ),
                      ),
                      label: const Text(
                        'Zamień waluty',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // Convert To
              DropdownButtonFormField(
                decoration: const InputDecoration(
                  labelText: "Konwertuj do",
                  helperText: "",
                  hintText: "",
                ),
                style: const TextStyle(
                  color: Colors.white,
                ),
                value: convertToValue,
                dropdownColor: const Color(0xff0E1117),
                onChanged: (String? newValue) {
                  if (mounted) {
                    setState(() {
                      convertToValue = newValue!;
                      changeSelected(false, convertToValue);
                    });
                  }
                },
                items: converterCurrencies.map<DropdownMenuItem<String>>((String value) => DropdownMenuItem<String>(
                  value: value.substring(0, 3),
                  child: Text(
                    value,
                  ),
                )).toList(),
                selectedItemBuilder: (context) => converterCurrencies.map((text) => Center(
                  child: Text(
                    text.substring(0, 3),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                )).toList(),
              ),

              const SizedBox(height: 5),

              // Amount Field
              TextFormField(
                onChanged: changeAmount,
                controller: convertAmount,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
                validator: (s) {
                  if (s!.isWhitespace()) {
                    return "To pole jest wymagane!";
                  }
                  else if (!s.isValidDouble()) {
                    return "Niepoprawny format liczby!";
                  }
                  return null;
                },
                maxLength: 10,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                decoration: const InputDecoration(
                  labelText: "Kwota",
                  helperText: "",
                  hintText: "",
                ),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
