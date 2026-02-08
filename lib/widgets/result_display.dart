import 'package:flutter/material.dart';

class ResultDisplay extends StatelessWidget {
  final String result;
  final bool hasError;

  const ResultDisplay({
    super.key,
    required this.result,
    required this.hasError,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: hasError
            ? Theme.of(context).colorScheme.errorContainer
            : Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: hasError
              ? Theme.of(context).colorScheme.error
              : Theme.of(context).colorScheme.primary,
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                hasError ? Icons.error_outline : Icons.check_circle_outline,
                color: hasError
                    ? Theme.of(context).colorScheme.error
                    : Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                hasError ? 'Error' : 'Result',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: hasError
                      ? Theme.of(context).colorScheme.error
                      : Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            result,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: hasError
                  ? Theme.of(context).colorScheme.onErrorContainer
                  : Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}