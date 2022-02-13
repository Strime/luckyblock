import 'package:json_annotation/json_annotation.dart';
import 'package:lucky/src/data/properties.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'pcs_client.g.dart';

@RestApi(baseUrl: "https://api.pancakeswap.info/api/v2")
abstract class PcsRestClient {
  factory PcsRestClient(Dio dio, {String baseUrl}) = _PcsRestClient;

  @GET("/tokens/${Properties.contractAddress}")
  Future<PcsResponse> getPriceInfo();
}

@JsonSerializable()
class PcsResponse {
  PcsData data;

  PcsResponse({required this.data});

  factory PcsResponse.fromJson(Map<String, dynamic> json) =>
      _$PcsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PcsResponseToJson(this);
}

@JsonSerializable()
class PcsData {
  String price;
  // ignore: non_constant_identifier_names
  String price_BNB;

  // ignore: non_constant_identifier_names
  PcsData({required this.price, required this.price_BNB});

  factory PcsData.fromJson(Map<String, dynamic> json) =>
      _$PcsDataFromJson(json);
  Map<String, dynamic> toJson() => _$PcsDataToJson(this);
}
