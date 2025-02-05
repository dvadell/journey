import 'package:flutter/material.dart';
import 'themes.dart';

// Importing necessary widgets and components
import 'journal.dart';
import 'calendar.dart';
import 'quotes.dart';
import 'pictures.dart';
import 'menu.dart';

class JournalHome extends StatefulWidget {
  @override
  _JournalHomeState createState() => _JournalHomeState();
}

class _JournalHomeState extends State<JournalHome> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isDarkMode = false;

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

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  // Build method to construct the UI
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: AppBar(
            automaticallyImplyLeading: false,
            titleSpacing: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.menu, color: Colors.white),
                  onPressed: () => _showMenu(context),
                ),
                Text('Welcome Back!'),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
                      onPressed: _toggleTheme,
                    ),
                    IconButton(
                      icon: Icon(Icons.notifications),
                      onPressed: () {
                        // Handle notifications
                      },
                    ),
                  ],
                ),
              ],
            ),
            bottom: TabBar(
              controller: _tabController,
              tabs: [
                Tab(text: 'Journal'),
                Tab(text: 'Calendar'), 
                Tab(text: 'Quotes'),
                Tab(text: 'Pictures'),
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
          ],
        ),
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
