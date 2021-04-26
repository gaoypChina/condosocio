import 'package:condosocio/src/components/alert_button_pressed.dart';
import 'package:condosocio/src/components/utils/custom_text_field.dart';
import 'package:condosocio/src/components/whatsapp_button_pressed.dart';
import 'package:condosocio/src/controllers/acessos/acessos_controller.dart';
import 'package:condosocio/src/controllers/convites_controller.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/acessos/agenda_contatos_controller.dart';
import 'package:intl/intl.dart';

class ConviteWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AcessosController acessosController = Get.put(AcessosController());
    AgendaContatosController agendaContatosController =
        Get.put(AgendaContatosController());
    ConvitesController convitesController = Get.put(ConvitesController());
    LoginController loginController = Get.put(LoginController());

    // void dropDownItemSelected(String novoItem) {
    //   acessosController.itemSelecionado.value = novoItem;
    // }

    // void dropDownFavoriteSelected(String novoItem) {
    //   acessosController.firstId.value = novoItem;
    // }

    return Obx(
      () {
        return acessosController.isLoading.value
            ? Container(
                height: MediaQuery.of(context).size.height,
                color: Theme.of(context).primaryColor,
                child: Center(
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: CircularProgressIndicator(
                      strokeWidth: 4,
                      valueColor:
                          AlwaysStoppedAnimation(Theme.of(context).accentColor),
                    ),
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            child: Text(
                              'Quando irá acontecer?',
                              style: GoogleFonts.montserrat(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: 20, left: 10, right: 10),
                            child: Text(
                              'Inicio do evento',
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: 20, left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(right: 4),
                                    child: customTextField(
                                      context,
                                      null,
                                      (DateFormat("dd/MM/yyyy").format(
                                          convitesController.date.value)),
                                      false,
                                      1,
                                      false,
                                      convitesController.dataController.value,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: customTextField(
                                    context,
                                    null,
                                    (DateFormat("hh:mm")
                                        .format(convitesController.date.value)),
                                    false,
                                    1,
                                    false,
                                    convitesController.dataController.value,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: 20, left: 10, right: 10),
                            child: Text(
                              'Término do evento',
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: 20, left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(right: 4),
                                    child: customTextField(
                                      context,
                                      null,
                                      (DateFormat("dd/MM/yyyy").format(
                                          convitesController.date.value)),
                                      false,
                                      1,
                                      false,
                                      convitesController.dataController.value,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: customTextField(
                                    context,
                                    null,
                                    (DateFormat("hh:mm")
                                        .format(convitesController.date.value)),
                                    false,
                                    1,
                                    false,
                                    convitesController.dataController.value,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 20),
                              child: Text(
                                'Nome do convite',
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 20),
                              child: customTextField(
                                context,
                                null,
                                'Convite de ${loginController.nome.value}',
                                true,
                                1,
                                true,
                                convitesController.inviteName.value,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                            color: Theme.of(context).accentColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ButtonTheme(
                              height: 50.0,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      return Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor;
                                    },
                                  ),
                                  elevation:
                                      MaterialStateProperty.resolveWith<double>(
                                    (Set<MaterialState> states) {
                                      return 3;
                                    },
                                  ),
                                  shape: MaterialStateProperty.resolveWith<
                                      OutlinedBorder>(
                                    (Set<MaterialState> states) {
                                      return RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      );
                                    },
                                  ),
                                ),
                                onPressed: () {
                                  convitesController.handleCount();
                                },
                                child: acessosController.isLoading.value
                                    ? SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation(
                                              Colors.white),
                                        ),
                                      )
                                    : Text(
                                        "Insira o nome",
                                        style: GoogleFonts.montserrat(
                                            color:
                                                Theme.of(context).accentColor,
                                            fontSize: 16),
                                      ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Text(
                                'OU',
                                style: GoogleFonts.montserrat(fontSize: 13),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ButtonTheme(
                              height: 50.0,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      return Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor;
                                    },
                                  ),
                                  elevation:
                                      MaterialStateProperty.resolveWith<double>(
                                    (Set<MaterialState> states) {
                                      return 3;
                                    },
                                  ),
                                  shape: MaterialStateProperty.resolveWith<
                                      OutlinedBorder>(
                                    (Set<MaterialState> states) {
                                      return RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      );
                                    },
                                  ),
                                ),
                                onPressed: () {
                                  agendaContatosController.pickContact();
                                },
                                child: acessosController.isLoading.value
                                    ? SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation(
                                              Colors.white),
                                        ),
                                      )
                                    : Text(
                                        "PROCURAR NOS SEUS CONTATOS",
                                        style: GoogleFonts.montserrat(
                                            color:
                                                Theme.of(context).accentColor,
                                            fontSize: 16),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      for (var i = 0; i < convitesController.count.value; i++)
                        Container(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  left: 4,
                                  top: 5,
                                  right: 4,
                                ),
                                padding: EdgeInsets.all(7),
                                child: customTextField(
                                  context,
                                  'Nome ou empresa',
                                  null,
                                  false,
                                  1,
                                  true,
                                  acessosController.name.value,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 3),
                                padding: EdgeInsets.all(7),
                                child: customTextField(
                                  context,
                                  'Celular (ex: 91 989900290)',
                                  null,
                                  false,
                                  1,
                                  true,
                                  acessosController.phone.value,
                                ),
                              ),
                            ],
                          ),
                        ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ButtonTheme(
                              height: 50.0,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      return Theme.of(context).accentColor;
                                    },
                                  ),
                                  elevation:
                                      MaterialStateProperty.resolveWith<double>(
                                    (Set<MaterialState> states) {
                                      return 3;
                                    },
                                  ),
                                  shape: MaterialStateProperty.resolveWith<
                                      OutlinedBorder>(
                                    (Set<MaterialState> states) {
                                      return RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      );
                                    },
                                  ),
                                ),
                                onPressed: () {
                                  acessosController.sendAcessos().then(
                                    (value) {
                                      if (value == 'vazio') {
                                        onAlertButtonPressed(
                                            context,
                                            'Tipo de visitante, nome e celular são campos obrigátorios!',
                                            null);
                                        acessosController.isLoading.value =
                                            false;
                                      } else if (value == 1) {
                                        onWhatsappButtonPressed(context, null);
                                        acessosController.isLoading.value =
                                            false;
                                      } else {
                                        onAlertButtonPressed(
                                          context,
                                          'Algo deu errado! \nTente novamente',
                                          null,
                                        );
                                        acessosController.isLoading.value =
                                            false;
                                      }
                                    },
                                  );
                                  acessosController.name.value.text = '';
                                  acessosController.phone.value.text = '';
                                  acessosController.firstId.value = '0';
                                },
                                child: acessosController.isLoading.value
                                    ? SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation(
                                              Colors.white),
                                        ),
                                      )
                                    : Text(
                                        "AUTORIZAR",
                                        style: GoogleFonts.montserrat(
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .selectionColor,
                                            fontSize: 16),
                                      ),
                              ),
                            ),
                            acessosController.firstId.value != '0'
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      ButtonTheme(
                                        height: 50.0,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty
                                                    .resolveWith<Color>(
                                              (Set<MaterialState> states) {
                                                return Colors.red;
                                              },
                                            ),
                                            elevation: MaterialStateProperty
                                                .resolveWith<double>(
                                              (Set<MaterialState> states) {
                                                return 3;
                                              },
                                            ),
                                            shape: MaterialStateProperty
                                                .resolveWith<OutlinedBorder>(
                                              (Set<MaterialState> states) {
                                                return RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                );
                                              },
                                            ),
                                          ),
                                          onPressed: () {
                                            acessosController.deleteFav().then(
                                              (value) {
                                                if (value == 1) {
                                                  onAlertButtonPressed(
                                                    context,
                                                    'Favorito deletado!',
                                                    '/home',
                                                  );
                                                } else {
                                                  onAlertButtonPressed(
                                                    context,
                                                    'Algo deu errado \n Tente novamente',
                                                    '/home',
                                                  );
                                                }
                                              },
                                            );
                                          },
                                          child: Text(
                                            "APAGAR FAVORITO",
                                            style: GoogleFonts.montserrat(
                                                color: Colors.black,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
      },
    );
  }
}

