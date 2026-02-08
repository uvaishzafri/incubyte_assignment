import 'package:flutter_test/flutter_test.dart';
import 'package:string_calculator_tdd/string_calculator.dart';

void main() {
  group('String Calculator', () {
    late StringCalculator calculator;

    setUp(() {
      calculator = StringCalculator();
    });

    test('should return 0 for empty string', () {
      expect(calculator.add(''), 0);
    });

    test('should return the number itself for single number', () {
      expect(calculator.add('1'), 1);
      expect(calculator.add('5'), 5);
    });

    test('should return sum of two comma-separated numbers', () {
      expect(calculator.add('1,2'), 3);
      expect(calculator.add('1,5'), 6);
    });

    test('should handle any amount of numbers', () {
      expect(calculator.add('1,2,3'), 6);
      expect(calculator.add('1,2,3,4,5'), 15);
      expect(calculator.add('10,20,30,40'), 100);
    });

    test('should handle newlines between numbers', () {
      expect(calculator.add('1\n2,3'), 6);
      expect(calculator.add('1\n2\n3'), 6);
    });

    test('should support custom delimiters', () {
      expect(calculator.add('//;\n1;2'), 3);
      expect(calculator.add('//|\n1|2|3'), 6);
      expect(calculator.add('//sep\n2sep3'), 5);
    });

    test('should throw exception for negative numbers', () {
      expect(
            () => calculator.add('1,-2,3'),
        throwsA(predicate((e) =>
        e is Exception &&
            e.toString().contains('negative numbers not allowed: -2'))),
      );
    });

    test('should show all negative numbers in exception message', () {
      expect(
            () => calculator.add('1,-2,-3,4,-5'),
        throwsA(predicate((e) =>
        e is Exception &&
            e.toString().contains('-2') &&
            e.toString().contains('-3') &&
            e.toString().contains('-5'))),
      );
    });
  });
}