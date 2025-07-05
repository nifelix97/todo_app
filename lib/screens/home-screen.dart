import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/screens/Q3.dart';
import 'package:todo_app/screens/todo-screen.dart';
import 'package:todo_app/widgets/popup.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  final List<Map<String, dynamic>> _todos = [];
  
  void AddTodo(String todo) async {
    final pref = await SharedPreferences.getInstance();
    _todos.add({'text': todo, 'isCompleted': false});
    setState(() {});
    await _saveTodos();
  }

  void LoadTodos() async {
    final pref = await SharedPreferences.getInstance();
    final todoStrings = pref.getStringList('todos');
    final completionStates = pref.getStringList('completions');
    
    if (todoStrings != null) {
      _todos.clear();
      for (int i = 0; i < todoStrings.length; i++) {
        bool isCompleted = false;
        if (completionStates != null && i < completionStates.length) {
          isCompleted = completionStates[i] == 'true';
        }
        _todos.add({'text': todoStrings[i], 'isCompleted': isCompleted});
      }
      setState(() {});
    }
  }

  Future<void> _saveTodos() async {
    final pref = await SharedPreferences.getInstance();
    final todoStrings = _todos.map((todo) => todo['text'] as String).toList();
    final completionStates = _todos.map((todo) => (todo['isCompleted'] as bool).toString()).toList();
    
    await pref.setStringList('todos', todoStrings);
    await pref.setStringList('completions', completionStates);
  }

  void RemoveTodo(String todoText) async {
    _todos.removeWhere((todo) => todo['text'] == todoText);
    setState(() {});
    await _saveTodos();
  }

  void UpdateTodo(String oldTodo, String newTodo) async {
    final index = _todos.indexWhere((todo) => todo['text'] == oldTodo);
    if (index != -1) {
      _todos[index]['text'] = newTodo;
      setState(() {});
      await _saveTodos();
    }
  }

  void ToggleCompletion(String todoText) async {
    final index = _todos.indexWhere((todo) => todo['text'] == todoText);
    if (index != -1) {
      _todos[index]['isCompleted'] = !(_todos[index]['isCompleted'] as bool);
      setState(() {});
      await _saveTodos();
    }
  }

  @override
  void initState() {
    super.initState();
    LoadTodos();
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Home Screen', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)), centerTitle: true),
    body: _todos.isEmpty 
      ? // if is empty state
        const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.checklist_outlined,
                size: 80,
                color: Colors.grey,
              ),
              SizedBox(height: 16),
              Text(
                'No todos yet!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Tap "add data" to create your first todo',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        )
      : // Todo list
        ListView.builder(
          itemCount: _todos.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 6.0,
                bottom: 6.0,
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: const Color.fromARGB(255, 94, 62, 62), width: 1.0),
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10.0),
                ),
                color: const Color.fromARGB(255, 43, 114, 117),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 43, 114, 117),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(_todos[index]['text'],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      decoration: _todos[index]['isCompleted'] ? TextDecoration.lineThrough : null,
                    )
                ),
                trailing: TodoPopupMenu(
                  todoText: _todos[index]['text'],
                  isCompleted: _todos[index]['isCompleted'],
                  onActionSelected: (action, todoText) {
                    switch (action) {
                      case TodoAction.edit:
                        // Handle edit action
                        showDialog(
                          context: context,
                          builder: (context) {
                            final controller = TextEditingController(text: todoText);
                            return AlertDialog(
                              title: const Text('Edit Todo'),
                              content: TextField(
                                controller: controller,
                                autofocus: true,
                                decoration: const InputDecoration(hintText: 'Enter new todo'),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    final newTodo = controller.text.trim();
                                    if (newTodo.isNotEmpty) {
                                      UpdateTodo(todoText, newTodo);
                                    }
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Save'),
                                ),
                              ],
                            );
                          },
                        );
                        break;
                      case TodoAction.delete:
                        // Handle delete action
                        RemoveTodo(todoText);
                        break;
                      case TodoAction.markComplete:
                      case TodoAction.markIncomplete:
                        // Handle completion toggle
                        ToggleCompletion(todoText);
                        break;
                    }
                  },
                ),
              ),
            );
          },
        ),
    bottomNavigationBar: BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'add data',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.question_answer),
          label: 'Q3',
        ),
      ],
      onTap: (int index) async {
        if (index == 1) {
          final newTask = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const MyTodoList()),
          );
          if (newTask != null) AddTodo(newTask);
        }
        // Handle other navigation items if needed
        else if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => UserListScreen()),
          );
        }
      },
    ),
  );
}
}
