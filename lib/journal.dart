import 'package:flutter/material.dart';
import 'new_screen.dart'; // Import the new screen file

class JournalContent extends StatelessWidget {
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
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => NewScreen()));
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              primary: Colors.blue,
            ),
            child: Text('Add Entry'),
          ),
        ],
      ),
    );
  }
}
