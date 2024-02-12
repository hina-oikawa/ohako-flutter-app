import 'package:flutter/material.dart';
import 'main.dart';

class OhakoDetailsScreen extends StatefulWidget {
  final Song song;

  OhakoDetailsScreen({required this.song});

  @override
  _OhakoDetailsScreenState createState() => _OhakoDetailsScreenState();
}

class _OhakoDetailsScreenState extends State<OhakoDetailsScreen> {
  List<String> artists = [];

  @override
  void initState() {
    super.initState();
    artists.addAll(widget.song.singers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.song.title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const TextField(
            decoration: InputDecoration(labelText: '曲名'),
          ),
          const SizedBox(height: 20),
          const Text('歌い手'),
          const SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            itemCount: artists.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: TextFormField(
                  initialValue: artists[index],
                  onChanged: (value) {
                    artists[index] = value;
                  },
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              setState(() {
                artists.add('');
              });
            },
            child: const Text('歌い手を追加'),
          ),
        ],
      ),
    );
  }
}