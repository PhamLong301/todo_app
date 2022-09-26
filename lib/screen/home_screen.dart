import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_list_model.dart';

import '../widget/todo_list_widget.dart';
enum FilterOptions { AZ, All, UnDone }
class HomeScreen extends StatefulWidget {
   HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  var _showAZ = false;
  var _UnDone = false;


  final todosList = ToDoModel.todoList();
  final _todoController = TextEditingController();
  List<ToDoModel> _foundToDo = [];

  @override
  void initState(){
    _foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Todo List'),
        backgroundColor: const Color(0xff000000),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                sort();
              },
              icon: Icon(
                  Icons.sort
              ))
        ],
      ),
      body: Stack(
        children: [
          Container(
            //padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50, bottom: 20),
                        child: Text('Todo List',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),),
                      ),

                      for(ToDoModel todoo in _foundToDo.reversed)
                        TodoItem(todo: todoo,
                        onToDoChange: _handleToDoChange,
                        onDeleteItem: _deleteTodoItem,),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(child: Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                    left: 20,
                    right: 20,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    gradient: LinearGradient(colors: [
                      Colors.red, Colors.cyan
                    ]),
                    boxShadow: const [BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 0.0),
                      blurRadius: 10.0,
                      spreadRadius: 0.0
                    )],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _todoController,
                    decoration: InputDecoration(
                      hintText: 'Add new todo item',
                      border: InputBorder.none,
                    ),
                  ),
                )),
                Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                  ),
                  child: ElevatedButton(
                    child: Text('+', style: TextStyle(fontSize: 40),),
                    onPressed: () {
                      _addToDoItem(_todoController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff000000),
                      minimumSize: Size(60, 60),
                      elevation: 10,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
//chuc nang kiem tra hoat dong ghi chu da hoan thanh hay chua
  void _handleToDoChange(ToDoModel todo){
    setState(() {
      todo.isDone = !todo.isDone;
    });

  }
 //chuc nang xoa ghi chú
  void _deleteTodoItem(String id){
    setState(() {
      todosList.removeWhere((item) => item.id == id);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Nội dung ghi chú đã được xóa"),
        duration: Duration(seconds: 1),
      ));
    });

  }
  void sort(){
    setState(() {
      _foundToDo.sort((a, b) => a.todoText.compareTo(b.todoText),);
    });
  }
//chuc nang them ghi chu
  void _addToDoItem(String toDo){
    setState(() {
      if(toDo.isEmpty){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Ghi chú của bạn không có nội dung"),
          duration: Duration(seconds: 1),
        ));
      }else{
        todosList.add(ToDoModel(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          todoText: toDo,
        ));
      }
    });
    _todoController.clear();
  }
 //chuc nang sua noi dung

  void _editContent(ToDoModel toDo){
    setState(() {
      final index = _foundToDo.indexWhere(
            (element) => element!.id == toDo.id,
      );
      _foundToDo[index] = toDo;
    });
  }

//chuc nang tim kiem
  void _runFillter(String enteredKeyword){
    List<ToDoModel> result = [];
    if(enteredKeyword.isEmpty){
      result = todosList;
    }else{
      result =todosList.where((item) => item.todoText!.toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
    }

    setState(() {
      _foundToDo = result;
    });
  }


  Widget searchBox(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFillter(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(
              color: Colors.grey
          ),
        ),
      ),
    );
  }
}

