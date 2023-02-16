import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gradient_progress_indicator/gradient_progress_indicator.dart';
import 'package:intl/intl.dart';

import '../../models/bid_ask_model.dart';
import '../../models/mid_model.dart';
import '../../network/network_helper.dart';

class ExchangePage extends StatefulWidget {
  const ExchangePage({Key? key}) : super(key: key);

  @override
  State<ExchangePage> createState() => _ExchangePageState();
}

class _ExchangePageState extends State<ExchangePage> {
  List topTenCurrencies = ['EUR', 'USD', 'CHF', 'GBP', 'AUD', 'CAD', 'CZK', 'JPY', 'NOK', 'DKK'];
  List<BidAskModel> bidAskList = [];
  List<MidModel> midList = [];
  List<MidModel> moreThanYearList = [];

  String currencyID = 'EUR';
  bool loadingChart = true;
  bool loadingCurrencies = true;

  final df = DateFormat('dd/MM/yyyy');
  final tooltipDate = DateFormat('EEE, MMM d, yyyy', 'pl');
  final NetworkHelper _networkHelper = NetworkHelper();

  @override
  void initState() {
    super.initState();

    var todayOnStart = DateTime.now();
    getMidPrice(
      DateFormat('yyyy-MM-dd').format(DateTime(todayOnStart.year, todayOnStart.month, todayOnStart.day - 5)),
      DateFormat('yyyy-MM-dd').format(todayOnStart)
    );

    getBidAskPrice();
  }

  void getMidPrice(String startDate, String endDate) async {
    // Count days between dates
    DateTime firstDate = DateTime.parse(startDate);
    DateTime secondDate = DateTime.parse(endDate);
    Duration diff = secondDate.difference(firstDate);
    List daterange = [];

    if (diff.inDays > 367) {
      moreThanYearList.clear();

      while (firstDate.compareTo(secondDate) < 0) {
        daterange.add(DateFormat('yyyy-MM-dd').format(firstDate));
        firstDate = firstDate.add(const Duration(days: 367));
      }
      daterange.add(DateFormat('yyyy-MM-dd').format(secondDate));

      for (int x = 0; x < daterange.length - 1; x++) {
        // print('Connecting... $x time.');

        var response = await _networkHelper.get(
          "https://api.nbp.pl/api/exchangerates/rates/a/$currencyID/${daterange[x]}/${daterange[x + 1]}?format=json");

        List<MidModel> tempData = (json.decode(response.body)['rates'] as List).map((e) => MidModel.fromJson(e)).toList();
        moreThanYearList.addAll(tempData);
      }
      if (mounted) {
        setState(() => midList = moreThanYearList);
      }
    }
    else {
      var response = await _networkHelper.get(
        "https://api.nbp.pl/api/exchangerates/rates/a/$currencyID/$startDate/$endDate?format=json");

      List<MidModel> tempData = (json.decode(response.body)['rates'] as List).map((e) => MidModel.fromJson(e)).toList();

      if (mounted) {
        setState(() => midList = tempData);
      }
    }
    if (mounted) {
      setState(() => loadingChart = false);
    }
  }

  void getBidAskPrice() async {
    for (int i = 0; i < topTenCurrencies.length; i++) {
      var response = await _networkHelper.get(
        "https://api.nbp.pl/api/exchangerates/rates/c/${topTenCurrencies[i]}?format=json");

      List<BidAskModel> askData = (json.decode(response.body)['rates'] as List).map((e) => BidAskModel.fromJson(e)).toList();

      if (mounted) {
        setState(() => bidAskList.addAll(askData));
      }
    }
    if (mounted) {
      setState(() => loadingCurrencies = false);
    }
  }

