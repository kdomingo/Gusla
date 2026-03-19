import 'package:flutter/material.dart';

import '../outlined_input_field.dart';
import '../util/strings.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.appName),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.map))],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlinedInputField(
              suffixIcon: IconButton(
                onPressed: () {},
                icon: Icon(Icons.search),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
