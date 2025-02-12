import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/article.dart';

class ArticleTile extends StatelessWidget {
  const ArticleTile({
    super.key,
    required this.article,
  });

  final ArticleEntity article;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      shape: Border(
        bottom:
            BorderSide(color: Theme.of(context).colorScheme.primary, width: 1),
      ),
      visualDensity: const VisualDensity(horizontal: -2, vertical: 4),
      leading: Image.network(
        article.urlToImage!,
        width: 100,
        height: 100,
        fit: BoxFit.fitHeight,
      ),
      title: Text(
        article.title ?? "",
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            article.author ?? "",
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            article.publishedAt != null
                ? DateFormat('yyyy-MM-dd - kk:mm').format(article.publishedAt!)
                : "",
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
