import 'package:flutter/material.dart';
import 'package:todo_list_with_shared_pref/helper/cache_helper.dart';
import 'package:todo_list_with_shared_pref/helper/service_locator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController todoController;
  String todo = '';
  List<String> todos = [];

  @override
  void initState() {
    super.initState();
    todoController = TextEditingController();
    _loadTodos();
  }

  /// Load todos from SharedPreferences
  void _loadTodos() async {
    final cachedTodos =
        getIt<CacheHelper>().getData<List<String>>(key: 'todos');

    setState(() => todos = cachedTodos ?? []);
  }

  /// Add a new todo
  void _addTodo() async {
    final newTodo = todoController.text.trim();
    if (newTodo.isNotEmpty) {
      setState(() {
        todos.add(newTodo);
      });
      todoController.clear();
      await getIt<CacheHelper>().saveData(key: 'todos', value: todos);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo List')),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(todos[index]),
              trailing: IconButton(
                onPressed: () {
                  setState(() => todos.removeAt(index));
                  getIt<CacheHelper>()
                      .saveData<List<String>>(key: 'todos', value: todos);
                },
                icon: const Icon(Icons.delete),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showTaskDialog(context);
        },
        child: const Icon(Icons.add_task_sharp),
      ),
    );
  }

  /// Show the di for adding a new todo
  void _showTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: todoController,
                decoration: const InputDecoration(
                  labelText: 'Enter Todo',
                ),
                autofocus: true,
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _addTodo();
                      Navigator.pop(context);
                    },
                    child: const Text('Save'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
