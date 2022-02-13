import 'package:flutter/material.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

import 'home_service.dart';

class TokenModel {
  double token;
  PriceValueModel price;

  TokenModel({required this.token, required this.price});

  String getDollarValue() =>
      MoneyFormatter(amount: token * price.price).output.compactSymbolOnRight;

  String getBnbValue() => MoneyFormatter(
      amount: token * price.bnbPrice,
      settings: MoneyFormatterSettings(
        symbol: "BNB",
      )).output.symbolOnRight;
}

class PriceValueModel {
  double price;
  double bnbPrice;
  PriceValueModel({required this.price, required this.bnbPrice});
}

class HomeController with ChangeNotifier {
  HomeController(this._homeService)
      : holdingController = TextEditingController(
            text: _homeService.getUserBlocks().toString());

  var lotteryDate = DateTime.parse("2022-03-22 19:00:00Z");
  static const totalSupply = 100000000000;

  final HomeService _homeService;

  String get currentJackpot =>
      isDollar ? _lotteryValue.getDollarValue() : _lotteryValue.getBnbValue();
  String get currentRoyalties => isDollar
      ? _royaltiesToken.getDollarValue()
      : _royaltiesToken.getBnbValue();

  String get userValue {
    if (_ownerToken == null) {
      return "";
    }
    return isDollar
        ? _ownerToken!.getDollarValue()
        : _ownerToken!.getBnbValue();
  }

  String get loadedTime {
    final formatter = DateFormat();
    return formatter.format(_loadedTime);
  }

  String get futureUserRoyalties {
    if (_ownerToken == null) {
      return "";
    }
    final percent = _ownerToken!.token / totalSupply;
    final userRoyalties =
        TokenModel(token: percent * _royaltiesToken.token, price: _price);
    return isDollar
        ? userRoyalties.getDollarValue()
        : userRoyalties.getBnbValue();
  }

  final refreshIndicator = GlobalKey<RefreshIndicatorState>();
  DateTime _loadedTime = DateTime.now();
  bool isError = false;
  bool isDollar = true;
  late PriceValueModel _price;
  TokenModel? _ownerToken;
  late TokenModel _lotteryValue;
  late TokenModel _royaltiesToken;
  TextEditingController holdingController;

  Future<void> loadInfos() async {
    try {
      refreshIndicator.currentState?.show();
      isError = false;
      double lotteryToken = await _homeService.fetchLotteryToken();
      double royaltiesToken = await _homeService.fetchRoyaltiesToken();
      final price = await _homeService.fetchPoocoinPrice();
      _loadedTime = DateTime.now();

      _price = price;
      _lotteryValue = TokenModel(token: lotteryToken, price: price);
      _royaltiesToken = TokenModel(token: royaltiesToken, price: price);

      final userBlock = _homeService.getUserBlocks();
      await updateOwnerBlock(userBlock.toString());
    } catch (ignored) {
      isError = true;
    }
    notifyListeners();
  }

  Future<void> updateOwnerBlock(String ownerToken) async {
    final token = double.tryParse(ownerToken) ?? 0;
    _ownerToken = TokenModel(token: token, price: _price);

    notifyListeners();

    _homeService.storeUserBlocks(token);
  }

  void changeCurrency() {
    isDollar = !isDollar;

    notifyListeners();
  }

  void openTwitter() {
    launch("https://twitter.com/hashtag/luckyblock");
  }

  void openTelegram() {
    launch("https://t.me/LuckyBlockChainTG");
  }

  void openWebsite() {
    launch("https://luckyblock.com/");
  }

  void openStrimeGithub() {
    launch("https://github.com/Strime/luckyblock");
  }
}
