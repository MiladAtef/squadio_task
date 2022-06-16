import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/fetch_person_details.dart';
import '../../../models/popular_person_info.dart';
import '../../../models/error_model.dart';
import '../../models/person_image_model.dart';

part 'popular_person_details_event.dart';
part 'popular_person_details_state.dart';

class PopularPersonDetailsBloc extends Bloc<PopularPersonDetailsEvent, PopularPersonDetailsState> {
  final FetchPersonInfoById repo = FetchPersonInfoById();

  PopularPersonDetailsBloc() : super(PopularPersonDetailsInitial()) {
    on<PopularPersonDetailsEvent>((event, emit) async {
      if (event is LoadPopularPersonDetails) {
        try {
          emit(PopularPersonDetailsLoading());
          final data = await repo.getCastDetails(event.id);

          emit(PopularPersonDetailsLoaded(
            info: data[0],
            socialInfo: data[1],
            images: data[2],
          ));
        } on FetchDataError catch (e) {
          emit(PopularPersonDetailsError(error: e));
        } catch (e) {
          emit(PopularPersonDetailsError(error: FetchDataError(e.toString())));
        }
      }
    });
  }
}
