// This is a Flutter application
import 'package:flutter/material.dart';

// Importing necessary widgets and components
import 'journal.dart';
import 'calendar.dart';
import 'quotes.dart';
import 'pictures.dart';

// Import the new menu screen
import 'menu.dart';

class JournalHome extends StatefulWidget {
  @override
  _JournalHomeState createState() => _JournalHomeState();
}

class _JournalHomeState extends State<JournalHome> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  void _showMenu(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return MenuScreen();
      },
    );
  }

  // Initialize the tab controller in the initState method
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  // Dispose of the tab controller when the widget is disposed
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Build method to construct the UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.purple,
          titleSpacing: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.menu, color: Colors.white),
                onPressed: () => _showMenu(context),
              ),
              Text('Welcome Back!', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  // Handle notifications
                },
              ),
            ],
          ),
          bottom: TabBar(
            controller: _tabController,
            tabs: [
                Tab(child: Text('Journal', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16))),
                Tab(child: Text('Calendar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16))),
                Tab(child: Text('Quotes', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16))),
                Tab(child: Text('Pictures', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16))),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          JournalContent(),
          CalendarContent(),
          QuotesContent(),
          PicturesContent(),
          MenuScreen(), // New screen for the menu
        ],
      ),
    );
  }
}
class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Text('This is a dummy menu screen.'),
      ),
    );
  }
}
