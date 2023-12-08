import 'failure.dart';

class FailureMapper {
  static String mapFailureToMessage({required Failure failure}) {
    // Using a switch statement to handle different failure types

    switch (failure.runtimeType) {
      case ServerFailure:
        return "SERVER_FAILURE_MESSAGE";
      default:
        return 'Unexpected error';
    }
  }
}
