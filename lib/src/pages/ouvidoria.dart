import 'package:condosocio/src/components/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Ouvidoria extends StatefulWidget {
  @override
  _OuvidoriaState createState() => _OuvidoriaState();
}

class _OuvidoriaState extends State<Ouvidoria> {
  TextEditingController message = new TextEditingController();

  bool isLoading = false;
  String nomeCidade = '';
  var _assuntos = [
    'Selecione',
    'Reclamação',
    'Solicitação',
    'Sugestão',
    'Elogio',
    'Boleto 2ª via',
    'Acordo para pagamento',
    'Alteração de titularidade',
    'Alteração de usuário',
    'Outro'
  ];
  var _itemSelecionado = 'Selecione';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Ouvidoria', style: GoogleFonts.poppins(fontSize: 20)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: Text(
                    'Assunto',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                      width: 1,
                    ),
                  ),
                  child: DropdownButton<String>(
                    isDense: true,
                    isExpanded: true,
                    underline: Container(),
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      size: 27,
                    ),
                    iconEnabledColor:
                        Theme.of(context).textSelectionTheme.selectionColor,
                    dropdownColor: Theme.of(context).primaryColor,
                    style: GoogleFonts.poppins(fontSize: 16),
                    items: _assuntos.map((String dropDownStringItem) {
                      return DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem),
                      );
                    }).toList(),
                    onChanged: (String novoItemSelecionado) {
                      _dropDownItemSelected(novoItemSelecionado);
                      setState(() {
                        this._itemSelecionado = novoItemSelecionado;
                      });
                    },
                    value: _itemSelecionado,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                customTextField(
                  context,
                  "Mensagem",
                  null,
                  true,
                  5,
                  true,
                  message,
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: ButtonTheme(
                    height: 50.0,
                    child: RaisedButton(
                      elevation: 3,
                      onPressed: () {
                        if (_itemSelecionado == 'Selecione') {
                          print('nao pode');
                        }
                        setState(() {
                          isLoading = true;
                        });
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: isLoading
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              ),
                            )
                          : Text(
                              "ENVIAR",
                              style: GoogleFonts.poppins(
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                  fontSize: 16),
                            ),
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: ButtonTheme(
                    height: 50.0,
                    child: RaisedButton(
                      elevation: 3,
                      onPressed: () {
                        Navigator.pushNamed(context, '/visualizarOuvidoria');
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Text(
                        "VISUALIZE MANIFESTAÇÕES",
                        style: GoogleFonts.poppins(
                            color: Colors.black, fontSize: 16),
                      ),
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _dropDownItemSelected(String novoItem) {
    setState(() {
      this._itemSelecionado = novoItem;
    });
    print(_itemSelecionado);
  }
}
