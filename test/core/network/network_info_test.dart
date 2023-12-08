import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/core/network/network_info.dart';
import 'network_info_test.mocks.dart';

@GenerateMocks([InternetConnectionChecker])
void main() {
  late NetworkInfoImpl networkInfo;
  late MockInternetConnectionChecker mockInternetConnectionChecker;

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfo = NetworkInfoImpl(connectionChecker: mockInternetConnectionChecker);
  });

  group('NetworkInfoImpl', () {
    group('isConnected', () {
      test(
        'should forward the call to InternetConnectionChecker.hasConnection',
        () async {
          // Arrange
          final tHasConnectionFuture = Future.value(true);
          when(mockInternetConnectionChecker.hasConnection)
              .thenAnswer((_) => tHasConnectionFuture);

          // Act
          final result = networkInfo.isConnected;

          // Assert
          verify(mockInternetConnectionChecker.hasConnection);
          expect(result, tHasConnectionFuture);
        },
      );

      test(
        'should return true when InternetConnectionChecker.hasConnection returns true',
        () async {
          // Arrange
          when(mockInternetConnectionChecker.hasConnection)
              .thenAnswer((_) => Future.value(true));

          // Act
          final result = await networkInfo.isConnected;

          // Assert
          verify(mockInternetConnectionChecker.hasConnection);
          expect(result, true);
        },
      );

      test(
        'should return false when InternetConnectionChecker.hasConnection returns false',
        () async {
          // Arrange
          when(mockInternetConnectionChecker.hasConnection)
              .thenAnswer((_) => Future.value(false));

          // Act
          final result = await networkInfo.isConnected;

          // Assert
          verify(mockInternetConnectionChecker.hasConnection);
          expect(result, false);
        },
      );
    });
  });
}
