// ==========================
// ARQUIVO: tela_estatisticas.dart
// ==========================

import 'package:flutter/material.dart';

import '../modelos/tarefa.dart';

class TelaEstatisticas extends StatelessWidget {

  final List<Tarefa> tarefas;

  const TelaEstatisticas({
    super.key,
    required this.tarefas,
  });

  @override
  Widget build(BuildContext context) {

    int total = tarefas.length;

    int urgentes =
        tarefas.where((t) => t.urgente).length;

    int normais =
        total - urgentes;

    double porcentagem =
        total == 0
            ? 0
            : (urgentes / total) * 100;

    return Padding(

      padding: const EdgeInsets.all(20),

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          const Text(

            "Estatísticas",

            style: TextStyle(

              fontSize:28,

              fontWeight: FontWeight.bold,

            ),

          ),

          const SizedBox(height:30),

          Card(

            child: ListTile(

              leading: const Icon(Icons.list),

              title: Text(
                  "Total de tarefas: $total"),

            ),

          ),

          Card(

            child: ListTile(

              leading: const Icon(
                Icons.priority_high,
                color: Colors.red,
              ),

              title: Text(
                  "Urgentes: $urgentes"),

            ),

          ),

          Card(

            child: ListTile(

              leading: const Icon(
                Icons.book,
                color: Colors.indigo,
              ),

              title: Text(
                  "Normais: $normais"),

            ),

          ),

          Card(

            child: ListTile(

              leading: const Icon(
                Icons.percent,
              ),

              title: Text(

                "Urgentes: ${porcentagem.toStringAsFixed(1)}%",

              ),

            ),

          ),

        ],

      ),

    );

  }

}