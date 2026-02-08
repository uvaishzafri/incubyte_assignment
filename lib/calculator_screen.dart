import 'package:flutter/material.dart';
import 'package:string_calculator_tdd/string_calculator.dart';
import 'package:string_calculator_tdd/widgets/example_card.dart';
import 'package:string_calculator_tdd/widgets/result_display.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController _controller = TextEditingController();
  final StringCalculator _calculator = StringCalculator();
  String _result = '';
  bool _hasError = false;

  void _calculate() {
    setState(() {
      try {
        final input = _controller.text;
        final sum = _calculator.add(input);
        _result = sum.toString();
        _hasError = false;
      } catch (e) {
        _result = e.toString().replaceAll('Exception: ', '');
        _hasError = true;
      }
    });
  }

  void _clear() {
    setState(() {
      _controller.clear();
      _result = '';
      _hasError = false;
    });
  }

  void _setExample(String example) {
    setState(() {
      _controller.text = example;
      _result = '';
      _hasError = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primaryContainer,
              Theme.of(context).colorScheme.secondaryContainer,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // App Bar
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.calculate_rounded,
                        color: Theme.of(context).colorScheme.onPrimary,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'String Calculator',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        Text(
                          'TDD Kata Implementation',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Main Content
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Input Field
                          Text(
                            'Enter Numbers',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: _controller,
                            maxLines: 3,
                            decoration: InputDecoration(
                              hintText: 'e.g., 1,2,3 or //;\\n1;2',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              filled: true,
                              fillColor: Theme.of(context)
                                  .colorScheme
                                  .surfaceVariant,
                              prefixIcon: const Icon(Icons.edit_note_rounded),
                            ),
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Courier',
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Buttons
                          Row(
                            children: [
                              Expanded(
                                child: FilledButton.icon(
                                  onPressed: _calculate,
                                  icon: const Icon(Icons.play_arrow_rounded),
                                  label: const Text('Calculate'),
                                  style: FilledButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              FilledButton.tonalIcon(
                                onPressed: _clear,
                                icon: const Icon(Icons.clear_rounded),
                                label: const Text('Clear'),
                                style: FilledButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                    horizontal: 20,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),

                          // Result Display
                          if (_result.isNotEmpty)
                            ResultDisplay(
                              result: _result,
                              hasError: _hasError,
                            ),

                          const SizedBox(height: 32),

                          // Examples Section
                          Text(
                            'Try These Examples',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),

                          ExampleCard(
                            title: 'Basic Numbers',
                            example: '1,2,3,4,5',
                            description: 'Comma-separated numbers',
                            expectedResult: '15',
                            onTap: () => _setExample('1,2,3,4,5'),
                          ),

                          ExampleCard(
                            title: 'With Newlines',
                            example: '1\\n2,3',
                            description: 'Mix of newlines and commas',
                            expectedResult: '6',
                            onTap: () => _setExample('1\n2,3'),
                          ),

                          ExampleCard(
                            title: 'Custom Delimiter',
                            example: '//;\\n1;2;3',
                            description: 'Using semicolon as delimiter',
                            expectedResult: '6',
                            onTap: () => _setExample('//;\n1;2;3'),
                          ),

                          ExampleCard(
                            title: 'Negative Numbers',
                            example: '1,-2,3',
                            description: 'Should throw an error',
                            expectedResult: 'Error',
                            isError: true,
                            onTap: () => _setExample('1,-2,3'),
                          ),

                          const SizedBox(height: 32),

                          // Footer
                          Center(
                            child: Column(
                              children: [
                                Text(
                                  'Built with TDD ❤️',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(0.6),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Incubyte Assessment',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}