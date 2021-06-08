class TvShowDetail {
  String posterPath;
  String name;
  double voteAverage;
  String overview;

  TvShowDetail.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    voteAverage = json['vote_average'];
    overview = json['overview'];
    posterPath = json['poster_path'];
  }
}
