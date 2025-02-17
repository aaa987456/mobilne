import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/all_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:news_app/features/all_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:news_app/features/all_news/presentation/bloc/article/remote/remote_article_state.dart';

import 'article_tile.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.offset > 0 && _scrollController.position.atEdge) {
        print("Na rubu");
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              onChanged: (value) {
                if (value.length >= 3) {
                  BlocProvider.of<RemoteArticleBloc>(context)
                      .add(GetArticleBySearchEvent(query: value));
                }
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search_sharp),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.onPrimary,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  hintText: "Search "),
            ),
          ),
          BlocBuilder<RemoteArticleBloc, RemoteArticleState>(
              builder: (_, state) {
            if (state is ArticleSearchLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ArticleSearchLoadedState) {
              return Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: state.articles.length,
                  itemBuilder: (context, index) {
                    final article = state.articles[index];
                    return ArticleTile(article: article);
                  },
                ),
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
          })
        ],
      ),
    );
  }
}
