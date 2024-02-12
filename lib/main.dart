import 'package:flutter/material.dart';
import 'package:ohako/ohako_details.dart';

void main() {
  runApp(const MyApp());
}

class Song {
  // 曲名
  final String title;
  // 歌い手名の配列
  final List<String> singers;

  Song({
    required this.title,
    required this.singers,
  });
}

// 仮データを定義
// 今後はローカルDBからデータを取得する処理に変更
final List<Song> song = [
  Song(
    title: '曲名１',
    singers: ['歌い手A', '歌い手B', '歌い手C', '歌い手D'],
  ),
  Song(
    title: '曲名２',
    singers: ['歌い手A', '歌い手B', '歌い手C'],
  ),
  Song(
    title: '曲名３',
    singers: ['歌い手B', '歌い手D'],
  ),
  Song(
    title: '曲名４',
    singers: ['歌い手A', '歌い手C'],
  ),
];

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Brightness _brightness = Brightness.values[1];
    return const MaterialApp(
      home: OhakoList(),
    );
  }
}

class OhakoList extends StatefulWidget {
  const OhakoList({Key? key}) : super(key: key);

  @override
  _OhakoListState createState() => _OhakoListState();
}

class _OhakoListState extends State<OhakoList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ohako List'),
      ),
      body: ListView.builder(
        itemCount: song.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: const Icon(
                Icons.music_note,
                size: 50, // アイコンのサイズを48に設定
                color: Colors.blue, // アイコンの色を青に設定
              ),
              // 曲名
              title: Text(song[index].title),
              // 歌い手名 ※文字結合
              subtitle: Text(song[index].singers.join(", ")),
              onTap: () {
                // ListTileをタップしたとき、十八番詳細画面に遷移する
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    // ここで十八番情報を渡す
                    builder: (context) => OhakoDetailsScreen(song: song[index]),
                  ),
                );
              },
              isThreeLine: true,
              // dense: true,
            ),
          );
        },
      ),
    );
  }
}