import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'components/journal_card.dart';
import 'journal/edit.dart'; // Import the new screen file

class JournalContent extends StatefulWidget {
  @override
  _JournalContentState createState() => _JournalContentState();
}

class _JournalContentState extends State<JournalContent> {
  final List<JournalEntry> journalEntries = [];

  @override
  void initState() {
    super.initState();
    fetchJournalEntries();
  }

  Future<void> fetchJournalEntries() async {
    // Open the database and fetch entries
    var db = await openDatabase(
      join(await getDatabasesPath(), 'journal_database.db'),
      version: 1,
    );

    List<Map<String, dynamic>> entries = await db.rawQuery('SELECT * FROM entries ORDER BY date DESC');
    
    setState(() {
      journalEntries.clear();
      for (var entry in entries) {
        print('DMV: Adding entry');
        try {
          journalEntries.add(
            JournalEntry(
              date: DateTime.parse(entry['date']),
              text: entry['content'],
              mood: entry['mood'].toLowerCase(),
            ),
          );
        } catch (e) {
          print('DMV: invalid entry $entry: $e');
        };
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 16.0),
            child: Text(
              "Recent entries",
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
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

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Container(
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

