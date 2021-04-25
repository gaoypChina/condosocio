import 'package:condosocio/src/components/acessos/widget_saida_acessos.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Acessos extends StatefulWidget {
  @override
  _AcessosState createState() => _AcessosState();
}

class _AcessosState extends State<Acessos> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Acessos', style: GoogleFonts.montserrat(fontSize: 20)),
          centerTitle: true,
          bottom: TabBar(
            tabs: <Widget>[
              Text(
                'Entrada',
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Theme.of(context).textSelectionTheme.selectionColor),
              ),
              Text(
                'Saída',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(children: [SaidaAcessos()]),
      ),
    );
  }
}
