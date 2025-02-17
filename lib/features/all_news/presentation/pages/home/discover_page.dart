import 'package:flutter/material.dart';
import 'package:news_app/core/constants/categories.dart';
import 'package:news_app/features/all_news/presentation/widgets/discover_tab_body.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 7,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Discover",
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            bottom: TabBar(
                isScrollable: true,
                indicatorColor: Theme.of(context).colorScheme.primary,
                tabs: const [
                  Tab(text: "Business"),
                  Tab(text: "Entertainment"),
                  Tab(text: "General"),
                  Tab(text: "Health"),
                  Tab(text: "Science"),
                  Tab(text: "Sports"),
                  Tab(text: "Technology"),
                ]),
          ),
          body: const TabBarView(children: [
            DiscoverTabBody(category: Category.business),
            DiscoverTabBody(category: Category.entertainment),
            DiscoverTabBody(category: Category.general),
            DiscoverTabBody(category: Category.health),
            DiscoverTabBody(category: Category.science),
            DiscoverTabBody(category: Category.sports),
            DiscoverTabBody(category: Category.technology),
          ]),
        ));
  }
}
