import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/all_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:news_app/features/all_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:news_app/features/all_news/presentation/bloc/article/remote/remote_article_state.dart';
import 'package:news_app/features/all_news/presentation/widgets/app_bar_all.dart';
import 'package:news_app/features/all_news/presentation/widgets/article_tile.dart';

class AllNews extends StatefulWidget {
  const AllNews({super.key});

  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  late final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: buildBody(context, _scrollController));
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    BlocProvider.of<RemoteArticleBloc>(context).add(const GetArticles(true));
    _scrollController.addListener(() {
      if (_scrollController.offset > 0 && _scrollController.position.atEdge) {
        print("Na rubu");
        BlocProvider.of<RemoteArticleBloc>(context)
            .add(const GetArticles(false));
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

Widget buildBody(BuildContext context, ScrollController _scrollController) {
  return Scaffold(
    appBar: const PreferredSize(
        preferredSize: Size.fromHeight(48), child: AppBarAll()),
    endDrawer: Drawer(
      child: ListView(
        padding: const EdgeInsets.only(top: 20),
        children: <Widget>[
          const ListTile(
            title: Text('Sort By',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          ListTile(
            trailing: const Icon(Icons.arrow_upward),
            title: const Text('Newest Date'),
            onTap: () {
              BlocProvider.of<RemoteArticleBloc>(context)
                  .add(const SortByNewestDate());
              Navigator.pop(context);
            },
          ),
          ListTile(
            trailing: const Icon(Icons.arrow_downward_sharp),
            title: const Text('Oldest Date'),
            onTap: () {
              BlocProvider.of<RemoteArticleBloc>(context)
                  .add(const SortByOldestDate());
              Navigator.pop(context);
            },
          ),
        ],
      ),
    ),
    body: BlocBuilder<RemoteArticleBloc, RemoteArticleState>(
      builder: (context, state) {
        if (state is RemoteArticleSuccess) {
          bool isLoading = state is RemoteArticleLoading;
          return ListView.builder(
            controller: _scrollController,
            itemCount:
                isLoading ? state.articles.length + 1 : state.articles.length,
            itemBuilder: (context, index) {
              if (isLoading && index == state.articles.length) {
                return const ListTile(
                  title: SizedBox(
                    height: 5,
                    width: 5,
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              final article = state.articles[index];
              return ArticleTile(article: article);
            },
          );
        } else if (state is RemoteArticleError) {
          return Center(
            child: Text(state.error.toString()),
          );
        } else {
          return const Center(
            child: Text('No data'),
          );
        }
      },
    ),
  );
}
