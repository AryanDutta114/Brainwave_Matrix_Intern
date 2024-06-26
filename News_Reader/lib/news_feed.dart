import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

Future<List<Map<String, String>>> getData() async {
  String apiKey = '83e9f47bf29a463da3963d403a0fcf68';
  String url = 'https://newsapi.org/v2/top-headlines?country=in&apiKey=$apiKey';

  List<Map<String, String>> newsList = [];

  try {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (var article in data['articles']) {
        newsList.add({
          'title': article['title'] ?? 'No Title',
          'description': article['description'] ?? 'No Description',
          'urlToImage': article['urlToImage'] ?? '',
        });
      }
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }

  return newsList;
}

class Newsfeed extends StatefulWidget {
  @override
  _NewsfeedState createState() => _NewsfeedState();
}

class _NewsfeedState extends State<Newsfeed> {
  late Future<List<Map<String, String>>> newsList;

  @override
  void initState() {
    super.initState();
    newsList = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Feed'),
      ),
      body: FutureBuilder<List<Map<String, String>>>(
        future: newsList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            return ListView.builder(
              scrollDirection: Axis.horizontal, // Enable horizontal scrolling
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var article = snapshot.data![index];
                return Container(
                  width: 300,
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      article['urlToImage']!.isNotEmpty
                          ? Image.network(article['urlToImage']!, width: 300, height: 200, fit: BoxFit.cover)
                          : Container(width: 300, height: 200, color: Colors.grey),
                      SizedBox(height: 10),
                      Text(
                        article['title']!,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(height: 5),
                      Text(article['description']!),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}