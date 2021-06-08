import 'dart:core';

class TvShowResponse {
  int page;
  int totalResults;
  int totalPages;
  List<TvShow> results;
  TvShowResponse.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalResults = json['total_results'];
    totalPages = json['total_pages'];
    if (json['results'] != null) {
      results = new List<TvShow>();
      json['results'].forEach((v) {
        results.add(new TvShow.fromJson(v));
      });
    }
  }
}

class TvShow {
  String backdropPath;
  int id;
  String name;
  String originalLanguage;
  String orignalName;
  String overview;
  //double popularity;
  String posterPath;
  //double voteAverage;
  int voteCount;

  TvShow.fromJson(Map<String, dynamic> json) {
    voteCount = json['vote_count'];
    id = json['id'];
    //  voteAverage = json['vote_average'];
    //  popularity = json['popularity'];
    posterPath = json['poster_path'];
    originalLanguage = json['original_language'];
    name = json['name'];
    backdropPath = json['backdrop_path'];
    // voteCount = json['vote_count'];
    overview = json['overview'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vote_count'] = this.voteCount;
    data['id'] = this.id;

    // data['vote_average'] = this.voteAverage;

    //data['popularity'] = this.popularity;
    data['poster_path'] = this.posterPath;
    data['original_language'] = this.originalLanguage;

//    data['genre_ids'] = this.genreIds;
    data['backdrop_path'] = this.backdropPath;

    data['overview'] = this.overview;
    return data;
  }
}
