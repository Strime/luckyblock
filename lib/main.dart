import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lucky/src/data/bsc_client.dart';
import 'package:lucky/src/data/pcs_client.dart';
import 'package:lucky/src/view/home/home_controller.dart';
import 'package:lucky/src/view/home/home_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dio = Dio();

  final bscClient = BscRestClient(dio);
  final pcsClient = PcsRestClient(dio);
  final pref = await SharedPreferences.getInstance();

  final homeController =
      HomeController(HomeService(bscClient, pcsClient, pref));
  await homeController.loadInfos();

  runApp(MyApp(homeController: homeController));
}
