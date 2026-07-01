// ==========================
// ARQUIVO: tela_inicio.dart
// ==========================
// ARQUIVO: tela_inicio.dart
// ==========================

import 'package:flutter/material.dart';

class TelaInicio extends StatelessWidget {
  final int quantidadeTarefas;

  const TelaInicio({
    super.key,
    required this.quantidadeTarefas,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 8,
        margin: const EdgeInsets.all(20),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),

        child: Padding(
          padding: const EdgeInsets.all(25),

          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [

              Hero(
                tag: "iconeEscola",

                child: const Icon(
                  Icons.menu_book,
                  size: 90,
                  color: Colors.indigo,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Bem-vindo ao seu Organizador Escolar!",

                textAlign: TextAlign.center,

                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              Text(
                "Você possui $quantidadeTarefas tarefa(s) cadastrada(s).",

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