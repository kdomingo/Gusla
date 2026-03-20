import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../service/search_service.dart';

class SearchEvent {
  final String? query;

  const SearchEvent._({this.query});

  const SearchEvent.withQuery({required String query}) : this._(query: query);
}

class SearchResult<T> extends Equatable {
  final T? data;
  final bool processing;

  const SearchResult._({this.data, this.processing = false});

  const SearchResult.empty() : this._();

  const SearchResult.processing() : this._(processing: true);

  const SearchResult.withData({required T data}) : this._(data: data);

  @override
  List<Object?> get props => [data, processing];
}

class SearchBloc extends Bloc<SearchEvent, SearchResult> {
  SearchBloc(SearchService service) : super(SearchResult.empty()) {
    on<SearchEvent>((event, emit) async {
      emit(SearchResult.processing());

      final query = event.query?.trim();
      if (query == null || event.query!.isEmpty) {
        emit(SearchResult.empty());
        return;
      }

      final result = await service.search(query);
      emit(SearchResult.withData(data: result.data));
    });
  }
}
