import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../provider/google_sign_in.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff4338CA), Color(0xff6D28D9)],
          ),
        ),
        child: Center(
          child: Stack(
            children: [
              Positioned(
                bottom: 350,
                left: 0,
                right: 0,
                child: Column(
                  children: const [
                    Icon(
                      Icons.currency_exchange,
                      size: 100,
                      color: Colors.white,
                    ),
                    SizedBox(height: 30),
                    // Text(
                    //   'Hey There, Welcome Back!',
                    //   style: TextStyle(
                    //     fontSize: 20,
                    //     color: Colors.white,
                    //   ),
                    // ),
                  ],
                ),
              ),
              Positioned(
                bottom: 100,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                    ),
                    icon: const FaIcon(FontAwesomeIcons.google, color: Colors.red),
                    label: const Text(
                      'Zaloguj się przez Google',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onPressed: () {
                      final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                      provider.googleLogin();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
