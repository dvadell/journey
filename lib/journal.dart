import 'package:flutter/material.dart';
import 'journal/edit.dart'; // Import the new screen file
import 'components/journal_card.dart';

class JournalContent extends StatefulWidget {
  @override
  _JournalContentState createState() => _JournalContentState();
}

class _JournalContentState extends State<JournalContent> {
  final List<JournalEntry> journalEntries = [
    JournalEntry(date: DateTime(2023, 10, 1), text: "Today was a good day!", mood: "happy"),
    JournalEntry(date: DateTime(2023, 9, 30), text: "It's okay.", mood: "neutral"),
    JournalEntry(date: DateTime(2023, 9, 29), text: "Not so great.", mood: "sad"),
    JournalEntry(date: DateTime(2023, 9, 28), text: "It was a beautiful day with Fujii Kaze....", mood: "happy"),
    JournalEntry(date: DateTime(2023, 9, 27), text: "I met Fujii Kaze at the park.", mood: "happy"),
    JournalEntry(date: DateTime(2023, 9, 26), text: "Un dia fome.", mood: "neutral"),
    JournalEntry(date: DateTime(2023, 9, 25), text: "Not so great.", mood: "sad"),
    JournalEntry(date: DateTime(2023, 9, 24), text: "Tuve un dia genial!!! \o/.", mood: "happy"),
    JournalEntry(date: DateTime(2023, 9, 23), text: "Not so great.", mood: "neutral"),
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: journalEntries.length,
              itemBuilder: (context, index) {
                final entry = journalEntries[index];
                return JournalEntryCard(
                  date: entry.date,
                  text: entry.text,
                  mood: entry.mood,
                );
              },
            ),
          ),
          SizedBox(height: 20),
          // The circular + button
          Container(
            width: 56.0,
            height: 56.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.purple,
            ),
            child: Center(
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => EditJournalEntryScreen()));
                },
                child: Icon(Icons.add, size: 48, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class JournalEntry {
  final DateTime date;
  final String text;
  final String mood;

  JournalEntry({required this.date, required this.text, required this.mood});
}
