import 'package:condosocio/src/components/utils/alert_button_pressed.dart';
import 'package:condosocio/src/components/utils/delete_alert.dart';
import 'package:condosocio/src/components/utils/edge_alert_widget.dart';
import 'package:condosocio/src/controllers/dependentes_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

void dependentesModalBottomSheet(
  context,
  String nome,
  String sobrenome,
  String status,
  String email,
) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        DependentesController dependentesController =
            Get.put(DependentesController());
        return Container(
          color: Theme.of(context).accentColor,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: new Icon(
                        Feather.user,
                        color:
                            Theme.of(context).textSelectionTheme.selectionColor,
                        size: 40,
                      ),
                      title: Text(
                        '$nome $sobrenome',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                      subtitle: Text(
                        email,
                        style: TextStyle(fontSize: 14),
                      )),
                  Divider(
                    height: 20,
                    color: Colors.blueGrey,
                  ),
                  status == 'Normal'
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                                    elevation: MaterialStateProperty.all(0),
                                    backgroundColor: MaterialStateProperty.all(
                                      Theme.of(context).splashColor,
                                    )),
                                onPressed: () {
                                  dependentesController
                                      .changeStatus('2')
                                      .then((value) {
                                    dependentesController.getDependentes();
                                    Get.back();
                                  });
                                },
                                child: Text(
                                  "Suspender",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              )),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                                    elevation: MaterialStateProperty.all(0),
                                    backgroundColor: MaterialStateProperty.all(
                                      Theme.of(context).splashColor,
                                    )),
                                onPressed: () {
                                  dependentesController
                                      .changeStatus('1')
                                      .then((value) {
                                    dependentesController.getDependentes();
                                    Get.back();
                                  });
                                },
                                child: Text(
                                  "Normalizar",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              )),
                        ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).errorColor,
                              )),
                          onPressed: () {
                            deleteAlert(
                              context,
                              'Deseja deletar dependente?',
                              () {
                                dependentesController.deleteDependente().then(
                                  (value) {
                                    if (value == 1) {
                                      dependentesController.getDependentes();
                                      edgeAlertWidget(
                                        context,
                                        'Dependente Excluido',
                                      );
                                      Get.back();
                                      Get.back();
                                    } else {
                                      onAlertButtonPressed(
                                        context,
                                        'Algo deu errado\n Tente novamente',
                                        '/home',
                                      );
                                    }
                                  },
                                );
                              },
                            );
                          },
                          child: Text(
                            "Excluir",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 15,
                  )
                ],
              ),
            ),
          ),
        );
      });
}
