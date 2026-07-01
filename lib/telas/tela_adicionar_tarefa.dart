// ==========================
// ARQUIVO: tela_adicionar_tarefa.dart
// ==========================

import 'package:flutter/material.dart';

import '../modelos/tarefa.dart';

class TelaAdicionarTarefa extends StatefulWidget {

  final Function(Tarefa) aoAdicionarTarefa;

  const TelaAdicionarTarefa({
    super.key,
    required this.aoAdicionarTarefa,
  });

  @override
  State<TelaAdicionarTarefa> createState() =>
      _TelaAdicionarTarefaState();
}

class _TelaAdicionarTarefaState
    extends State<TelaAdicionarTarefa> {

  final TextEditingController controladorTarefa =
      TextEditingController();

  String materiaSelecionada = "Matemática";

  String diaSelecionado = "Segunda";

  bool urgente = false;

  final List<String> materias = [

    "Matemática",
    "Português",
    "História",
    "Geografia",
    "Química",
    "Física",
    "Biologia",

  ];

  final List<String> dias = [

    "Segunda",
    "Terça",
    "Quarta",
    "Quinta",
    "Sexta",

  ];

  void salvarTarefa() {

    if (controladorTarefa.text.trim().isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text(
            "Digite o nome da tarefa!",
          ),

        ),

      );

      return;

    }

    widget.aoAdicionarTarefa(

      Tarefa(

        titulo: controladorTarefa.text,

        materia: materiaSelecionada,

        urgente: urgente,

        dia: diaSelecionado,

      ),

    );

    controladorTarefa.clear();

    setState(() {

      materiaSelecionada = "Matemática";

      diaSelecionado = "Segunda";

      urgente = false;

    });

    ScaffoldMessenger.of(context).showSnackBar(

      const SnackBar(

        content: Text(
          "Tarefa salva com sucesso!",
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

            "Cadastrar Nova Tarefa",

            style: TextStyle(

              fontSize: 24,

              fontWeight: FontWeight.bold,

            ),

          ),

          const SizedBox(height:20),

          TextField(

            controller: controladorTarefa,

            decoration: const InputDecoration(

              labelText: "Nome da tarefa",

              border: OutlineInputBorder(),

              prefixIcon: Icon(Icons.edit),

            ),

          ),

          const SizedBox(height:20),

          DropdownButtonFormField<String>(

            value: materiaSelecionada,

            decoration: const InputDecoration(

              labelText: "Selecione a matéria",

              border: OutlineInputBorder(),

            ),

            items: materias.map((materia){

              return DropdownMenuItem(

                value: materia,

                child: Text(materia),

              );

            }).toList(),

            onChanged: (valor){

              setState(() {

                materiaSelecionada = valor!;

              });

            },

          ),

          const SizedBox(height:20),

          DropdownButtonFormField<String>(

            value: diaSelecionado,

            decoration: const InputDecoration(

              labelText: "Dia da semana",

              border: OutlineInputBorder(),

            ),

            items: dias.map((dia){

              return DropdownMenuItem(

                value: dia,

                child: Text(dia),

              );

            }).toList(),

            onChanged: (valor){

              setState(() {

                diaSelecionado = valor!;

              });

            },

          ),

          const SizedBox(height:20),

          SwitchListTile(

            title: const Text(
              "Tarefa urgente",
            ),

            secondary: const Icon(
              Icons.warning,
            ),

            value: urgente,

            onChanged: (valor){

              setState(() {

                urgente = valor;

              });

            },

          ),

          const SizedBox(height:20),

          ElevatedButton.icon(

            onPressed: salvarTarefa,

            icon: const Icon(Icons.save),

            label: const Text(
              "Salvar Tarefa",
            ),

          ),

        ],

      ),

    );

  }

}