import 'dart:async';

import 'package:flurest/models/tv_show_response.dart';
import 'package:flurest/repository/tv_show_repository.dart';

class TvShowBlock {
  TvShowRepositery _tvRepositery;
  List<TvShow> _tvShow = [];

  StreamController _tvShowListController = StreamController<List<TvShow>>();

  TvShowBlock(int page) {
    _tvRepositery = TvShowRepositery();
    fetchTvShowlist(page);
  }

  Stream<List<TvShow>> get movieListStream => _tvShowListController.stream;

  fetchTvShowlist(int page) async {
    try {
      final _shows = await _tvRepositery.fetchTvShowList(page);
      _shows.forEach((element) {
        _tvShow.add(element);
      });
      _tvShowListController.add(_tvShow);
    } catch (e) {
      print(e.toString());
    }
  }

  void dispose() {
    _tvShowListController.close();
  }
}
