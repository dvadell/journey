import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';

class EditJournalEntryScreen extends StatefulWidget {
  @override
  _EditJournalEntryScreen createState() => _EditJournalEntryScreen();
}

class _EditJournalEntryScreen extends State<EditJournalEntryScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  String _selectedMood = 'Happy';

  // Map mood strings to actual Flutter icons
  Map<String, IconData> _moodIcons = {
    'Happy': Icons.sentiment_very_satisfied,
    'Neutral': Icons.sentiment_neutral,
    'Sad': Icons.sentiment_very_dissatisfied,
  };

  final LocalStorage storage = LocalStorage('journal_entries');

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Future<void> _saveEntry() async {
    final String text = _textEditingController.text;
    final DateTime date = DateTime.now();
    final String mood = _selectedMood;

    // Save the entry to localstorage
    await storage.setItem('entry', {'date': DateFormat.yMd().format(date), 'mood': mood, 'text': text});

    print('Saved journal entry - Date: $date, Mood: $mood, Text: $text');

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Journal Entry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Date field
            Text(
              'Date',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4.0),
            Text(
              DateFormat.yMd().format(DateTime.now()),
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),

            // Mood selection
            Text(
              'Mood',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4.0),
            DropdownButton<String>(
              value: _selectedMood,
              onChanged: (String? newValue) {
                setState(() {
                  if (newValue != null) {
                    _selectedMood = newValue;
                  }
                });
              },
              items: <String>['Happy', 'Neutral', 'Sad']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Row(
                    children: [
                      Icon(_moodIcons[value]!),
                      SizedBox(width: 8.0),
                      Text(value),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),

            // Journal text input
            Text(
              'Journal Entry',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4.0),
            TextField(
              controller: _textEditingController,
              maxLines: null,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Write about your day...',
              ),
            ),
            SizedBox(height: 20.0),

            // Save button
            ElevatedButton(
              onPressed: _saveEntry,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

