import 'package:flutter/material.dart';

class JournalContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        itemCount: 3, // Number of journal entries
        itemBuilder: (context, index) => Card(
          elevation: 4,
          margin: EdgeInsets.all(8),
          child: ListTile(
            title: Text('Date'), // Placeholder for date
            subtitle: Text('Preview text'), // Placeholder for preview text
            trailing: Icon(Icons.smile_o), // Smiley face icon
          ),
        ),
      ),
    );
  }
}
