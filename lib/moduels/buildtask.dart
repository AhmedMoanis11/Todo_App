import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_finish4/layout/cubitsc.dart';

Widget buildTask (Map modell,context)
{
  return Dismissible(
    key: Key(modell['id'].toString()),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
         CircleAvatar(
           backgroundColor: Colors.purple,
           radius: 43.0,
           child: Text(
             "${modell['time']}",
           ),
         ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${modell['title']}',
                  style: TextStyle(
                    fontSize: 30.0
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  '${modell['data']}',
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          IconButton(onPressed: ()
              {
            CubitScreen.get(context).UpdateApp(status: 'done', id:modell['id'] );

              }, icon:Icon(
            Icons.check_box_sharp,
            color: Colors.green,
          ), ),
          SizedBox(
            width: 10.0,
          ),
          IconButton(onPressed: ()
              {
                CubitScreen.get(context).UpdateApp(status: 'Archived', id:modell['id'] );

              }, icon:Icon(
            Icons.archive,
          ), ),
        ],
      ),
    ),
    onDismissed: (direcation)
    {
      CubitScreen.get(context).DeletApp(id: modell['id']);
    },
  );
}