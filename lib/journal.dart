import 'package:flutter/material.dart';
import 'new_screen.dart'; // Import the new screen file

class JournalContent extends StatefulWidget {
  @override
  _JournalContentState createState() => _JournalContentState();
}

class _JournalContentState extends State<JournalContent> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: 3, // Number of journal entries
              itemBuilder: (context, index) => Card(
                elevation: 4,
                margin: EdgeInsets.all(8),
                child: ListTile(
                  title: Text('Date'), // Placeholder for date
                  subtitle: Text('Preview text'), // Placeholder for preview text
                  trailing: Icon(Icons.sentiment_satisfied), // Smiley face icon
                ),
              ),
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NewScreen()));
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

