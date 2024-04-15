// This program was made By Abdullah AL-Kabbani in 2023 AD.
// Warehouse Management System

import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:final_whs/warehouse/warehouse.dart';
import 'package:flutter/material.dart';

import 'package:final_whs/log_in/FirstRoute.dart';
import 'package:final_whs/admin/admin.dart';
import 'package:final_whs/warehouse/display.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset('assets/WH splash.jpg'),
      logoWidth: 200,
      backgroundColor: const Color(0xFFFFFFFF),
      durationInSeconds: 3,
      navigator:   FirstRoute(),
      showLoader: true,
      loaderColor: Colors.purple,
      loadingText: const Text("Loading..."),
    );
  }
}
