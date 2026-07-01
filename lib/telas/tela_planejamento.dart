// ==========================
// ARQUIVO: tela_planejamento.dart
// ==========================

// ==========================
// ARQUIVO: tela_planejamento.dart
// ==========================

import 'package:flutter/material.dart';

import '../modelos/tarefa.dart';

class TelaPlanejamento extends StatelessWidget {

  final List<Tarefa> tarefas;

  const TelaPlanejamento({

    super.key,

    required this.tarefas,

  });

  @override
  Widget build(BuildContext context) {

    return ListView(

      padding: const EdgeInsets.all(20),

      children: [

        const Text(

          "Planejamento Semanal",

          style: TextStyle(

            fontSize:28,

            fontWeight: FontWeight.bold,

          ),

        ),

        const SizedBox(height:20),

        ...["Segunda","Terça","Quarta","Quinta","Sexta"]

            .map((dia){

          final lista = tarefas

              .where((t)=>t.dia==dia)

              .toList();

          return Card(

            child: ExpansionTile(

              title: Text(dia),

              children: lista.isEmpty

                  ? [

                      const Padding(

                        padding: EdgeInsets.all(10),

                        child: Text(
                          "Nenhuma tarefa.",
                        ),

                      )

                    ]

                  : lista.map((t){

                      return ListTile(

                        title: Text(t.titulo),

                        subtitle:
                            Text(t.materia),

                      );

                    }).toList(),

            ),

          );

        })

      ],

    );

  }

}