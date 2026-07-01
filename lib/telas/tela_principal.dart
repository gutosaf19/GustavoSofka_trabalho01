// ==========================
// ARQUIVO: tela_principal.dart
// ==========================

import 'package:flutter/material.dart';

import '../modelos/tarefa.dart';
import 'tela_inicio.dart';
import 'tela_adicionar_tarefa.dart';
import 'tela_lista_tarefas.dart';
import 'tela_estatisticas.dart';
import 'tela_planejamento.dart';

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {

  int _indiceSelecionado = 0;

  final List<Tarefa> _tarefas = [];

  // ======================
  // ADICIONAR TAREFA
  // ======================
  void adicionarTarefa(Tarefa tarefa) {

    setState(() {

      _tarefas.add(tarefa);

      _indiceSelecionado = 2;

    });

  }

  // ======================
  // REMOVER TAREFA
  // ======================
  void removerTarefa(int indice) {

    setState(() {

      _tarefas.removeAt(indice);

    });

    ScaffoldMessenger.of(context).showSnackBar(

      const SnackBar(

        content: Text(
          "Tarefa removida com sucesso!",
        ),

      ),

    );

  }

  // ======================
  // TROCAR DE PÁGINA
  // ======================
  void trocarPagina(int indice){

    setState(() {

      _indiceSelecionado = indice;

    });

  }

  // ======================
  // ITEM MENU
  // ======================
  Widget itemMenu(

      IconData icone,
      String titulo,
      int indice){

    return ListTile(

      leading: Icon(icone),

      title: Text(titulo),

      onTap: (){

        trocarPagina(indice);

        Navigator.pop(context);

      },

    );

  }

  @override
  Widget build(BuildContext context) {

    final paginas = [

      TelaInicio(
        quantidadeTarefas: _tarefas.length,
      ),

      TelaAdicionarTarefa(
        aoAdicionarTarefa: adicionarTarefa,
      ),

      TelaListaTarefas(
        tarefas: _tarefas,
        aoExcluir: removerTarefa,
      ),

      TelaEstatisticas(
        tarefas: _tarefas,
      ),

      TelaPlanejamento(
        tarefas: _tarefas,
      ),

    ];

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "Rotina Escolar Inteligente",
        ),

      ),

      drawer: Drawer(

        child: ListView(

          children: [

            const DrawerHeader(

              decoration: BoxDecoration(

                color: Colors.indigo,

              ),

              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  Icon(
                    Icons.school,
                    size: 60,
                    color: Colors.white,
                  ),

                  SizedBox(height: 10),

                  Text(

                    "Menu Principal",

                    style: TextStyle(

                      color: Colors.white,
                      fontSize: 22,

                    ),

                  ),

                ],

              ),

            ),

            itemMenu(
              Icons.home,
              "Início",
              0,
            ),

            itemMenu(
              Icons.add_box,
              "Adicionar Tarefa",
              1,
            ),

            itemMenu(
              Icons.assignment,
              "Minhas Tarefas",
              2,
            ),

            itemMenu(
              Icons.bar_chart,
              "Estatísticas",
              3,
            ),

            itemMenu(
              Icons.calendar_month,
              "Planejamento",
              4,
            ),

          ],

        ),

      ),

      body: paginas[_indiceSelecionado],

      bottomNavigationBar: BottomNavigationBar(

        currentIndex: _indiceSelecionado,

        onTap: trocarPagina,

        selectedItemColor: Colors.indigo,

        type: BottomNavigationBarType.fixed,

        items: const [

          BottomNavigationBarItem(

            icon: Icon(Icons.home),

            label: "Início",

          ),

          BottomNavigationBarItem(

            icon: Icon(Icons.add),

            label: "Adicionar",

          ),

          BottomNavigationBarItem(

            icon: Icon(Icons.list),

            label: "Tarefas",

          ),

          BottomNavigationBarItem(

            icon: Icon(Icons.bar_chart),

            label: "Estatísticas",

          ),

          BottomNavigationBarItem(

            icon: Icon(Icons.calendar_month),

            label: "Planejamento",

          ),

        ],

      ),

    );

  }

}