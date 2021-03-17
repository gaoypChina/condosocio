import 'package:condosocio/src/components/box_search.dart';
import 'package:condosocio/src/controllers/documentos_controllers/outros_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Outros extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    OutrosController outrosController = Get.put(OutrosController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Outros',
        ),
      ),
      body: Obx(
        () {
          return outrosController.isLoading.value
              ? Container(
                  height: MediaQuery.of(context).size.height,
                  color: Theme.of(context).primaryColor,
                  child: Center(
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: CircularProgressIndicator(
                        strokeWidth: 4,
                        valueColor: AlwaysStoppedAnimation(
                            Theme.of(context).accentColor),
                      ),
                    ),
                  ),
                )
              : Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      boxSearch(context, outrosController.controller.value,
                          outrosController.onSearchTextChanged),
                      Expanded(
                        child: outrosController.searchResult.isNotEmpty ||
                                outrosController
                                    .controller.value.text.isNotEmpty
                            ? ListView.builder(
                                itemCount: outrosController.searchResult.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    color: Theme.of(context).accentColor,
                                    child: ListTile(
                                      title: Text(
                                        outrosController
                                            .searchResult[index].nome,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                        ),
                                      ),
                                      subtitle: Text(
                                        outrosController
                                            .searchResult[index].data,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 15,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                        ),
                                      ),
                                      trailing: IconButton(
                                        icon: Icon(Feather.download),
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor,
                                        iconSize: 30,
                                        onPressed: () {
                                          outrosController.launched =
                                              outrosController.launchInBrowser(
                                                  "https://condosocio.com.br/acond/downloads/documentos/${outrosController.searchResult[index].imgdoc}");
                                        },
                                      ),
                                    ),
                                  );
                                },
                              )
                            : ListView.builder(
                                itemCount: outrosController.outros.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    color: Theme.of(context).accentColor,
                                    child: ListTile(
                                      title: Text(
                                        outrosController.outros[index].nome,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                        ),
                                      ),
                                      subtitle: Text(
                                        outrosController.outros[index].data,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 15,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                        ),
                                      ),
                                      trailing: IconButton(
                                        icon: Icon(Feather.download),
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor,
                                        iconSize: 30,
                                        onPressed: () {
                                          outrosController.launched =
                                              outrosController.launchInBrowser(
                                                  "https://condosocio.com.br/acond/downloads/documentos/${outrosController.outros[index].imgdoc}");
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                      )
                    ],
                  ),
                );
        },
      ),
    );
  }
}
