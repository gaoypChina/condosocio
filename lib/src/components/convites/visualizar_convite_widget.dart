import 'package:condosocio/src/components/utils/box_search.dart';
import 'package:condosocio/src/controllers/convites/visualizar_convites_controller.dart';
import 'package:condosocio/src/controllers/convites_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VisualizarConviteWidget extends StatelessWidget {
  const VisualizarConviteWidget({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ConvitesController convitesController = Get.put(ConvitesController());
    VisualizarConvitesController visualizarConviteController =
        Get.put(VisualizarConvitesController());

    return Obx(() {
      return Container(
        child: Column(
          children: [
            boxSearch(context, convitesController.search.value,
                convitesController.onSearchTextChanged),
            Expanded(
              child: convitesController.searchResult.length != 0 ||
                      convitesController.search.value.text.isNotEmpty
                  ? ListView.builder(
                      itemCount: convitesController.searchResult.length,
                      itemBuilder: (_, i) {
                        var convites = convitesController.searchResult[i];

                        var date = DateTime.now();
                        var endDate = DateTime.parse(convites.datafinal);

                        var before = endDate.isBefore(date);
                        return Container(
                            margin: EdgeInsets.only(top: 5),
                            child: GestureDetector(
                              onTap: () {},
                              child: Card(
                                color: before
                                    ? Theme.of(context).accentColor
                                    : Theme.of(context).buttonColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListTile(
                                  title: Text(convites.titulo),
                                  subtitle:
                                      Text('Convidados: ${convites.qtdconv}'),
                                  leading: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.email_outlined,
                                        size: 30,
                                      ),
                                    ],
                                  ),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.arrow_right,
                                        size: 30,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ));
                      })
                  : ListView.builder(
                      itemCount: convitesController.convites.length,
                      itemBuilder: (_, i) {
                        var convites = convitesController.convites[i];

                        var date = DateTime.now();
                        var endDate = DateTime.parse(convites.datafinal);
                        var before = endDate.isBefore(date);

                        return Container(
                            margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
                            child: GestureDetector(
                              onTap: () {
                                visualizarConviteController.titulo.value =
                                    convites.titulo;
                                visualizarConviteController.qtdconv.value =
                                    convites.qtdconv;
                                visualizarConviteController
                                    .getAConvite(convites.idconv);
                              },
                              child: Card(
                                color: before
                                    ? Theme.of(context).accentColor
                                    : Theme.of(context).buttonColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListTile(
                                  title: Text(convites.titulo),
                                  subtitle:
                                      Text('Convidados: ${convites.qtdconv}'),
                                  leading: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.email_outlined,
                                        size: 30,
                                      ),
                                    ],
                                  ),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.arrow_right,
                                        size: 30,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ));
                      }),
            ),
          ],
        ),
      );
    });
  }
}
