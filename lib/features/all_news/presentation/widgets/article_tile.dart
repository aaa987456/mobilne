import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
      onTap: () async {
        if (article.url == null || article.url!.isEmpty) {
          print("empty");
        }

        if (await canLaunchUrlString(article.url ?? "")) {
          await launchUrlString(article.url ?? "",
              mode: LaunchMode.inAppWebView);
        } else {
          throw "Could not launch ${article.url}";
        }
      },
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      shape: Border(
        bottom:
            BorderSide(color: Theme.of(context).colorScheme.primary, width: 1),
      ),
      visualDensity: const VisualDensity(horizontal: -2, vertical: 4),
      // ignore: prefer_const_constructors
      leading: FadeInImage(
        placeholder: AssetImage("assets/placeholder.jpg"),
        imageErrorBuilder: (context, error, stackTrace) =>
            Image.asset("assets/placeholder.jpg"),
        image: NetworkImage(article.urlToImage ?? ""),
        width: 100,
        height: 100,
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
