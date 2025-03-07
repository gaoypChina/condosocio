import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiComunicados {
  static Future getComunicados() async {
    LoginController loginController = Get.put(LoginController());
    return await http.get(Uri.https("www.alvocomtec.com.br",
        "/flutter/comunicados_real.php", {"idusu": loginController.id.value}));
  }
}
