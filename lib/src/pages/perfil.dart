import 'dart:io';
import 'package:condosocio/src/components/utils/alert_button_pressed.dart';
import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/components/utils/edge_alert_widget.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:condosocio/src/controllers/perfil_controller.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:condosocio/src/components/utils/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../components/utils/edge_alert_error_widget.dart';

class Perfil extends StatefulWidget {
  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  LoginController loginController = Get.put(LoginController());
  PerfilController perfilController = Get.put(PerfilController());

  void dropDownFavoriteSelected(String novoItem) {
    perfilController.firstId.value = novoItem;
  }

  File? _selectedFile;
  final _picker = ImagePicker();

  final uri =
      Uri.parse("https://www.alvocomtec.com.br/flutter/upload_imagem.php");

  Widget getImageWidget() {
    if (_selectedFile != null) {
      return GestureDetector(
        onTap: () {
          loginController.condofacial.value == "NAO"
              ? _configurandoModalBottomSheet(context)
              : getImage(ImageSource.camera);
        },
        child: Container(
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.only(left: 40, bottom: 5),
                  child: Center(
                    child: Icon(
                      Icons.edit,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.secondary,
                  )),
            ],
          ),
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
              image: new FileImage(_selectedFile!),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          _configurandoModalBottomSheet(context);
        },
        child: loginController.imgperfil.value == ''
            ? Container(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 40, bottom: 5),
                      child: Center(
                        child: Icon(
                          Icons.edit,
                          size: 20,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor!,
                        ),
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('images/user.png'),
                  ),
                ),
              )
            : Container(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 40, bottom: 5),
                      child: Center(
                        child: Icon(
                          Icons.edit,
                          size: 20,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor!,
                        ),
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://alvocomtec.com.br/acond/downloads/fotosperfil/${loginController.imgperfil.value}'),
                  ),
                ),
              ),
      );
    }
  }

  /*getImage(ImageSource source) async {
    this.setState(() {});
    PickedFile? image = await _picker.getImage(source: source);
    if (image != null) {
      File? cropped = await ImageCropper().cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 80,
          maxWidth: 400,
          maxHeight: 400,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            toolbarColor: Colors.deepOrange,
            toolbarTitle: "Imagem para o Perfil",
            statusBarColor: Colors.deepOrange.shade900,
            backgroundColor: Colors.white,
          ));

      this.setState(() {
        _selectedFile = File(image.path);
        _selectedFile = cropped;
        if (cropped != null) {
          uploadImage();
          //Get.back();
          Get.toNamed('/facial');
        }
      });
    }
  }*/
  Future<void> getImage(ImageSource source) async {
    print('CHEGOU GET IMAGEM');
    final image = await _picker.pickImage(source: source);
    if (image != null) {
      final CroppedFile? cropped = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 80,
        maxWidth: 400,
        maxHeight: 400,
        compressFormat: ImageCompressFormat.jpg,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Imagem Para Perfil',
            toolbarColor: Colors.deepOrange,
            initAspectRatio: CropAspectRatioPreset.original,
            statusBarColor: Colors.deepOrange.shade900,
            backgroundColor: Colors.white,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: 'Cortar Imagem',
          ),
        ],
      );

      this.setState(() {
        _selectedFile = File(image.path);
        if (cropped != null) {
          _selectedFile = File(cropped.path);
          uploadImage();
          Get.back();
        }
      });
    }
  }

  Future uploadImage() async {
    var request = http.MultipartRequest('POST', uri);
    request.fields['idusu'] = loginController.id.value;
    var pic = await http.MultipartFile.fromPath("image", _selectedFile!.path);
    request.files.add(pic);
    var response = await request.send();
    if (response.statusCode == 200) {
      loginController.newLogin(loginController.id.value);
      showToast(context, 'Parabéns! Imagem do perfil alterada!', '');
    } else {
      Navigator.of(context).pop();
      showToastError(
        context,
        'Houve Algum Erro! Tente Novamente',
      );
    }
    _selectedFile = null;
  }

  void _configurandoModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            color: Theme.of(context).colorScheme.secondary,
            padding: EdgeInsets.only(bottom: 30),
            child: Wrap(
              children: <Widget>[
                ListTile(
                    title: Center(
                        child: Text(
                  "Alterar Imagem",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor!),
                ))),
                Divider(
                  height: 20,
                  color: Theme.of(context).textSelectionTheme.selectionColor!,
                ),
                ListTile(
                    leading: new Icon(
                      Icons.camera_alt,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor!,
                    ),
                    title: new Text(
                      'Câmera',
                      style: GoogleFonts.montserrat(
                          fontSize: 16,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor!),
                    ),
                    trailing: new Icon(
                      Icons.arrow_right,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor!,
                    ),
                    onTap: () => {getImage(ImageSource.camera)}),
                Divider(
                  height: 20,
                  color: Theme.of(context).textSelectionTheme.selectionColor!,
                ),
                ListTile(
                    leading: new Icon(Icons.collections,
                        color: Theme.of(context)
                            .textSelectionTheme
                            .selectionColor!),
                    title: new Text(
                      'Galeria',
                      style: GoogleFonts.montserrat(
                          fontSize: 16,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor!),
                    ),
                    trailing: new Icon(Icons.arrow_right,
                        color: Theme.of(context)
                            .textSelectionTheme
                            .selectionColor!),
                    onTap: () => {getImage(ImageSource.gallery)}),
                Divider(
                  height: 20,
                  color: Theme.of(context).textSelectionTheme.selectionColor!,
                ),
                SizedBox(
                  height: 15,
                )
              ],
            ),
          );
        });
  }

  //Mudar para os campos que terão no condosocio, por enquanto usando backend da focus
  DateTime data = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Perfil',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                color: Theme.of(context).textSelectionTheme.selectionColor!,
              ),
            ),
            centerTitle: true,
          ),
          body: Obx(() {
            return perfilController.isLoading.value
                ? CircularProgressIndicatorWidget()
                : SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.all(8),
                      height: MediaQuery.of(context).size.height * .95,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Column(
                            children: [
                              getImageWidget(),
                              SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  _configurandoModalBottomSheet(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Text(
                                    'Alterar foto de perfil',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor!,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          customTextField(
                            context,
                            'Nome',
                            '',
                            false,
                            1,
                            50,
                            true,
                            perfilController.name.value,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          customTextField(
                            context,
                            'Sobrenome',
                            '',
                            false,
                            1,
                            100,
                            true,
                            perfilController.secondName.value,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              perfilController.birthDateMaskFormatter
                            ],
                            controller: perfilController.birthdate.value,
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor!,
                            ),
                            decoration: InputDecoration(
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor!,
                                  width: 1,
                                ),
                              ),
                              labelText: 'Data de aniversário',
                              labelStyle: GoogleFonts.montserrat(
                                fontSize: 14,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor!,
                              ),
                              isDense: true,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor!,
                                  width: 2,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor!,
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 7),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor!,
                                width: 1,
                              ),
                            ),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              underline: Container(),
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                size: 27,
                              ),
                              iconEnabledColor: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor!,
                              dropdownColor: Theme.of(context).primaryColor,
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor!,
                              ),
                              items: perfilController.tipos
                                  .map((String dropDownStringItem) {
                                return DropdownMenuItem<String>(
                                  value: dropDownStringItem,
                                  child: Text(dropDownStringItem),
                                );
                              }).toList(),
                              onChanged: (String? novoItemSelecionado) {
                                dropDownFavoriteSelected(novoItemSelecionado!);
                                perfilController.itemSelecionado.value =
                                    novoItemSelecionado;
                              },
                              value: perfilController.itemSelecionado.value,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              perfilController.cellMaskFormatter
                            ],
                            controller: perfilController.phone.value,
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor!,
                            ),
                            decoration: InputDecoration(
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor!,
                                  width: 1,
                                ),
                              ),
                              labelText: 'Celular',
                              labelStyle: GoogleFonts.montserrat(
                                fontSize: 14,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor!,
                              ),
                              isDense: true,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor!,
                                  width: 2,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor!,
                                  width: 1,
                                ),
                              ),
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
                                        .colorScheme
                                        .secondary;
                                  },
                                ),
                                shape: MaterialStateProperty.resolveWith<
                                    OutlinedBorder>(
                                  (Set<MaterialState> states) {
                                    return RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    );
                                  },
                                ),
                              ),
                              onPressed: () {
                                perfilController.editPerfil().then((value) {
                                  print('VALUE:$value');
                                  if (value == 1) {
                                    showToast(
                                        context,
                                        'Parabéns! Seu perfil foi atualizado com sucesso.',
                                        '');
                                  } else if (value == "vazio") {
                                    onAlertButtonPressed(
                                        context,
                                        'Algum Campo Vazio!',
                                        '',
                                        'images/error.png');
                                  } else {
                                    onAlertButtonPressed(
                                        context,
                                        'Algo deu errado\n Tente novamente',
                                        '',
                                        'images/error.png');
                                  }
                                });
                              },
                              child: Text(
                                "Enviar",
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor!,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
          })),
    );
  }
}
