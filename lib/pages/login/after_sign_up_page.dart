import 'package:engineer_final/pages/analysis/analysis_page.dart';
import 'package:engineer_final/pages/converter/converter_page.dart';
import 'package:engineer_final/pages/tutorial/tutorial_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

import '../../pages/exchange/exchange_page.dart';
import '../../pages/loan/currency_loan_page.dart';
import '../../provider/google_sign_in.dart';

class AfterSignUpPage extends StatefulWidget {
  const AfterSignUpPage({Key? key}) : super(key: key);

  @override
  State<AfterSignUpPage> createState() => _AfterSignUpPageState();
}

class _AfterSignUpPageState extends State<AfterSignUpPage> {
  late int _selectedIndex;

  @override
  void initState() {
    _selectedIndex = 0;
    super.initState();
  }

  final screen = [
    const Center(child: ExchangePage()),
    const Center(child: AnalysisPage()),
    const Center(child: ConverterPage()),
    const Center(child: CurrencyLoanPage()),
    const Center(child: TutorialPage()),
  ];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: screen[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff4338CA), Color(0xff6D28D9)],
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: GNav(
            color: Colors.grey,
            activeColor: Colors.white,
            gap: 8,
            padding: const EdgeInsets.all(10),
            tabs: [
              GButton(
                text: "Kursy",
                icon: Icons.stacked_line_chart_rounded,
                onPressed: () {
                  if (mounted) {
                    setState(() {
                      _selectedIndex = 0;
                    });
                  }
                },
              ),
              GButton(
                text: "Analiza",
                icon: Icons.search_rounded,
                onPressed: () {
                  if (mounted) {
                    setState(() {
                      _selectedIndex = 1;
                    });
                  }
                },
              ),
              GButton(
                text: "Konwerter",
                icon: Icons.compare_arrows_rounded,
                onPressed: () {
                  if (mounted) {
                    setState(() {
                      _selectedIndex = 2;
                    });
                  }
                },
              ),
              GButton(
                text: "Kredyt",
                icon: Icons.calculate_rounded,
                onPressed: () {
                  if (mounted) {
                    setState(() {
                      _selectedIndex = 3;
                    });
                  }
                },
              ),
              GButton(
                text: "Samouczek",
                icon: Icons.menu_book_rounded,
                onPressed: () {
                  if (mounted) {
                    setState(() {
                      _selectedIndex = 4;
                    });
                  }
                },
              ),
              GButton(
                icon: Icons.logout,
                onPressed: () {
                  final provider = Provider.of<GoogleSignInProvider>(
                    context,
                    listen: false,
                  );
                  provider.logout();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
