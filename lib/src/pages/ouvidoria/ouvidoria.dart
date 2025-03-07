import 'package:condosocio/src/pages/ouvidoria/adiciona_ouvidoria.dart';
import 'package:condosocio/src/pages/ouvidoria/visualizar_ouvidoria.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:condosocio/src/controllers/ouvidoria/ouvidoria_controller.dart';

class Ouvidoria extends StatefulWidget {
  @override
  _OuvidoriaState createState() => _OuvidoriaState();
}

class _OuvidoriaState extends State<Ouvidoria> {
  OuvidoriaController ouvidoriaController = Get.put(OuvidoriaController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Get.offNamed('/home');
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
            title: Text(
              'Ouvidoria',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                color: Theme.of(context).textSelectionTheme.selectionColor!,
              ),
            ),
            centerTitle: true,
            bottom: TabBar(
              indicatorPadding: EdgeInsets.all(-8),
              indicatorColor:
                  Theme.of(context).textSelectionTheme.selectionColor!,
              tabs: <Widget>[
                Text(
                  'Visualizar',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Theme.of(context).textSelectionTheme.selectionColor!,
                  ),
                ),
                Text(
                  'Adicionar',
                  style: GoogleFonts.montserrat(
                      fontSize: 14,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor!),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [VisualizarOuvidoria(), AdicionaOuvidoria()],
          ),
        ),
      ),
    );
  }
}