  String currencySpread(double ask, double bid) {
    double spread = (ask - bid) / (0.5 * (ask + bid)) * 100;
    return spread.toStringAsFixed(4).toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0E1117),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 50),
          SizedBox(
            height: MediaQuery.of(context).size.height / 2.05,
            child: Column(
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
                      '$currencyID / PLN',
                      style: TextStyle(
                        color: Colors.blueGrey.shade100,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
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
                                      '${tooltipDate.format(midList[touchedSpot.x.toInt()].effectiveDate)}\n\nKurs: ',
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
                                spots: midList.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value.mid)).toList(),
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
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        selectTimeInterval(context, '5D', 'D5'),
                        selectTimeInterval(context, '1M', 'M1'),
                        selectTimeInterval(context, '3M', 'M3'),
                        selectTimeInterval(context, '1Y', 'Y1'),
                        selectTimeInterval(context, '5Y', 'Y5'),
                        selectTimeInterval(context, 'MAX', 'MAX'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              margin: const EdgeInsets.only(bottom: 50.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Column(
                children: <Widget>[
                  Center(
                    child: Text(
                      'top 10 kursów walut obcych'.toUpperCase(),
                      style: Theme.of(context).textTheme.caption?.copyWith(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  loadingCurrencies ?
                  const GradientProgressIndicator(
                    radius: 20,
                    duration: 1,
                    strokeWidth: 5,
                    gradientStops: [
                      0.2,
                      0.8,
                    ],
                    gradientColors: [
                      Color(0xff0E1117),
                      Colors.black54,
                    ],
                    child: Text(''),
                  ) :
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        BidAskModel prices = bidAskList[index];
                        final fromFlag = topTenCurrencies[index];
                        return GestureDetector(
                          onTap: () {
                            if (mounted) {
                              setState(() {
                                currencyID = topTenCurrencies[index];
                                selectedInterval = '5D';
                                var todayOnStart = DateTime.now();
                                getMidPrice(
                                  DateFormat('yyyy-MM-dd').format(DateTime(todayOnStart.year, todayOnStart.month, todayOnStart.day - 5)),
                                  DateFormat('yyyy-MM-dd').format(todayOnStart),
                                );
                              });
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(25),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black.withOpacity(0.05),
                              ),
                              color: Colors.black.withOpacity(0.05),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Center(
                                      child: Row(
                                        children: <Widget>[
                                          CircleAvatar(
                                            backgroundImage: AssetImage('assets/images/$fromFlag.png'),
                                            radius: 10,
                                          ),
                                          const SizedBox(width: 12),
                                          const CircleAvatar(
                                            backgroundImage: AssetImage('assets/images/PLN.png'),
                                            radius: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      topTenCurrencies[index] + ' - PLN',
                                      style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      ?.copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Kupno: ${prices.bid}',
                                      style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      ?.copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Sprzedaż: ${prices.ask}',
                                      style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      ?.copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Spread'.toUpperCase(),
                                      style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      ?.copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      '${currencySpread(prices.ask, prices.bid)} %',
                                      style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      ?.copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 10);
                      },
                      itemCount: bidAskList.length,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String selectedInterval = '5D';
  Widget selectTimeInterval(BuildContext context, String title, String interval) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              selectedInterval = title;
              var today = DateTime.now();
              String timeInterval = DateFormat('yyyy-MM-dd').format(today);

              if (title == '5D') {
                today = DateTime(today.year, today.month, today.day - 5);
                timeInterval = DateFormat('yyyy-MM-dd').format(today);
                getMidPrice(timeInterval, DateFormat('yyyy-MM-dd').format(DateTime.now()));
              }
              else if (title == '1M') {
                today = DateTime(today.year, today.month - 1, today.day);
                timeInterval = DateFormat('yyyy-MM-dd').format(today);
                getMidPrice(timeInterval, DateFormat('yyyy-MM-dd').format(DateTime.now()));
              }
              else if (title == '3M') {
                today = DateTime(today.year, today.month - 3, today.day);
                timeInterval = DateFormat('yyyy-MM-dd').format(today);
                getMidPrice(timeInterval, DateFormat('yyyy-MM-dd').format(DateTime.now()));
              }
              else if (title == '1Y') {
                today = DateTime(today.year - 1, today.month, today.day);
                timeInterval = DateFormat('yyyy-MM-dd').format(today);
                getMidPrice(timeInterval, DateFormat('yyyy-MM-dd').format(DateTime.now()));
              }
              else if (title == '5Y') {
                if (mounted) {
                  setState(() => loadingChart = true);
                }
                today = DateTime(today.year - 5, today.month, today.day);
                timeInterval = DateFormat('yyyy-MM-dd').format(today);
                getMidPrice(timeInterval, DateFormat('yyyy-MM-dd').format(DateTime.now()));
              }
              else if (title == 'MAX') {
                if (mounted) {
                  setState(() => loadingChart = true);
                }
                today = DateTime(2002, 1, 2);
                timeInterval = DateFormat('yyyy-MM-dd').format(today);
                getMidPrice(timeInterval, DateFormat('yyyy-MM-dd').format(DateTime.now()));
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: (selectedInterval == title)
                ? const Color(0xff161b22)
                : const Color(0xff161b22).withOpacity(0.0),
              ),
              child: Text(
                title,
                style: TextStyle(
                  color: (selectedInterval == title)
                  ? Colors.blueGrey.shade200
                  : Colors.blueGrey,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
