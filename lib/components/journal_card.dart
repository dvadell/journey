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
    // Get screen width
    double screenWidth = MediaQuery.of(context).size.width;
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          date.day.toString(),
                          style: TextStyle(
                            fontSize: screenWidth * 0.09,  // 48
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          _getMonthName(),
                          style: TextStyle(
                            fontSize: screenWidth * 0.05, // 30
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      _getDayName(),
                      style: TextStyle(
                        fontSize: screenWidth * 0.04, // 28
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
                Icon(
                  _getMoodIcon(),
                  size: 32,
                  color: Colors.amber,
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              text,
              style: TextStyle(fontSize: 14),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  String _getMonthName() {
    return ['January', 'February', 'March', 'April', 'May', 'June',
            'July', 'August', 'September', 'October', 'November', 'December']
           [date.month - 1];
  }

  String _getDayName() {
    return ['Mon', 'Tues', 'Wed', 'Thurs', 'Fri', 'Sat', 'Sun']
           [date.weekday - 1];
  }

  IconData _getMoodIcon() {
    switch (mood.toLowerCase()) {
      case 'happy':
        return Icons.sentiment_very_satisfied;
      case 'neutral':
        return Icons.sentiment_neutral;
      case 'sad':
        return Icons.sentiment_dissatisfied;
      default:
        return Icons.sentiment_neutral;
    }
  }
}

