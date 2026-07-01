// ==========================
// ARQUIVO: menu_lateral.dart
// ==========================

import 'package:flutter/material.dart';

class MenuLateral extends StatelessWidget {

  final Function(int) trocarPagina;

  const MenuLateral({
    super.key,
    required this.trocarPagina,
  });

  Widget item(

      BuildContext context,

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

    return Drawer(

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
                  size:60,
                  color: Colors.white,
                ),

                SizedBox(height:10),

                Text(

                  "Menu Principal",

                  style: TextStyle(

                    color: Colors.white,

                    fontSize:22,

                  ),

                ),

              ],

            ),

          ),

          item(context, Icons.home, "Início", 0),

          item(context, Icons.add_box, "Adicionar", 1),

          item(context, Icons.assignment, "Tarefas", 2),

          item(context, Icons.bar_chart, "Estatísticas", 3),

          item(context, Icons.calendar_month, "Planejamento", 4),

        ],

      ),

    );

  }

}