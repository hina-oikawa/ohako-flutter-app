import 'package:flutter/material.dart';
import 'main.dart';
import 'package:ohako/model/song.dart';
import 'package:ohako/data/song_database.dart';

class OhakoDetailsScreen extends StatefulWidget {
  final Song? song;

  OhakoDetailsScreen({required this.song});

  @override
  _OhakoDetailsScreenState createState() => _OhakoDetailsScreenState();
}

class _OhakoDetailsScreenState extends State<OhakoDetailsScreen> {

  String _title = '';
  String _artist = '';
  final List<String> _singers = [];

  @override
  void initState() {
    super.initState();
    _title = widget.song?.title ?? '';
    _artist = widget.song?.artist ?? '';
    _singers.addAll(widget.song?.singers ?? []);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.song?.title ?? 'New Song'),
        actions: [
          IconButton(
            onPressed: () {
              _saveSong();
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            decoration: const InputDecoration(labelText: '曲名'),
            onChanged: (value) {
              _title = value;
            },
          ),
          const SizedBox(height: 20),
          TextField(
            decoration: const InputDecoration(labelText: 'アーティスト名'),
            onChanged: (value) {
              _artist = value;
            },
          ),
          const SizedBox(height: 20),
          const Text('歌い手'),
          const SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            itemCount: _singers.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: TextFormField(
                  initialValue: _singers[index],
                  onChanged: (value) {
                    _singers[index] = value;
                  },
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _singers.add('');
              });
            },
            child: const Text('歌い手を追加'),
          ),
        ],
      ),
    );
  }

  Future<void> _saveSong() async {

    final Song newSong = Song(
      id: null,
      title: _title,
      artist: _artist,
      singers: _singers,
    );

    if (widget.song != null) {
      // Update existing song
      final updatedSong = widget.song!.copyWith(title: _title, artist: _artist, singers: _singers);
      await SongDatabase.instance.updateSong(updatedSong);
    } else {
      // Insert new song
      await SongDatabase.instance.insertSong(newSong);
    }

    // Navigate back
    Navigator.pop(context, true);
  }
}