class StringCalculator {
  int add(String numbers) {
    if (numbers.isEmpty) {
      return 0;
    }

    final DelimiterInfo info = _extractDelimiter(numbers);
    final List<int> parsedNumbers = _parseNumbers(info);

    _validateNoNegatives(parsedNumbers);

    return parsedNumbers.reduce((a, b) => a + b);
  }

  DelimiterInfo _extractDelimiter(String numbers) {
    if (numbers.startsWith('//')) {
      final parts = numbers.split('\n');
      return DelimiterInfo(
        delimiter: parts[0].substring(2),
        numberString: parts[1],
      );
    }
    return DelimiterInfo(delimiter: ',', numberString: numbers);
  }

  List<int> _parseNumbers(DelimiterInfo info) {
    final normalized = info.numberString
        .replaceAll('\n', ',')
        .replaceAll(info.delimiter, ',');

    return normalized
        .split(',')
        .map((e) => int.parse(e.trim()))
        .toList();
  }

  void _validateNoNegatives(List<int> numbers) {
    final negatives = numbers.where((n) => n < 0).toList();
    if (negatives.isNotEmpty) {
      throw Exception(
          'negative numbers not allowed: ${negatives.join(', ')}');
    }
  }
}

class DelimiterInfo {
  final String delimiter;
  final String numberString;

  DelimiterInfo({required this.delimiter, required this.numberString});
}