import 'package:flutter/material.dart';

void main() {
  runApp(const StudyPlannerApp());
}

// ======================
// APP PRINCIPAL
// ======================
class StudyPlannerApp extends StatelessWidget {
  const StudyPlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rotina Escolar Inteligente',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.grey.shade100,

        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 4,
        ),
      ),

      home: const MainScreen(),
    );
  }
}

// ======================
// MODEL DA TAREFA
// ======================
class Task {
  final String title;
  final String subject;
  final bool urgent;

  Task({
    required this.title,
    required this.subject,
    required this.urgent,
  });
}

// ======================
// TELA PRINCIPAL
// ======================
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Task> _tasks = [];

  // ======================
  // ADICIONAR TAREFA
  // ======================
  void _addTask(Task task) {
    setState(() {
      _tasks.add(task);

      // Vai automaticamente para
      // a página de tarefas
      _selectedIndex = 2;
    });
  }

  // ======================
  // REMOVER TAREFA
  // ======================
  void _removeTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Tarefa removida com sucesso!',
        ),
      ),
    );
  }

  // ======================
  // TROCAR DE PÁGINA
  // ======================
  void _changePage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // ======================
  // ITEM DO MENU LATERAL
  // ======================
  Widget _drawerItem(
    IconData icon,
    String title,
    int index,
  ) {
    return ListTile(
      leading: Icon(icon),

      title: Text(title),

      onTap: () {
        _changePage(index);

        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // ======================
    // LISTA DE PÁGINAS
    // ======================
    final List<Widget> pages = [
      HomePage(
        taskCount: _tasks.length,
      ),

      AddTaskPage(
        onAddTask: _addTask,
      ),

      TaskListPage(
        tasks: _tasks,
        onDeleteTask: _removeTask,
      ),
    ];

    return Scaffold(
      // ======================
      // APP BAR
      // ======================
      appBar: AppBar(
        title: const Text(
          'Rotina Escolar Inteligente',
        ),
      ),

      // ======================
      // MENU LATERAL
      // ======================
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.indigo,
              ),

              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,

                children: const [
                  Icon(
                    Icons.school,
                    color: Colors.white,
                    size: 60,
                  ),

                  SizedBox(height: 10),

                  Text(
                    'Menu Principal',

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ),

            _drawerItem(
              Icons.home,
              'Início',
              0,
            ),

            _drawerItem(
              Icons.add_box,
              'Adicionar Tarefa',
              1,
            ),

            _drawerItem(
              Icons.assignment,
              'Minhas Tarefas',
              2,
            ),
          ],
        ),
      ),

      // ======================
      // CONTEÚDO PRINCIPAL
      // ======================
      body: pages[_selectedIndex],

      // ======================
      // MENU INFERIOR
      // ======================
      bottomNavigationBar:
          BottomNavigationBar(
        currentIndex: _selectedIndex,

        onTap: _changePage,

        selectedItemColor:
            Colors.indigo,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Adicionar',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Tarefas',
          ),
        ],
      ),
    );
  }
}

// ======================
// HOME PAGE
// ======================
class HomePage extends StatelessWidget {
  final int taskCount;

