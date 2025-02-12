import 'package:flutter/material.dart';

class AppBarAll extends StatelessWidget {
  const AppBarAll({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Padding(
        padding: EdgeInsets.only(top: 10),
        child: Text(
          'Trending News',
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
