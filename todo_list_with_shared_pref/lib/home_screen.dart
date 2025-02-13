import 'package:flutter/material.dart';
import 'package:todo_list_with_shared_pref/cache_helper.dart';
import 'package:todo_list_with_shared_pref/service_locator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController todoController;
  String todo = '';
  List<String> todos = []; // Initialize as empty list

  @override
  void initState() {
    super.initState();
    todoController = TextEditingController();
    _loadTodos(); // Load todos from SharedPreferences
  }

  /// Load todos from SharedPreferences
  void _loadTodos() async {
    final cachedTodos =
        getIt<CacheHelper>().getData<List<String>>(key: 'todos');
    setState(() {
      todos = cachedTodos ?? []; // Use cached todos or an empty list if null
    });
  }

  /// Add a new todo
  void _addTodo() async {
    final newTodo = todoController.text.trim();
    if (newTodo.isNotEmpty) {
      setState(() {
        todos.add(newTodo); // Add the new todo to the list
      });
      todoController.clear();
      await getIt<CacheHelper>()
          .saveData(key: 'todos', value: todos); // Save the updated list
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
              leading: IconButton(
                onPressed: () {
                  // Toggle todo completion (optional)
                },
                icon: const Icon(Icons.check_box_outline_blank),
              ),
              title: Text(todos[index]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showTaskBottomSheet(context);
        },
        child: const Icon(Icons.add_task_sharp),
      ),
    );
  }

  /// Show the bottom sheet for adding a new todo
  void _showTaskBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
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
                ElevatedButton(
                  onPressed: () {
                    _addTodo();
                    Navigator.pop(context);
                  },
                  child: const Text('SAVE'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
