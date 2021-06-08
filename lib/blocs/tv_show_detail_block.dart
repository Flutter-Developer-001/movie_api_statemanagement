import 'dart:async';

import 'package:flurest/models/tv_show%20_detail_response.dart';
import 'package:flurest/repository/tv_show_detail_repository.dart';

class TvShowDetailBlock {
  TvShowDetailRepository _repository;
  StreamController _tvshowDetailController = StreamController<TvShowDetail>();
  Stream<TvShowDetail> get showDetailStream => _tvshowDetailController.stream;

  TvShowDetailBlock(int id) {
    _repository = TvShowDetailRepository();
    fatchShowDetail(id);
  }

  changeShowName(TvShowDetail show) {
    show.name = 'scam 1992';
    _tvshowDetailController.add(show);
  }

  fatchShowDetail(int id) async {
    final _detail = await _repository.fetchPopularTvShows(id);
    _tvshowDetailController.add(_detail);
  }

  void dispose() {
    _tvshowDetailController.close();
  }
}
