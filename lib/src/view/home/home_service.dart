import 'package:lucky/src/data/bsc_client.dart';
import 'package:lucky/src/data/pcs_client.dart';
import 'package:lucky/src/view/home/home_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeService {
  static const keyUserBlocks = "user_blocks";

  HomeService(this._bscRestClient, this._pcsRestClient, this._prefs);

  final BscRestClient _bscRestClient;
  final PcsRestClient _pcsRestClient;
  final SharedPreferences _prefs;

  Future<double> fetchLotteryToken() async {
    final lotteryResponse = await _bscRestClient.getLotteryInfos();
    double? lotteryToken = double.tryParse(lotteryResponse.result!);
    return (lotteryToken! / 1000000000);
  }

  Future<double> fetchRoyaltiesToken() async {
    final royaltiesResponse = await _bscRestClient.getRoyaltiesInfos();
    double? royalties = double.tryParse(royaltiesResponse.result!);
    return (royalties! / 1000000000);
  }

  Future<PriceValueModel> fetchPoocoinPrice() async {
    final priceResponse = await _pcsRestClient.getPriceInfo();
    double price = double.tryParse(priceResponse.data.price)!;
    double bnbPrice = double.tryParse(priceResponse.data.price_BNB)!;
    return PriceValueModel(price: price, bnbPrice: bnbPrice);
  }

  double getUserBlocks() {
    return _prefs.getDouble(keyUserBlocks) ?? 0;
  }

  Future<bool> storeUserBlocks(double userBlocks) async {
    return await _prefs.setDouble(keyUserBlocks, userBlocks);
  }
}
