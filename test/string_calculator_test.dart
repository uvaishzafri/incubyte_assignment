import 'package:flutter_test/flutter_test.dart';
import 'package:string_calculator_tdd/string_calculator.dart';

void main() {
  group('String Calculator', () {
    late StringCalculator calculator;

    setUp(() {
      calculator = StringCalculator();
    });

    test('should return 0 for empty string', () {
      // Arrange
      const input = '';

      // Act
      final result = calculator.add(input);

      // Assert
      expect(result, 0);
    });

    test('should return the number itself for single number', () {
      expect(calculator.add('1'), 1);
      expect(calculator.add('5'), 5);
    });
  });
}