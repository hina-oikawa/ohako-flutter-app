class Song {
  // 曲のID
  final int? id;
  // 曲名
  final String title;
  // アーティスト名
  final String artist;
  // 歌い手名を格納する配列
  final List<String> singers;

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.singers,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'singers': singers.join(','), // 配列を文字列に変換して保存
    };
  }

  factory Song.fromMap(Map<String, dynamic> map) {
    return Song(
      id: map['id'],
      title: map['title'],
      artist: map['artist'],
      singers: map['singers'].split(','),
    );
  }

  // copyWithメソッドを実装
  Song copyWith({
    int? id,
    String? title,
    String? artist,
    List<String>? singers,
  }) {
    return Song(
      id: id ?? this.id,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      singers: singers ?? this.singers,
    );
  }
}
