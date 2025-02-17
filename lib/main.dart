import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/all_news/presentation/pages/home/homepage.dart';
import 'package:news_app/injection_container.dart';

import 'config/theme/theme.dart';
import 'config/util/util.dart';
import 'features/all_news/presentation/bloc/article/remote/remote_article_bloc.dart';

void main() async {
  await init();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => sl<RemoteArticleBloc>()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    TextTheme textTheme =
        createTextTheme(context, "Roboto Serif", "Roboto Serif");

    MaterialTheme theme = MaterialTheme(textTheme);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: brightness == Brightness.light ? theme.light() : theme.dark(),
        home: const Homepage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
