import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

late Database database;

crateDataBase() async {
// Get a location using getDatabasesPath
  var databasesPath = await getDatabasesPath();
  print(databasesPath);
  String path = join(databasesPath, "todo.db");
  print(path);

// open the database
  database = await openDatabase(path, version: 1,
      // crate table
      onCreate: (Database db, int version) async {
    // When creating the db, create the table
    await db
        .execute(
            'CREATE TABLE Task (id INTEGER PRIMARY KEY, title TEXT, time TEXT, date TEXT ,status TEXT)')
        .then((value) {
      print("table crated");
    });
  }, onOpen: (database) {
    print("hello table ");
    getDataBase(database);
  });
}

insertDataBase({
  String? title,
  String? time,
  String? date,
}) {
  database.transaction((txn) async {
    await txn
        .rawInsert(
            'INSERT INTO Task (title, time, date, status) VALUES("$title" , "$time", "$date", "notDone")')
        .then((value) {
      print("$value inserted Successfully");
      getDataBase(database);
    }).catchError((error) {
      print(error);
    });
  });
}

updateDatabase({String? title, String? time, String? date, int? id}) {
  database.rawUpdate(
      'UPDATE Task SET title = ?, time = ? ,date = ?  WHERE id = ?',
      [title, time, date, id]).then((value) {
    print("$value is updated");
    getDataBase(database);
  });
}

updateStatus({String? status, int? id}) {
  database.rawUpdate('UPDATE Task SET status = ?  WHERE id = ?', [status]).then(
      (value) {
    print("$value status is updated");
    getDataBase(database);
  });
}

// crud
deleteDataBase({int? id}) {
  database.rawDelete('DELETE FROM Test WHERE id = ?', [id]).then((value) {
    print("$value is deleted ");
    getDataBase(database);
  });
}

List<Map> tasksList = [];
List<Map> doneTasks = [];
getDataBase(Database dataBase) {
  dataBase.rawQuery('SELECT * FROM Task').then((value) {
    for (Map<String, Object?> element in value) {
      tasksList.add(element);
      if (element['status'] == "Done") {
        doneTasks.add(element);
      }
    }
  }).catchError((error) {
    print(error);
  });
}

Future addDataLocally({title, time, date}) async {
  final db = await database;
  await db.insert('Task', {'title': title, 'time': time, 'date': date});
  print("${(title, time, date)} Is Added");
  return 'added';
}

// class LocalDatabaseHelper {
//   static final LocalDatabaseHelper _instance = LocalDatabaseHelper._internal();
//
//   factory LocalDatabaseHelper() => _instance;
//
//   LocalDatabaseHelper._internal();
//
//   Database? _database;
//
//   Future<Database> get database async {
//     if (_database != null) {
//       return _database!;
//     }
//
//     _database = await _initDatabase();
//     return _database!;
//   }
//
//   Future<Database> _initDatabase() async {
//     final databasesPath = await getDatabasesPath();
//     final path = '$databasesPath/my_local_database.db';
//
//     return await openDatabase(path, version: 1, onCreate: _onCreate);
//   }
//
//   Future<void> _onCreate(Database db, int version) async {
//     await db.execute(
//         'CREATE TABLE IF NOT EXISTS Task (id INTEGER PRIMARY KEY, title TEXT, time TEXT, date TEXT ,status TEXT)');
//   }
//
//   Future<String> insertValue(
//       {required String title,
//       required String time,
//       required String date}) async {
//     final db = await database;
//     await db.insert('Task', {'title': title, 'time': time, 'date': date});
//     print("${(title, time, date)} Is Added");
//     return 'added';
//   }
// }
