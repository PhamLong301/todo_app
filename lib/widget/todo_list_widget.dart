import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_list_model.dart';

class TodoItem extends StatelessWidget {
  final ToDoModel todo;
  final onToDoChange;
  final onDeleteItem;
  const TodoItem({Key? key, required this.todo, required this.onToDoChange, required this.onDeleteItem,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      color: Color(0xfff0f8ff),
      child: ListTile(
        onTap: () {
          print('Checking ....!!!',);
          onToDoChange(todo);
        },
        onLongPress: () {

        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: Icon(
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          //Icons.check_box
        ),
        title: Text(
          '${todo.todoText}',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,

            decoration: todo.isDone? TextDecoration.lineThrough : null,

          //decoration: TextDecoration.lineThrough,
          ),
        ),
        trailing: Container(
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.symmetric(vertical: 5),
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(5),
              gradient: LinearGradient(colors: [
                Colors.red, Colors.black12
              ])
            ),

            child:IconButton(
              color: Colors.white,
              iconSize: 18,
              icon: Icon( Icons.delete),
              onPressed: () {
                print('Checking Delete....!!!',);
                onDeleteItem(todo.id);
              },
            )
        ),
      ),
    );
  }
}

