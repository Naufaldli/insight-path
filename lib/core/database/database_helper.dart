import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('insight_path.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  // Membuat tabel struktur jurnal sesuai kebutuhan aplikasi kita
  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE journals (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT NOT NULL,
        time TEXT NOT NULL,
        content TEXT NOT NULL,
        mood TEXT NOT NULL,
        emoji TEXT NOT NULL
      )
    ''');
  }

  // Fungsi untuk menyimpan jurnal baru
  Future<int> insertJournal(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('journals', row);
  }

  // Fungsi untuk mengambil semua data jurnal (diurutkan dari yang terbaru)
  Future<List<Map<String, dynamic>>> fetchAllJournals() async {
    final db = await instance.database;
    return await db.query('journals', orderBy: 'id DESC');
  }

  Future close() async {
    final db = _database; 
    if (db != null) await db.close();
  }
}