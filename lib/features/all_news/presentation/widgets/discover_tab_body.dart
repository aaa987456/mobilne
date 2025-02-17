import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/all_news/presentation/bloc/article/remote/remote_article_state.dart';

import '../../../../core/constants/categories.dart';
import '../bloc/article/remote/remote_article_bloc.dart';
import '../bloc/article/remote/remote_article_event.dart';
import 'article_tile.dart';

class DiscoverTabBody extends StatefulWidget {
  final Category category;

  const DiscoverTabBody({super.key, required this.category});

  @override
  State<DiscoverTabBody> createState() => _DiscoverTabBodyState();
}

class _DiscoverTabBodyState extends State<DiscoverTabBody> {
  late final ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    BlocProvider.of<RemoteArticleBloc>(context)
        .add(GetArticlesByCategory(widget.category, true));

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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RemoteArticleBloc, RemoteArticleState>(
        builder: (context, state) {
      if (state is RemoteArticleSuccess) {
        bool isLoading = state is ArticleCategoryLoadingState;
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
      }
      return const SizedBox();
    });
  }
}
