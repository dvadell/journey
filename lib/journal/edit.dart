import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class EditJournalEntryScreen extends StatefulWidget {
  @override
  _EditJournalEntryScreenState createState() => _EditJournalEntryScreenState();
}

class _EditJournalEntryScreenState extends State<EditJournalEntryScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  String _selectedMood = 'Happy';
  
  // Map mood strings to actual Flutter icons
  Map<String, IconData> _moodIcons = {
    'Happy': Icons.sentiment_very_satisfied,
    'Neutral': Icons.sentiment_neutral,
    'Sad': Icons.sentiment_very_dissatisfied,
  };

  late Database _database;

  @override
  void initState() {
    super.initState();
    initializeDatabase();
  }

  Future<void> initializeDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'journal_database.db'),
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE entries (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            date TEXT NOT NULL,
            mood TEXT NOT NULL,
            content TEXT NOT NULL
          )
        ''');
      },
      version: 1,
    );
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
            Text(DateFormat('yyyy-MM-dd').format(DateTime.now())),
            
            // Mood selection
            SizedBox(height: 20),
            Text(
              'Mood',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Row(
              children: _moodIcons.entries.map((entry) {
                return GestureDetector(
                  onTap: () => setState(() => _selectedMood = entry.key),
                  child: Icon(
                    entry.value,
                    size: 40,
                    color: _selectedMood == entry.key ? Colors.blue : Colors.grey[300],
                  ),
                );
              }).toList(),
            ),
            
            SizedBox(height: 20),
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(hintText: 'Enter your journal entry'),
              maxLines: null,
            ),
            
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await saveEntry(context);
              },
              child: Text('Save Entry'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveEntry(BuildContext context) async {
    try {
      await _database.transaction((txn) async {
        await txn.rawInsert('''
          INSERT INTO entries (date, mood, content)
          VALUES (?, ?, ?)
        ''', [
          DateFormat('yyyy-MM-dd').format(DateTime.now()),
          _selectedMood,
          _textEditingController.text
        ]);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Entry saved successfully')),
      );
    } catch (e) {
      print('Error saving entry: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save entry')),
      );
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}

