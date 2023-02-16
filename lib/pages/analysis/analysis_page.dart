import 'dart:async';
import 'dart:convert';

import 'package:engineer_final/pages/analysis/data/analysis_currencies.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gradient_progress_indicator/widget/gradient_progress_indicator_widget.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import '../../models/mid_model.dart';
import '../../network/network_helper.dart';

class AnalysisPage extends StatefulWidget {
  const AnalysisPage({Key? key}) : super(key: key);

  @override
  State<AnalysisPage> createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {
  List analysisData = [];
  List daterange = [];
  List<MidModel> todayRateList = [];

  String predPercent = '';
  String currencyID = 'EUR';

  bool loadingChart = true;
  bool loadingCard = true;

  final tooltipDate = DateFormat('EEE, MMM d, yyyy', 'pl');
  final NetworkHelper _networkHelper = NetworkHelper();

  @override
  void initState() {
    buildNext30Days();
    calculatePredPercent();
    getPredictionsData();

    super.initState();
  }

  Future<List> getPredictionsData() async {
    List nestedListData = [];

    try {
      final Response response = await get(Uri.parse('http://10.0.2.2:5000/$currencyID')).timeout(const Duration(seconds: 1));

      nestedListData = json.decode(response.body);
      var flattenListData = nestedListData.expand((element) => element).toList();

      analysisData = flattenListData;
      loadingChart = false;
    }
    on TimeoutException catch (_) {
      throw Exception('Nie udało się pobrać danych!');
    }

    return nestedListData;
  }

  void calculatePredPercent() async {
    var response = await _networkHelper.get(
      "https://api.nbp.pl/api/exchangerates/rates/a/$currencyID?format=json");

    List<MidModel> tempData = (json.decode(response.body)['rates'] as List).map((e) => MidModel.fromJson(e)).toList();

    if (mounted && analysisData.isNotEmpty) {
      setState(() => todayRateList = tempData);

      double firstCalc = (analysisData.last * 100) / todayRateList.first.mid;
      double finalResult = firstCalc - 100;

      if (finalResult > 0.0) {
        predPercent = '${'wzrosnąć o ${finalResult.toStringAsFixed(2)}'}%';
      }
      else {
        predPercent = '${'spaść o ${finalResult.toStringAsFixed(2)}'}%';
      }

      setState(() => loadingCard = false);
    }
  }

  void buildNext30Days() {
    DateTime startDate = DateTime.now().add(const Duration(days: 1));

    while (daterange.length < 30) {
      if (startDate.weekday == DateTime.saturday) {
        startDate = startDate.add(const Duration(days: 1));
      }
      else if (startDate.weekday == DateTime.sunday) {
        startDate = startDate.add(const Duration(days: 1));
      }
      else {
        daterange.add(DateFormat('yyyy-MM-dd').format(startDate));
        startDate = startDate.add(const Duration(days: 1));
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0E1117),
      body: FutureBuilder(
        future: getPredictionsData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                loadingChart ?
                const GradientProgressIndicator(
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
                Column(
                  children: <Widget>[
                    Text(
                      '$currencyID / PLN - Prognoza 30-dniowa',
                      style: TextStyle(
                        color: Colors.blueGrey.shade100,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 32.0),
                    Container(
                      color: Colors.transparent,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Card(
                        color: Colors.transparent,
                        elevation: 0,
                        child: LineChart(
                          LineChartData(
                            borderData: FlBorderData(
                              show: false,
                            ),
                            gridData: FlGridData(
                              show: false,
                            ),
                            titlesData: FlTitlesData(
                              show: false,
                            ),
                            lineTouchData: LineTouchData(
                              getTouchedSpotIndicator: (LineChartBarData barData, List<int> spotIndexes) {
                                return spotIndexes.map((index) {
                                  return TouchedSpotIndicatorData(
                                    FlLine(
                                      color: Colors.white.withOpacity(0.1),
                                      strokeWidth: 2,
                                      dashArray: [3, 3],
                                    ),
                                    FlDotData(
                                      show: true,
                                    ),
                                  );
                                }).toList();
                              },
                              enabled: true,
                              touchTooltipData: LineTouchTooltipData(
                                tooltipRoundedRadius: 8,
                                showOnTopOfTheChartBoxArea: true,
                                fitInsideHorizontally: true,
                                fitInsideVertically: true,
                                tooltipPadding: const EdgeInsets.all(8),
                                tooltipBgColor: const Color(0xff2e3747).withOpacity(0.8),
                                getTooltipItems: (touchedSpots) {
                                  return touchedSpots.map((touchedSpot) {
                                    return LineTooltipItem(
                                      '${tooltipDate.format(DateTime.parse(daterange[touchedSpot.x.toInt()]))}\n\nKurs: ',
                                      const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.0,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: touchedSpot.y.toStringAsFixed(4),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList();
                                },
                              ),
                              handleBuiltInTouches: true,
                            ),
                            lineBarsData: [
                              LineChartBarData(
                                spots: analysisData.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value)).toList(),
                                isCurved: true,
                                colors: [
                                  const Color(0xffe68823),
                                  const Color(0xffe68823),
                                ],
                                barWidth: 2,
                                dotData: FlDotData(
                                  show: false,
                                ),
                                belowBarData: BarAreaData(
                                  show: true,
                                  gradientFrom: const Offset(0, 0),
                                  gradientTo: const Offset(0, 1),
                                  colors: [
                                    const Color(0xffe68823).withOpacity(0.1),
                                    const Color(0xffe68823).withOpacity(0),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          swapAnimationCurve: Curves.easeInOutCubic,
                          swapAnimationDuration: const Duration(milliseconds: 1000),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(32.0),
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
                        child: loadingCard ? const GradientProgressIndicator(
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
                        predPercent.contains('wzrosnąć') ?
                        RichText(
                          text: TextSpan(
                            text: 'W ciągu następnych 30 dni kurs może ',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              height: 2,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: predPercent,
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  height: 2,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ) :
                        RichText(
                          text: TextSpan(
                            text: 'W ciągu następnych 30 dni kurs może ',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              height: 2,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: predPercent,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  height: 2,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 32.0, right: 32.0),
                  child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                      labelText: "Wybierz walutę",
                      helperText: "",
                      hintText: "",
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    value: currencyID,
                    dropdownColor: const Color(0xff0E1117),
                    onChanged: (String? newValue) {
                      if (mounted) {
                        setState(() {
                          loadingCard = true;
                          currencyID = newValue!;
                          getPredictionsData();
                          calculatePredPercent();
                        });
                      }
                    },
                    items: analysisCurrencies.map<DropdownMenuItem<String>>((String value) => DropdownMenuItem<String>(
                      value: value.substring(0, 3),
                      child: Text(
                        value,
                      ),
                    )).toList(),
                    selectedItemBuilder: (context) => analysisCurrencies.map((text) => Center(
                      child: Text(
                        text.substring(0, 3),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    )).toList(),
                  ),
                ),
              ],
            );
          }
          else if (snapshot.hasError) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: AssetImage("assets/analysis_images/analysis_error.png"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Przepraszamy, niestety w tym momencie analiza kursów walut nie jest dostępna!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      foreground: Paint()..color = Colors.white70,
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                      height: 2,
                    ),
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: GradientProgressIndicator(
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
            ),
          );
        },
      ),
    );
  }
}