// Container(
//                       //   height: 55,
//                       //   margin: EdgeInsets.only(left: 10, right: 10),
//                       //   padding: EdgeInsets.all(7),
//                       //   decoration: BoxDecoration(
//                       //     borderRadius: BorderRadius.circular(10),
//                       //     border: Border.all(
//                       //       color: Theme.of(context)
//                       //           .textSelectionTheme
//                       //           .selectionColor,
//                       //       width: 1,
//                       //     ),
//                       //   ),
//                       //   child: DropdownButton<String>(
//                       //     isExpanded: true,
//                       //     underline: Container(),
//                       //     icon: Icon(
//                       //       Icons.keyboard_arrow_down,
//                       //       size: 27,
//                       //     ),
//                       //     iconEnabledColor: Theme.of(context)
//                       //         .textSelectionTheme
//                       //         .selectionColor,
//                       //     dropdownColor: Theme.of(context).primaryColor,
//                       //     style: GoogleFonts.montserrat(fontSize: 16),
//                       //     items: acessosController.tipos
//                       //         .map((String dropDownStringItem) {
//                       //       return DropdownMenuItem<String>(
//                       //         value: dropDownStringItem,
//                       //         child: Text(dropDownStringItem),
//                       //       );
//                       //     }).toList(),
//                       //     onChanged: (String novoItemSelecionado) {
//                       //       dropDownItemSelected(novoItemSelecionado);
//                       //       acessosController.itemSelecionado.value =
//                       //           novoItemSelecionado;
//                       //     },
//                       //     value: acessosController.itemSelecionado.value,
//                       //   ),
//                       // ),

//  Container(
//                                 padding: EdgeInsets.all(7),
//                                 margin: EdgeInsets.only(
//                                     top: 10, bottom: 20, left: 10, right: 10),
//                                 height: 55,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   border: Border.all(
//                                     color: Theme.of(context)
//                                         .textSelectionTheme
//                                         .selectionColor,
//                                     width: 1,
//                                   ),
//                                 ),
//                                 child: DropdownButton<String>(
//                                   autofocus: false,
//                                   isExpanded: true,
//                                   underline: Container(),
//                                   icon: Icon(
//                                     Icons.keyboard_arrow_down,
//                                     size: 27,
//                                   ),
//                                   iconEnabledColor: Theme.of(context)
//                                       .textSelectionTheme
//                                       .selectionColor,
//                                   dropdownColor: Theme.of(context).primaryColor,
//                                   style: GoogleFonts.montserrat(fontSize: 16),
//                                   items: acessosController.fav.map((item) {
//                                     return DropdownMenuItem(
//                                       value: item['id'].toString(),
//                                       child: Text(item['pessoa']),
//                                     );
//                                   }).toList(),
//                                   onChanged: (String novoItemSelecionado) {
//                                     dropDownFavoriteSelected(
//                                         novoItemSelecionado);
//                                     acessosController.firstId.value =
//                                         novoItemSelecionado;
//                                     acessosController.firstId.value != '0'
//                                         ? acessosController.getAFavorite()
//                                         : acessosController.cleanController();
//                                   },
//                                   value: acessosController.firstId.value,
//                                 ),
//                               ),
