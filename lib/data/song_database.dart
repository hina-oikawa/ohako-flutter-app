import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:ohako/model/song.dart';

class SongDatabase {
  // シングルトンパターンのためのプライベートコンストラクター
  SongDatabase._privateConstructor();

  // インスタンスのキャッシュ
  static final SongDatabase _instance = SongDatabase._privateConstructor();

  // インスタンスへのアクセスを提供するプロパティ
  static SongDatabase get instance => _instance;

  // データベースのファイルパス
  static const String _databaseName = 'song_database.db';

  // データベースのテーブル名
  static const String _tableName = 'songs';

  // データベースの初期化済みフラグ
  static bool _initialized = false;

  // データベース
  late Database _database;

  Future<Database> open() async {
    // データベースを開く処理
    _database = await openDatabase(
      join(await getDatabasesPath(), _databaseName),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $_tableName(id INTEGER PRIMARY KEY, title TEXT, iconImagePath TEXT, artists TEXT)',
        );
      },
      version: 1,
    );
    return _database;
  }

  // データ追加
  Future<void> insertSong(Song song) async {
    await _database.insert(
      'songs',
      song.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // データ取得
  // 全曲取得
  Future<List<Song>> getSongs() async {
    final List<Map<String, dynamic>> maps = await _database.query('songs');
    return List.generate(maps.length, (i) {
      return Song.fromMap(maps[i]);
    });
  }

  // データ更新
  Future<void> updateSong(Song song) async {
    await _database.update(
      'songs',
      song.toMap(),
      where: 'id = ?',
      whereArgs: [song.id],
    );
  }

  // データ削除
  Future<void> deleteSong(int id) async {
    await _database.delete(
      'songs',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}