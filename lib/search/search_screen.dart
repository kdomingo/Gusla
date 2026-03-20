import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_places_sdk_plus/google_places_sdk_plus.dart';
import 'package:gusla/search/search_bloc.dart';

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
        mainAxisSize: MainAxisSize.max,
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
          Expanded(
            child: BlocBuilder<SearchBloc, SearchResult>(
              builder: (context, state) {
                final data = state.data as List<AutocompletePrediction>? ?? [];
                if (state.processing) {
                  return Center(child: CircularProgressIndicator());
                }
                if (data.isEmpty) {
                  return Center(child: Text(Strings.noResults));
                }
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final place = data[index];
                    return ListTile(
                      title: Text(place.primaryText ?? Strings.unknownPlace),
                      subtitle: Text(place.secondaryText ?? ""),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
