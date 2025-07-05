import 'package:flutter/material.dart';
import 'package:todo_app/screens/Q3.dart';

class MyTodoList extends StatefulWidget {
  const MyTodoList({super.key});

  @override
  State<MyTodoList> createState() => _MyTodoListState();
}

class _MyTodoListState extends State<MyTodoList> {
  final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

 void submitTodo() async {  // Make it async
  final String todo = _controller.text.trim();
  if (_formKey.currentState?.validate() ?? false) {
    if (todo.isNotEmpty){
      setState(() {
        _isLoading = true;
      });
      //load 2 seconds 
      await Future.delayed(const Duration(seconds: 2));
      
      setState(() {
        _isLoading = false;
      });
      
      // Navigate back with the todo
      Navigator.pop(context, todo);
    }
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Enter a todo item',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  hintText: 'e.g. Buy groceries',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a todo item';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _isLoading ? null : submitTodo,
                child: _isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          backgroundColor: Colors.transparent,
                          
                          ),
                      )
                    : const Text('Add list item', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
        ),
        bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_answer),
            label: 'Q3',
          ),
        ],
        onTap: (int index) async {
          if (index == 0) {
            // Navigate to home screen
            Navigator.pushReplacementNamed(context, '/');
          }
        
          // Navigate to UserListScreen if index is 2
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