import 'package:flurest/blocs/tv_show_block.dart';
import 'package:flurest/models/tv_show_response.dart';
import 'package:flurest/view/tv_show_detail.dart';
import 'package:flutter/material.dart';

int a = 1;

class TvShowScreen extends StatefulWidget {
  @override
  _TvShowScreenState createState() => _TvShowScreenState();
}

class _TvShowScreenState extends State<TvShowScreen> {
  TvShowBlock _block;
  @override
  void initState() {
    super.initState();
    _block = TvShowBlock(a);
  }

  @override
  void dispose() {
    _block.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tv Shows'),
      ),
      body: RefreshIndicator(
        onRefresh: () => _block.fetchTvShowlist(a),
        child: StreamBuilder<List<TvShow>>(
          stream: _block.movieListStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData ||
                snapshot.connectionState == ConnectionState.waiting)
              return Container();
            else if (snapshot.hasError)
              return Text('de');
            else {
              return ShowList(
                showList: snapshot.data,
                block: _block,
              );
            }
          },
        ),
      ),
    );
  }
}

class ShowList extends StatelessWidget {
  final List<TvShow> showList;
  final TvShowBlock block;

  const ShowList({Key key, this.showList, this.block}) : super(key: key);
  bool _onScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      final before = notification.metrics.extentBefore;
      final max = notification.metrics.maxScrollExtent;

      if (before == max) {
        a++;
        block.fetchTvShowlist(a);
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: _onScrollNotification,
      child: GridView.builder(
        itemCount: showList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5 / 1.8,
        ),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ShowDetailScreen(showList[index].id)));
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w342${showList[index].posterPath}',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
