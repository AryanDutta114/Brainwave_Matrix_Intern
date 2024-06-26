import 'package:flutter/material.dart';
import 'news_feed.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<String> menuItems = [
      'Business',
      'Entertainment',
      'General',
      'Health',
      'Science',
      'Sports',
      'Technology'
    ];

    void onMenuItemSelected(String item) {
      print('Selected: $item');
    }

    return Scaffold(
      body:  Newsfeed(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(child: Text("News Reader")),
        leading: PopupMenuButton<String>(
          icon: Icon(Icons.menu),
          onSelected: onMenuItemSelected,
          itemBuilder: (BuildContext context) {
            return menuItems.map((String item) {
              return PopupMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList();
          },
        ),
        backgroundColor: Colors.red,
        elevation: 0,
      ),
    );
  }
}
