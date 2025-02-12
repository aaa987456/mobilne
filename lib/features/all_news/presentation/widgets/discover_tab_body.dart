import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/all_news/domain/entities/article.dart';
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
  @override
  void initState() {
    super.initState();

    BlocProvider.of<RemoteArticleBloc>(context)
        .add(GetArticlesByCategory(widget.category));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RemoteArticleBloc, RemoteArticleState>(
        builder: (_, state) {
      if (state is ArticleCategoryLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is ArticleCategoryLoadedState) {
        return ListView.builder(
          itemCount: state.articles.length,
          itemBuilder: (context, index) {
            final article = state.articles[index];
            return ArticleTile(article: article);
          },
        );
      }
      return const SizedBox();
    });
  }
}
