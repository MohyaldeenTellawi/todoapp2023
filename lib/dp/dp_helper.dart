
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/models/task.dart';


class DpHelper{

  static Database? _dp;
  static const int _version = 1;
  static const String _tableName = 'tasks';

 static Future<void>  initDp() async {
   if(_dp!=null){
     debugPrint('not null dp');
     return;
   }
   else {
     try{
       String path = '${await getDatabasesPath()}task.dp';
       debugPrint('in database path');
       _dp = await openDatabase(path, version: _version,
           onCreate: (Database db, int version)
       async {
         await db.execute(
        'CREATE TABLE $_tableName ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT, '
        'title STRING, note TEXT, date STRING,'
        'startTime STRING, endTime STRING,'
        'remind INTEGER, repeat STRING,'
        'color INTEGER,'
        'isCompleted INTEGER)'
        ,
         );
       }
       );
        print('Database Created');
        }catch(e){
        print(e);
     }
   }
 }

 static Future<int> insert(Task? task) async{
   print('insert something');
   try{
     return await _dp!.insert(_tableName, task!.toJson());
   }catch(e){
     print('We are Here');
     return 9000;
   }
 }
  static Future<int> delete(Task task) async{
    print('Delete');
    return await _dp!.delete(_tableName,
    where: 'id = ?', whereArgs: [task.id]
    );
  }
  static Future<int> deleteAll() async{
    print('Delete All');
    return await _dp!.delete(_tableName);
  }
  static Future<List<Map<String, dynamic>>>query() async{
    print('query');
    return await _dp!.query(_tableName);
  }
  static Future<int> update(int id) async{
    print('Update');
    return await _dp!.rawUpdate('''
    UPDATE tasks 
    SET isCompleted = ?
    WHERE id = ?
    ''', [1,id]);
  }

}

