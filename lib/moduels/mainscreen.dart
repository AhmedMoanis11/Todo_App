import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_finish4/layout/cubitsc.dart';
import 'package:todo_finish4/layout/states.dart';

class mainnn extends StatelessWidget {
  var scafold = GlobalKey<ScaffoldState>();
  var Textcontrol = TextEditingController();
  var timecontrol = TextEditingController();
  var datecontrol = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CubitScreen()..CreateDatabase(),
      child: BlocConsumer<CubitScreen, AppStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          return Scaffold(
            key: scafold,
            appBar: AppBar(
              backgroundColor: Colors.purple,
              title: Center(
                child: Text(
                  CubitScreen.get(context).appbar[CubitScreen.get(context).current],
                  style: TextStyle(
                    fontSize: 30.0,
                  ),
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.purple,
              onPressed: () {
                if(CubitScreen.get(context).isshown)
                  {
                    CubitScreen.get(context).IsnertDatabase(title: Textcontrol.text, data: datecontrol.text, time: timecontrol.text);
                    Navigator.pop(context);
                    CubitScreen.get(context).changeicon(ico: Icons.add, isshow:false);
                  }
                else
                  {
                    scafold.currentState?.showBottomSheet((context)
                    => Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: Textcontrol,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: 'Text Ttile',
                              prefixIcon: Icon(
                                Icons.title,
                              ),
                            ),

                          ),
                          TextFormField(
                            controller: timecontrol,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: 'Time Ttile',
                              prefixIcon: Icon(
                                Icons.timelapse_outlined,
                              ),
                            ),
                            onTap: ()
                            {
                              showTimePicker(context: context, initialTime: TimeOfDay.now()).
                              then((value) {
                                timecontrol.text=value!.format(context).toString();
                              });
                            },

                          ),
                          TextFormField(
                            controller: datecontrol,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: 'Date Ttile',
                              prefixIcon: Icon(
                                  Icons.date_range
                              ),
                            ),
                            onTap: ()
                            {
                              showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(),
                                  lastDate: DateTime.parse('2023-09-21')).then((value) {
                                datecontrol.text=DateFormat.yMMMd().format(value!);
                              });
                            },

                          ),
                      ],
                      ),
                    ),
                    );
                    CubitScreen.get(context).changeicon(ico: Icons.arrow_drop_down, isshow: true);

                  }


              },
              child: Icon(
                CubitScreen.get(context).iconn,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: CubitScreen
                  .get(context)
                  .current,
              onTap: (value) {
                CubitScreen.get(context).ChangeBottom(value);
              },

              items: [
                BottomNavigationBarItem(
                  label: "Home",
                  icon: Icon(
                    Icons.home,
                  ),
                ),
                BottomNavigationBarItem(
                  label: "Done",
                  icon: Icon(
                    Icons.check_circle_outline,
                  ),
                ),
                BottomNavigationBarItem(
                  label: "Archeive",
                  icon: Icon(
                    Icons.archive,
                  ),
                ),
              ],
            ),
            body: CubitScreen.get(context).screen[CubitScreen.get(context).current],
          );
        },
      ),
    );
  }
}
