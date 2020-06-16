import 'package:covid19_santoamaro/app/models/cidade_model.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class CovidRepository {
  final Dio _dio;

  CovidRepository(this._dio);

  Future<List<Cidade>> getData() async {
    try {
      var response = await _dio.get('/?is_last=True&city=Santo%20Amaro');

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Response Success, Status Code: ${response.statusCode}');

        List<Cidade> list = [];

        var result = json.decode(response.data);

        for (var json in (result["results"] as List)) {
          Cidade cidade = Cidade(
            casos: json['confirmed'],
            mortes: json['deaths'],
            populacao: json['estimated_population_2019'],
            ultimaAtualizacao: json['date'],
          );
          list.add(cidade);
        }
        return list;
      }
    } on DioError catch (exception) {
      print('Response Error, Cause: $exception');

      if (exception == null ||
          exception.toString().contains('SocketException')) {
        throw Exception("Erro na Rede");
      } else if (exception.type == DioErrorType.RECEIVE_TIMEOUT ||
          exception.type == DioErrorType.CONNECT_TIMEOUT) {
        throw Exception(
            "Por favor, estabeleça uma conexão estável para continuar");
      }
    }

    return null;
  }
}
