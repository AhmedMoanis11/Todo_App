import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_finish4/layout/cubitsc.dart';
import 'package:todo_finish4/layout/states.dart';

import 'buildtask.dart';

class Homesc extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitScreen,AppStates>(
      listener: (context,state){

      },
      builder: (context,state){
        return ListView.separated(itemBuilder:(context,index)
        {
          return buildTask(CubitScreen.get(context).Newtasks[index],context);
        }
            , separatorBuilder:(context,index)
            {
              return Container(
                width: 5.0,
                height: 5.0,
                color: Colors.grey.shade300,
              );
            },
            itemCount:CubitScreen.get(context).Newtasks.length );
      },

    );
  }
}
