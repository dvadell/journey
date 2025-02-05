import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditJournalEntryScreen extends StatefulWidget {
  @override
  _EditJournalEntryScreenState createState() => _EditJournalEntryScreenState();
}

class _EditJournalEntryScreenState extends State<EditJournalEntryScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  String _selectedMood = 'Happy';
  
  // Map mood strings to actual Flutter icons
  Map<String, String> _moodIcons = {
    'Happy': 'assets/emoji-laugh.svg',
    'Cool': 'assets/emoji-cool.svg', 
    'Crazy': 'assets/emoji-crazy.svg',
    'Sad': 'assets/emoji-sad.svg',
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
    void _animateSelectedEmoji(BuildContext context) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Mood set to ${_selectedMood}'),
          duration: Duration(milliseconds: 800),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }

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
                  onTap: () {
                    setState(() => _selectedMood = entry.key);
                    // Visual feedback
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Selected mood: ${entry.key}'),
                        duration: Duration(seconds: 1),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    _animateSelectedEmoji(context);
                  },
                  child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: _selectedMood == entry.key 
                          ? Border(bottom: BorderSide(color: Theme.of(context).primaryColor, width: 3))
                          : null,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Transform.scale(
                        scale: _selectedMood == entry.key ? 1.2 : 1.0,
                        child: SvgPicture.asset(
                          entry.value,
                          height: 40,
                        ),
                      ),
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

