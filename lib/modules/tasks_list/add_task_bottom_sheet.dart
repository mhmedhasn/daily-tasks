import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/Task1.dart';
import 'package:todo_app/shared/components/ui_utils.dart';
import 'package:todo_app/shared/network/local/firebase_.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  GlobalKey<FormState> key1 = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  static DateTime SelectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            'Add new Task',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            height: 15,
          ),
          Form(
              key: key1,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'please enter your task title';
                      }
                      return null;
                    },
                    controller: titleController,
                    decoration: InputDecoration(
                      label: Text('enter your task title'),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'please enter your task title';
                      }

                      return null;
                    },
                    controller: descriptionController,
                    decoration: InputDecoration(
                      label: Text('enter your task details'),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      sheewDateTime();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Select time',
                            style: Theme.of(context).textTheme.headline1),
                        Text(
                            '${SelectedDate.year}/${SelectedDate.month}/${SelectedDate.day} ',
                            style: Theme.of(context).textTheme.headline1)
                      ],
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (key1.currentState!.validate()) {
                          Task task = Task(
                              title: titleController.text,
                              description: descriptionController.text,
                              date: DateUtils.dateOnly(SelectedDate)
                                  .millisecondsSinceEpoch);
                          showLoging('Loding....', context);
                          addTaskToFirebase(task).then((value) => hideLoging(context));
                          Navigator.pop(context);

                          ///////////////////////
                          // showMessage(
                          //     context, 'The task was added successfully ', 'ok',
                          //     () {
                          //   Navigator.pop(context);
                          // });
                        }
                      },
                      child: Text('data')),
                  SizedBox(
                    height: 64.5,
                  ),
                  ButtonBar(
                    children: [],
                  )
                ],
              ))
        ],
      ),
    );
  }

  void sheewDateTime() async {
    DateTime? holdsdate = await showDatePicker(
        context: context,
        initialDate: SelectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (holdsdate == null) return;
    SelectedDate = holdsdate;
    setState(() {});
  }
}
