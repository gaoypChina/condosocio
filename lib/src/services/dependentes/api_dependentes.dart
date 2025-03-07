import 'package:condosocio/src/controllers/dependentes_controller.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiDependentes {
  static Future<dynamic> sendDependentes() async {
    LoginController loginController = Get.put(LoginController());
    DependentesController dependentesController =
        Get.put(DependentesController());
    print(dependentesController.isChecked.value);

    print('idusu: ${loginController.id.value}');
    print('idcond: ${loginController.idcond.value}');
    print('nome: ${dependentesController.nome.value.text}');
    print('sobrenome: ${dependentesController.sobrenome.value.text}');
    print('email: ${dependentesController.email.value.text}');
    print('genero: ${dependentesController.itemSelecionado.value}');
    print('celular: ${dependentesController.celular.value.text}');
    print('tipo: ${dependentesController.tipoUsuario.value}');
    print('horaEnt: ${dependentesController.startDate.value}');
    print('horaSai: ${dependentesController.endDate.value}');
    print('acesso: ${dependentesController.isChecked.value.toString()}');

    return await http.post(
      Uri.https("www.alvocomtec.com.br", "/flutter/dependentes_incluir.php"),
      body: {
        'idusu': loginController.id.value,
        'idcond': loginController.idcond.value,
        'nome': dependentesController.nome.value.text,
        'sobrenome': dependentesController.sobrenome.value.text,
        'email': dependentesController.email.value.text,
        'genero': dependentesController.itemSelecionado.value,
        'celular': dependentesController.celular.value.text,
        'tipo': dependentesController.tipoUsuario.value,
        'horaEnt': dependentesController.startDate.value,
        'horaSai': dependentesController.endDate.value,
        'acesso': dependentesController.isChecked.value.toString(),
      },
    );
  }

  static Future getDependentes() async {
    LoginController loginController = Get.put(LoginController());

    return await http.post(
      Uri.https('www.alvocomtec.com.br', '/flutter/dependentes_buscar.php'),
      body: {
        'idusu': loginController.id.value,
        'idcond': loginController.idcond.value,
      },
    );
  }

  static Future changeStatus(String status) async {
    DependentesController dependentesController =
        Get.put(DependentesController());

    return await http.get(
      Uri.https(
          'www.alvocomtec.com.br',
          '/flutter/dependentes_status_mudar.php',
          {'idep': dependentesController.idep.value, 'status': status}),
    );
  }

  static Future reenviarEmail(String email) async {
    DependentesController dependentesController =
        Get.put(DependentesController());

    return await http.post(
      Uri.https('www.alvocomtec.com.br', '/acond/enviarEmail.php'),
      body: {
        'idusu': dependentesController.idep.value,
        'email': email,
      },
    );
  }

  static Future deleteDependente() async {
    DependentesController dependentesController =
        Get.put(DependentesController());

    return await http.get(
      Uri.https('www.alvocomtec.com.br', '/flutter/dependente_excluir.php',
          {'idep': dependentesController.idep.value}),
    );
  }

  static Future delFace() async {
    DependentesController dependentesController =
        Get.put(DependentesController());

    return await http.get(
      Uri.https('www.alvocomtec.com.br', '/flutter/face_excluir.php',
          {'idep': dependentesController.idep.value}),
    );
  }

  static Future sendWhatsApp(String celular) async {
    LoginController loginController = Get.put(LoginController());
    return await http.get(
      Uri.https(
          'www.alvocomtec.com.br', '/flutter/prestador_whatsapp_chave.php', {
        'celular': celular,
        'idusu': loginController.id.value,
      }),
    );
  }
}
