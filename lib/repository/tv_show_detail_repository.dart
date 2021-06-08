import 'package:flurest/apiKey.dart';
import 'package:flurest/models/tv_show%20_detail_response.dart';
import 'package:flurest/networking/api_base_helper.dart';

class TvShowDetailRepository {
  final _apiKey = apiKey;

  ApiBaseHelper helper = ApiBaseHelper();

  fetchPopularTvShows(int id) async {
    final response = await helper.get('tv/$id?api_key=$_apiKey&language=en-US');
    return TvShowDetail.fromJson(response);
  }
}
