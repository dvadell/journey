import 'package:flutter/material.dart';

class JournalEntryCard extends StatelessWidget {
  final DateTime date;
  final String text;
  final String mood;

  const JournalEntryCard({
    Key? key,
    required this.date,
    required this.text,
    required this.mood,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${date.day}/${date.month}/${date.year}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              text,
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 8),
            Icon(
              mood == 'happy' ? Icons.sentiment_very_satisfied : 
                  mood == 'neutral' ? Icons.sentiment_neutral : 
                  mood == 'sad' ? Icons.sentiment_dissatisfied : 
                  Icons.question_mark,
              size: 32,
            ),
          ],
        ),
      ),
    );
  }
}

