import 'package:flurest/apiKey.dart';
import 'package:flurest/models/tv_show_response.dart';
import 'package:flurest/networking/api_base_helper.dart';

class TvShowRepositery {
  final _apiKey = apiKey;
  ApiBaseHelper helper = ApiBaseHelper();
  Future<List<TvShow>> fetchTvShowList(int page) async {
    final response = await helper
        .get('tv/popular?api_key=$_apiKey&language=en-US&page=$page');
    return TvShowResponse.fromJson(response).results;
  }
}
