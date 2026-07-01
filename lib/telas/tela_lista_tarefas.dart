// ==========================
// ARQUIVO: tela_lista_tarefas.dart
// ==========================

import 'package:flutter/material.dart';

import '../modelos/tarefa.dart';
import '../componentes/card_tarefa.dart';

class TelaListaTarefas extends StatelessWidget {

  final List<Tarefa> tarefas;

  final Function(int) aoExcluir;

  const TelaListaTarefas({

    super.key,

    required this.tarefas,

    required this.aoExcluir,

  });

  @override
  Widget build(BuildContext context) {

    if(tarefas.isEmpty){

      return const Center(

        child: Text(

          "Nenhuma tarefa cadastrada.",

          style: TextStyle(

            fontSize:20,

          ),

        ),

      );

    }

    return ListView.builder(

      padding: const EdgeInsets.all(10),

      itemCount: tarefas.length,

      itemBuilder: (context,index){

        return CardTarefa(

          tarefa: tarefas[index],

          aoExcluir: (){

            aoExcluir(index);

          },

        );

      },

    );

  }

}