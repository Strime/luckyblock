// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pcs_client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PcsResponse _$PcsResponseFromJson(Map<String, dynamic> json) => PcsResponse(
      data: PcsData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PcsResponseToJson(PcsResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

PcsData _$PcsDataFromJson(Map<String, dynamic> json) => PcsData(
      price: json['price'] as String,
      price_BNB: json['price_BNB'] as String,
    );

Map<String, dynamic> _$PcsDataToJson(PcsData instance) => <String, dynamic>{
      'price': instance.price,
      'price_BNB': instance.price_BNB,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _PcsRestClient implements PcsRestClient {
  _PcsRestClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://api.pancakeswap.info/api/v2';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<PcsResponse> getPriceInfo() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PcsResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options,
                    '/tokens/0x2cD96e8C3FF6b5E01169F6E3b61D28204E7810Bb',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PcsResponse.fromJson(_result.data!);
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
