import 'package:flurest/blocs/tv_show_detail_block.dart';
import 'package:flurest/models/tv_show%20_detail_response.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class ShowDetailScreen extends StatefulWidget {
  final int showId;
  ShowDetailScreen(this.showId);
  @override
  _ShowDetailScreenState createState() => _ShowDetailScreenState();
}

class _ShowDetailScreenState extends State<ShowDetailScreen> {
  TvShowDetailBlock _block;
  @override
  void initState() {
    _block = TvShowDetailBlock(widget.showId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Tv show detail'),
        ),
        body: RefreshIndicator(
          onRefresh: () => _block.fatchShowDetail(widget.showId),
          child: StreamBuilder<TvShowDetail>(
            stream: _block.showDetailStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData ||
                  snapshot.connectionState == ConnectionState.waiting)
                return Container();
              else if (snapshot.hasError)
                return Text('de');
              else {
                return ShowDetail(
                  displayShow: snapshot.data,
                  block: _block,
                );
              }
            },
          ),
        ));
  }
}

class ShowDetail extends StatelessWidget {
  final TvShowDetail displayShow;
  final TvShowDetailBlock block;

  ShowDetail({Key key, this.displayShow, this.block}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(fit: StackFit.expand, children: [
        new Image.network(
          'https://image.tmdb.org/t/p/w342${displayShow.posterPath}',
          fit: BoxFit.cover,
        ),
        new BackdropFilter(
          filter: new ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: new Container(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        new SingleChildScrollView(
          child: new Container(
            margin: const EdgeInsets.all(20.0),
            child: new Column(
              children: <Widget>[
                new Container(
                  alignment: Alignment.center,
                  child: new Container(
                    width: 400.0,
                    height: 400.0,
                  ),
                  decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.circular(10.0),
                    image: new DecorationImage(
                        image: new NetworkImage(
                            'https://image.tmdb.org/t/p/w342${displayShow.posterPath}'),
                        fit: BoxFit.cover),
                    boxShadow: [
                      new BoxShadow(
//                          color: Colors.black,
                          blurRadius: 20.0,
                          offset: new Offset(0.0, 10.0))
                    ],
                  ),
                ),
                new Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 0.0),
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                          child: new Text(
                        displayShow.name,
                        style: new TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontFamily: 'Arvo'),
                      )),
                      new Text(
                        displayShow.voteAverage.toStringAsFixed(2),
//                      '${widget.movie['vote_average']}/10',
                        style: new TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontFamily: 'Arvo'),
                      )
                    ],
                  ),
                ),
                new Text(displayShow.overview,
                    style:
                        new TextStyle(color: Colors.white, fontFamily: 'Arvo')),
                new Padding(padding: const EdgeInsets.all(10.0)),
                new Row(
                  children: <Widget>[
                    new Expanded(
                        child: new Container(
                      width: 150.0,
                      height: 60.0,
                      alignment: Alignment.center,
                      child: new Text(
                        'Rate Movie',
                        style: new TextStyle(
                            color: Colors.white,
                            fontFamily: 'Arvo',
                            fontSize: 20.0),
                      ),
                      decoration: new BoxDecoration(
                          borderRadius: new BorderRadius.circular(10.0),
                          color: const Color(0xaa3C3261)),
                    )),
                    new Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: new Container(
                        padding: const EdgeInsets.all(16.0),
                        alignment: Alignment.center,
                        child: new Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                        decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.circular(10.0),
                            color: const Color(0xaa3C3261)),
                      ),
                    ),
                    new Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Container(
                          padding: const EdgeInsets.all(16.0),
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () {
                              block.changeShowName(displayShow);
                            },
                            child: Icon(
                              Icons.bookmark,
                              color: Colors.white,
                            ),
                          ),
                          decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(10.0),
                              color: const Color(0xaa3C3261)),
                        )),
                  ],
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
