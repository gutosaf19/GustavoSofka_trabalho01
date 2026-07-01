// ==========================
// ARQUIVO: card_tarefa.dart
// ==========================

import 'package:flutter/material.dart';

import '../modelos/tarefa.dart';

class CardTarefa extends StatelessWidget {
  final Tarefa tarefa;
  final VoidCallback aoExcluir;

  const CardTarefa({
    super.key,
    required this.tarefa,
    required this.aoExcluir,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),

      margin: const EdgeInsets.only(bottom: 10),

      decoration: BoxDecoration(
        color: tarefa.urgente
            ? Colors.red.shade50
            : Colors.white,

        borderRadius: BorderRadius.circular(10),
      ),

      child: Card(
        elevation: 4,

        child: ListTile(
          leading: Icon(
            tarefa.urgente
                ? Icons.priority_high
                : Icons.book,

            color: tarefa.urgente
                ? Colors.red
                : Colors.indigo,
          ),

          title: Text(tarefa.titulo),

          subtitle: Text(
            "Matéria: ${tarefa.materia}\nDia: ${tarefa.dia}",
          ),

          trailing: IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),

            onPressed: aoExcluir,
          ),
        ),
      ),
    );
  }
}