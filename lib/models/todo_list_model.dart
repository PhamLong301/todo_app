


class ToDoModel {
  String? id;
  String? todoText;
  bool isDone;

  ToDoModel({
    required this.id,
    required this.todoText,
    this.isDone = false,
});
  static List<ToDoModel> todoList(){
    return [
      ToDoModel(id: '01', todoText: 'Morning Exercise', isDone: true),
      ToDoModel(id: '02', todoText: 'Buy cat food'),
      ToDoModel(id: '03', todoText: 'Feeding cat', isDone: true),
      ToDoModel(id: '04', todoText: 'Online Meeting'),
    ];
  }

/*  void toggleCheckBoxStatus() {
    isDone = !isDone;
    notifyListeners();
  }*/
}