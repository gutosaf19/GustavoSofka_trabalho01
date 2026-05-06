import 'package:flutter/material.dart';

void main() {
  runApp(const StudyPlannerApp());
}

class StudyPlannerApp extends StatelessWidget {
  const StudyPlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rotina Escolar Inteligente',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
    );
  }
}

class Task {
  String title;
  String subject;
  bool urgent;

  Task({
    required this.title,
    required this.subject,
    required this.urgent,
  });
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Task> _tasks = [];

  void _addTask(Task task) {
    setState(() {
      _tasks.add(task);
      _selectedIndex = 2;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomePage(taskCount: _tasks.length),
      AddTaskPage(onAddTask: _addTask),
      TaskListPage(tasks: _tasks),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rotina Escolar Inteligente'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menu Principal',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Início'),
              onTap: () {
                _onItemTapped(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Adicionar Tarefa'),
              onTap: () {
                _onItemTapped(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('Minhas Tarefas'),
              onTap: () {
                _onItemTapped(2);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: 'Adicionar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Tarefas',
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final int taskCount;

  const HomePage({super.key, required this.taskCount});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.school, size: 100, color: Colors.blue),
            const SizedBox(height: 20),
            const Text(
              'Bem-vindo ao seu Organizador Escolar!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Você possui $taskCount tarefa(s) cadastrada(s).',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

class AddTaskPage extends StatefulWidget {
  final Function(Task) onAddTask;

  const AddTaskPage({super.key, required this.onAddTask});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _taskController = TextEditingController();
  String _selectedSubject = 'Matemática';
  bool _isUrgent = false;

  final List<String> subjects = [
    'Matemática',
    'Português',
    'História',
    'Geografia',
    'Química',
    'Física',
    'Biologia'
  ];

  void _saveTask() {
    if (_taskController.text.isNotEmpty) {
      widget.onAddTask(
        Task(
          title: _taskController.text,
          subject: _selectedSubject,
          urgent: _isUrgent,
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tarefa adicionada com sucesso!'),
        ),
      );

      _taskController.clear();

      setState(() {
        _selectedSubject = 'Matemática';
        _isUrgent = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          const Text(
            'Cadastrar Nova Tarefa',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _taskController,
            decoration: const InputDecoration(
              labelText: 'Nome da tarefa',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          DropdownButtonFormField<String>(
            value: _selectedSubject,
            decoration: const InputDecoration(
              labelText: 'Matéria',
              border: OutlineInputBorder(),
            ),
            items: subjects.map((subject) {
              return DropdownMenuItem(
                value: subject,
                child: Text(subject),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedSubject = value!;
              });
            },
          ),
          const SizedBox(height: 20),
          SwitchListTile(
            title: const Text('Tarefa urgente'),
            value: _isUrgent,
            onChanged: (value) {
              setState(() {
                _isUrgent = value;
              });
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _saveTask,
            child: const Text('Salvar Tarefa'),
          ),
        ],
      ),
    );
  }
}

class TaskListPage extends StatelessWidget {
  final List<Task> tasks;

  const TaskListPage({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return const Center(
        child: Text(
          'Nenhuma tarefa cadastrada.',
          style: TextStyle(fontSize: 20),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];

        return Card(
          elevation: 4,
          child: ListTile(
            leading: Icon(
              task.urgent ? Icons.warning : Icons.book,
              color: task.urgent ? Colors.red : Colors.blue,
            ),
            title: Text(task.title),
            subtitle: Text('Matéria: ${task.subject}'),
            trailing: task.urgent
                ? const Text(
                    'URGENTE',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : null,
          ),
        );
      },
    );
  }
}