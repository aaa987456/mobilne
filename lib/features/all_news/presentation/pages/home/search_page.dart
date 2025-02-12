import 'package:flutter/material.dart';
import 'package:news_app/features/all_news/presentation/widgets/search_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 3),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search thru all articles',
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 24,
                fontWeight: FontWeight.bold,
              )),
        ),
        body: const SearchBarWidget(),
      ),
    );
  }
}
