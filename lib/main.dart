import 'package:flutter/material.dart';
import 'package:ohako/ohako_details.dart';
import 'package:ohako/model/song.dart';
import 'package:ohako/data/song_database.dart'; // SongDatabaseを含むファイルをインポート

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SongDatabaseの初期化
  await SongDatabase.instance.open();
  runApp(const MyApp());
}

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
      body: FutureBuilder<List<Song>>(
        future: SongDatabase.instance.getSongs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No songs found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Song song = snapshot.data![index];
                return ListTile(
                  title: Text(song.title),
                  subtitle: Text(song.singers.join(', ')),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OhakoDetailsScreen(song: song),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // フローティングアクションボタンが押されたときの処理
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OhakoDetailsScreen(song: null), // 十八番詳細画面に遷移
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}