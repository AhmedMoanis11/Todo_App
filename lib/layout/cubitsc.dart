import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_finish4/layout/states.dart';

import '../moduels/archeive.dart';
import '../moduels/done.dart';
import '../moduels/home.dart';

class CubitScreen extends Cubit<AppStates> {
  CubitScreen() : super(IntialApp());

  static CubitScreen get(context) => BlocProvider.of(context);
  var current = 0;
  late Database database;

  List<Map> tasks = [];
  List<Map> Newtasks = [];
  List<Map> Donetasks = [];
  List<Map> Archivetasks = [];
  IconData iconn = Icons.add;
  bool isshown = false;
  List<Widget> screen = [
    Homesc(),
    donesc(),
    Archeivesc(),
  ];
  List<String> appbar = [
    'Home',
    'Done',
    'Archeive',
  ];
  void CreateDatabase()
  {
    openDatabase(
      'todossp.db',
      version: 1,
      onCreate: (database,version)
        {
          print('database created');
          database.execute('CREATE TABLE Taaskkss (id INTEGER PRIMARY KEY, title TEXT, data TEXT, time TEXT, status TEXT)').
          then((value) {
            print('table created');
          }).catchError((e){
            print('error from createdatabase');
          });
        },
      onOpen: (database)
        {

          print('database opened');
          Getdatabase(database);
        },
    ).then((value) {
      database=value;
      emit(AppCreateDatabase());
    });
  }
  void IsnertDatabase({
    required String title,
    required String data,
    required String time,
})
  {
    database.transaction((txn) async{
      
      await txn.rawInsert('INSERT INTO Taaskkss (title, data, time, status) VALUES ("$title", "$data", "$time", "New")').
      then((value) {
        print('$value Inserted successfully');
        emit(AppInsertDatabase());
        Getdatabase(database);
      }).catchError((e){
        print('error from Insert Database');
      });
      
    });
    
  }
  void Getdatabase(database)async
  {
    Newtasks=[];
    Donetasks=[];
    Archivetasks=[];

     await database.rawQuery('SELECT * FROM Taaskkss').then((value) {
       tasks=value;
       print(tasks);
       tasks.forEach((element) {
         if(element['status']=='New')
           {
             Newtasks.add(element);
           }
         else if(element['status']=='done')
         {
           Donetasks.add(element);
         }
         else
           {
             Archivetasks.add(element);
           }
       });
       emit(AppGetDatabase());
     });
  }
  void UpdateApp({
  required String status,
    required int id,
})async
  {
    await database.rawQuery('UPDATE Taaskkss SET status = ? WHERE id = ?',
        [status, id]).then((value) {
          Getdatabase(database);
       emit(UpdateAppState());
    });
  }
  void DeletApp({
    required int id,
})async
  {
    await database.rawDelete('DELETE FROM Taaskkss WHERE id = ?', [id]).then((value) {
          Getdatabase(database);
       emit(DeletAppState());
    });
  }


  void ChangeBottom(index) {
    current = index;
    emit(changeBottomshit());
  }

  void changeicon({
    required IconData ico,
    required bool isshow,
  }) {
    iconn = ico;
    isshown = isshow;
    emit(changeIcondata());
  }
}
