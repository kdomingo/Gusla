import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../service/search_service.dart';

class SearchEvent {
  final String? query;

  const SearchEvent._({this.query});

  const SearchEvent.withQuery({required String query}) : this._(query: query);
}

class SearchResults extends Equatable {
  final List<dynamic>? data;
  final bool processing;

  const SearchResults._({this.data, this.processing = false});

  const SearchResults.empty() : this._();

  const SearchResults.processing() : this._(processing: true);

  const SearchResults.withData({required List<dynamic> data})
    : this._(data: data);

  @override
  List<Object?> get props => [data, processing];
}

class SearchBloc extends Bloc<SearchEvent, SearchResults> {
  SearchBloc(SearchService service) : super(SearchResults.empty()) {
    on<SearchEvent>((event, emit) async {
      emit(SearchResults.processing());

      final query = event.query?.trim();
      if (query == null || event.query!.isEmpty) {
        emit(SearchResults.empty());
        return;
      }

      await service.search(query);

      emit(SearchResults.withData(data: ["1"]));
    });
  }
}
