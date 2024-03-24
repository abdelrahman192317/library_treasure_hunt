import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../core/global/global.dart';
import '../../data/models/questions_model.dart';
import '../../data/repos/questions_firebase.dart';

part 'questions_event.dart';
part 'questions_state.dart';

class QuestionsBloc extends Bloc<QuestionsEvent, QuestionsState> {
  QuestionsBloc() : super(QuestionsInitial()) {
    on<FetchAllQuestionsEvent>(fetchAllQuestionsEvent);
  }

  FutureOr<void> fetchAllQuestionsEvent(
      FetchAllQuestionsEvent event, Emitter<QuestionsState> emit) async {

    emit(QuestionsLoadingState());

    try {
      List<Question> questions =
          await QuestionsFirebaseManger.getQuestions();

      myQuestions = List.from(questions);
      myQuestions = List.from(questions);

      emit(QuestionsFetchedSuccessfullyState());
    } catch (e) {
      emit(QuestionsErrorState(error: e.toString()));

    }

  }
}
