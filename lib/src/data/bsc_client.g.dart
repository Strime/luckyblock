// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bsc_client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BscResponse _$BscResponseFromJson(Map<String, dynamic> json) => BscResponse(
      status: json['status'] as String?,
      result: json['result'] as String?,
    );

Map<String, dynamic> _$BscResponseToJson(BscResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'result': instance.result,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _BscRestClient implements BscRestClient {
  _BscRestClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://api.bscscan.com';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<BscResponse> getLotteryInfos() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<
        BscResponse>(Options(
            method: 'GET', headers: _headers, extra: _extra)
        .compose(_dio.options,
            '/api?module=account&action=tokenbalance&contractaddress=0x2cD96e8C3FF6b5E01169F6E3b61D28204E7810Bb&address=0x56E01D401319B4b705Bf4251854300b67954a701&tag=latest&apiKey=R142KBC7PD2FZQGJ65MI98MNSMKGGHQ2QD',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BscResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BscResponse> getRoyaltiesInfos() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<
        BscResponse>(Options(
            method: 'GET', headers: _headers, extra: _extra)
        .compose(_dio.options,
            '/api?module=account&action=tokenbalance&contractaddress=0x2cD96e8C3FF6b5E01169F6E3b61D28204E7810Bb&address=0x45A0A5A4d86B04800963Dc8346CE62B086418F37&tag=latest&apiKey=R142KBC7PD2FZQGJ65MI98MNSMKGGHQ2QD',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BscResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
