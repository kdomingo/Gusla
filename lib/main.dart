import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:gusla/repository/search_repository.dart';
import 'package:gusla/search/search_bloc.dart';
import 'package:gusla/search/search_screen.dart';
import 'package:gusla/service/search_service.dart';
import 'package:gusla/util/strings.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => FlutterGooglePlacesSdk("")),
        Provider(
          create: (context) =>
              SearchRepositoryImpl(datasource: context.read())
                  as SearchRepository,
        ),
        Provider(
          create: (context) =>
              SearchServiceImpl(repository: context.read()) as SearchService,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          /// Blocks
          BlocProvider<SearchBloc>(
            create: (context) => SearchBloc(context.read()),
          ),
        ],
        child: const GuslaApp(),
      ),
    ),
  );
}

class GuslaApp extends StatelessWidget {
  const GuslaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appName,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      debugShowCheckedModeBanner: false,
      home: const SearchScreen(),
    );
  }
}
