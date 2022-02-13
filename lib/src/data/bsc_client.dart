import 'package:json_annotation/json_annotation.dart';
import 'package:lucky/src/data/properties.dart';
import 'package:lucky/src/data/secret.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'bsc_client.g.dart';

@RestApi(baseUrl: "https://api.bscscan.com")
abstract class BscRestClient {
  factory BscRestClient(Dio dio, {String baseUrl}) = _BscRestClient;

  @GET(
      "/api?module=account&action=tokenbalance&contractaddress=${Properties.contractAddress}&address=${Properties.lotteryAddress}&tag=latest&apiKey=${Secret.apiKey}")
  Future<BscResponse> getLotteryInfos();

  @GET(
      "/api?module=account&action=tokenbalance&contractaddress=${Properties.contractAddress}&address=${Properties.royaltiesAddress}&tag=latest&apiKey=${Secret.apiKey}")
  Future<BscResponse> getRoyaltiesInfos();
}

@JsonSerializable()
class BscResponse {
  String? status;
  String? result;

  BscResponse({this.status, this.result});

  factory BscResponse.fromJson(Map<String, dynamic> json) =>
      _$BscResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BscResponseToJson(this);
}
