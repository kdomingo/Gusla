import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_places_sdk_plus/google_places_sdk_plus.dart';
import 'package:gusla/mixin/location_resolution_mixin.dart';
import 'package:gusla/search/search_bloc.dart';
import 'package:gusla/service/location_service.dart';

import '../data/models/query.dart';
import '../outlined_input_field.dart';
import '../util/strings.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with LocationResolutionMixin {
  final _searchFieldController = TextEditingController();

  @override
  void dispose() {
    _searchFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(Strings.appName),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.map))],
        ),
        body: FutureBuilder(
          future: context.read<LocationService>().getLocation(),
          builder: (context, snapshot) {
            final result = snapshot.data;

            final requiresPermission = result?.requiresPermission ?? false;
            if (requiresPermission) {
              WidgetsBinding.instance.addPostFrameCallback(
                (timeStamp) => showResolutionDialog(context),
              );
            }

            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OutlinedInputField(
                    controller: _searchFieldController,
                    suffixIcon: IconButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();

                        final coords = snapshot.data?.data as LatLng;
                        context.read<SearchBloc>().add(
                          SearchEvent.withQuery(
                            query: QueryOptions(
                              place: _searchFieldController.text,
                              origin: snapshot.data?.data,
                              locationBias: LatLngBounds(
                                southwest: LatLng(
                                  lat: coords.lat - 0.001,
                                  lng: coords.lng - 0.001,
                                ),
                                northeast: LatLng(
                                  lat: coords.lat + 0.001,
                                  lng: coords.lng + 0.001,
                                ),
                              ),
                              countries: ["PH"],
                            ),
                          ),
                        );
                      },
                      icon: Icon(Icons.search),
                    ),
                  ),
                ),
                Expanded(
                  child: BlocBuilder<SearchBloc, SearchResult>(
                    builder: (context, state) {
                      final data =
                          state.data as List<AutocompletePrediction>? ?? [];
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
                            title: Text(
                              place.primaryText ?? Strings.unknownPlace,
                            ),
                            subtitle: Text(place.secondaryText ?? ""),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
