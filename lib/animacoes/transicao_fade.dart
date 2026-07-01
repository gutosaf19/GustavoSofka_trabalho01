// ==========================
// ARQUIVO: transicao_fade.dart
// ==========================

import 'package:flutter/material.dart';

class TransicaoFade<T> extends PageRouteBuilder<T> {

  final Widget pagina;

  TransicaoFade({
    required this.pagina,
  }) : super(

          pageBuilder:
              (context, animation,
                  secondaryAnimation) =>
                  pagina,

          transitionsBuilder:

              (context,

              animation,

              secondaryAnimation,

              child){

            return FadeTransition(

              opacity: animation,

              child: child,

            );

          },

        );

}