  const HomePage({
    super.key,
    required this.taskCount,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 8,

        margin: const EdgeInsets.all(20),

        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(20),
        ),

        child: Padding(
          padding: const EdgeInsets.all(25),

          child: Column(
            mainAxisSize:
                MainAxisSize.min,

            children: [
              const Icon(
                Icons.menu_book,
                size: 90,
                color: Colors.indigo,
              ),

              const SizedBox(height: 20),

              const Text(
                'Bem-vindo ao seu Organizador Escolar!',

                textAlign: TextAlign.center,

                style: TextStyle(
                  fontSize: 24,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              Text(
                'Você possui $taskCount tarefa(s) cadastrada(s).',

                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ======================
// ADICIONAR TAREFA
// ======================
class AddTaskPage extends StatefulWidget {
  final Function(Task) onAddTask;

  const AddTaskPage({
    super.key,
    required this.onAddTask,
  });

  @override
  State<AddTaskPage> createState() =>
      _AddTaskPageState();
}

class _AddTaskPageState
    extends State<AddTaskPage> {
  // ======================
  // CONTROLLER
  // ======================
  final TextEditingController
      _taskController =
      TextEditingController();

  // ======================
  // VARIÁVEIS
  // ======================
  String _selectedSubject =
      'Matemática';

  bool _isUrgent = false;

  // ======================
  // LISTA DE MATÉRIAS
  // ======================
  final List<String> subjects = [
    'Matemática',
    'Português',
    'História',
    'Geografia',
    'Química',
    'Física',
    'Biologia',
  ];

  // ======================
  // SALVAR TAREFA
  // ======================
  void _saveTask() {
    // Validação
    if (_taskController.text
        .trim()
        .isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Digite o nome da tarefa!',
          ),
        ),
      );

      return;
    }

    // Cria tarefa
    widget.onAddTask(
      Task(
        title: _taskController.text,

        subject: _selectedSubject,

        urgent: _isUrgent,
      ),
    );

    // Limpa campo
    _taskController.clear();

    // Reseta opções
    setState(() {
      _selectedSubject =
          'Matemática';

      _isUrgent = false;
    });

    // Mensagem
    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content: Text(
          'Tarefa salva com sucesso!',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),

      child: ListView(
        children: [
          const Text(
            'Cadastrar Nova Tarefa',

            style: TextStyle(
              fontSize: 24,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          // ======================
          // CAMPO DE TEXTO
          // ======================
          TextField(
            controller: _taskController,

            decoration:
                const InputDecoration(
              labelText:
                  'Nome da tarefa',

              border:
                  OutlineInputBorder(),

              prefixIcon:
                  Icon(Icons.edit),
            ),
          ),

          const SizedBox(height: 20),

          // ======================
          // DROPDOWN
          // ======================
          DropdownButtonFormField<String>(
            value: _selectedSubject,

            decoration:
                const InputDecoration(
              labelText:
                  'Selecione a matéria',

              border:
                  OutlineInputBorder(),
            ),

            items: subjects.map((subject) {
              return DropdownMenuItem(
                value: subject,

                child: Text(subject),
              );
            }).toList(),

            onChanged: (value) {
              setState(() {
                _selectedSubject =
                    value!;
              });
            },
          ),

          const SizedBox(height: 20),

          // ======================
          // SWITCH
          // ======================
          SwitchListTile(
            title: const Text(
              'Tarefa urgente',
            ),

            secondary:
                const Icon(Icons.warning),

            value: _isUrgent,

            onChanged: (value) {
              setState(() {
                _isUrgent = value;
              });
            },
          ),

          const SizedBox(height: 20),

          // ======================
          // BOTÃO
          // ======================
          ElevatedButton.icon(
            onPressed: _saveTask,

            icon: const Icon(Icons.save),

            label: const Text(
              'Salvar Tarefa',
            ),
          ),
        ],
      ),
    );
  }
}

// ======================
// LISTA DE TAREFAS
// ======================
class TaskListPage
    extends StatelessWidget {
  final List<Task> tasks;

  final Function(int) onDeleteTask;

  const TaskListPage({
    super.key,
    required this.tasks,
    required this.onDeleteTask,
  });

  @override
  Widget build(BuildContext context) {
    // ======================
    // LISTA VAZIA
    // ======================
    if (tasks.isEmpty) {
      return const Center(
        child: Text(
          'Nenhuma tarefa cadastrada.',

          style: TextStyle(
            fontSize: 20,
          ),
        ),
      );
    }

    // ======================
    // LISTA DE TAREFAS
    // ======================
    return ListView.builder(
      padding: const EdgeInsets.all(10),

      itemCount: tasks.length,

      itemBuilder:
          (context, index) {
        final task = tasks[index];

        return Card(
          elevation: 5,

          child: ListTile(
            // ÍCONE
            leading: Icon(
              task.urgent
                  ? Icons.priority_high
                  : Icons.book,

              color: task.urgent
                  ? Colors.red
                  : Colors.indigo,
            ),

            // TÍTULO
            title: Text(task.title),

            // SUBTÍTULO
            subtitle: Text(
              'Matéria: ${task.subject}',
            ),

            // BOTÃO EXCLUIR
            trailing: IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),

              onPressed: () =>
                  onDeleteTask(index),
            ),
          ),
        );
      },
    );
  }
}
