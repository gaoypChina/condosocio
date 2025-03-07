import 'package:condosocio/src/components/acessos_saidas/detalhes_acessos_saida.dart';
import 'package:condosocio/src/components/acessos_saidas/visualizar_acessos_saidas.dart';
import 'package:condosocio/src/components/convites/visualizar_convite_widget.dart';
import 'package:condosocio/src/components/convites/whatsapp_convites_widget.dart';
import 'package:condosocio/src/controllers/auth_controller.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:condosocio/src/controllers/theme_controller.dart';
import 'package:condosocio/src/pages/acessos/facial_acesso_detalhe.dart';
import 'package:condosocio/src/pages/acessos/verificarVisitante.dart';
import 'package:condosocio/src/pages/acheAqui/ache_aqui.dart';
import 'package:condosocio/src/pages/acheAqui/ache_aqui_form.dart';
import 'package:condosocio/src/pages/acheAqui/empresa_ache_aqui.dart';
import 'package:condosocio/src/pages/acheAqui/lista_ache_aqui.dart';
import 'package:condosocio/src/pages/acheAqui/pesquisa_ache_aqui.dart';
import 'package:condosocio/src/pages/avisos/avisos.dart';
import 'package:condosocio/src/pages/avisos/detalhes_avisos.dart';
import 'package:condosocio/src/pages/boleto/boleto.dart';
import 'package:condosocio/src/pages/boleto/visualizar_boletos.dart';
import 'package:condosocio/src/pages/encomendas/detalhes_encomendas.dart';
import 'package:condosocio/src/pages/encomendas/encomendas.dart';
import 'package:condosocio/src/pages/enquetes/enquetes.dart';
import 'package:condosocio/src/pages/enquetes/info_enquetes.dart';
import 'package:condosocio/src/pages/enquetes/votar_enquete.dart';
import 'package:condosocio/src/pages/esperaacessos/acessos_espera.dart';
import 'package:condosocio/src/pages/esqueci_senha.dart';
import 'package:condosocio/src/pages/facial/facial.dart';
import 'package:condosocio/src/pages/facial/foto_facial_detalhe.dart';
import 'package:condosocio/src/pages/ocorrencias/foto_ocorrencia_detalhe.dart';
import 'package:condosocio/src/pages/ocorrencias/resposta_ocorrencias.dart';
import 'package:condosocio/src/pages/ocorrencias/visualizar_ocorrencias.dart';
import 'package:condosocio/src/pages/ouvidoria/visualizar_ouvidoria.dart';
import 'package:condosocio/src/pages/reservas/calendario_reservas.dart';
import 'package:condosocio/src/components/reservas/termos_reservas.dart';
import 'package:condosocio/src/pages/dependentes/dependentes.dart';
import 'package:condosocio/src/pages/reservas/add_reservas.dart';
import 'package:condosocio/src/pages/reservas/detalhes_reservas.dart';
import 'package:condosocio/src/pages/reservas/visualizar_reservas.dart';
import 'package:condosocio/src/pages/senha.dart';
import 'package:condosocio/src/pages/alvo_tv.dart';
import 'package:condosocio/src/pages/comunicados/comunicados.dart';
import 'package:condosocio/src/pages/convites.dart';
import 'package:condosocio/src/pages/documento.dart';
import 'package:condosocio/src/pages/documentos_pages/ata_documentos.dart';
import 'package:condosocio/src/pages/documentos_pages/contratos_documentos.dart';
import 'package:condosocio/src/pages/documentos_pages/convencao_documentos.dart';
import 'package:condosocio/src/pages/documentos_pages/editais_documentos.dart';
import 'package:condosocio/src/pages/documentos_pages/outros_documentos.dart';
import 'package:condosocio/src/pages/documentos_pages/prestacao_documentos.dart';
import 'package:condosocio/src/pages/documentos_pages/regulamento_documentos.dart';
import 'package:condosocio/src/pages/home/home_page.dart';
import 'package:condosocio/src/pages/login.dart';
import 'package:condosocio/src/pages/ocorrencias/ocorrencias.dart';
import 'package:condosocio/src/pages/ouvidoria/ouvidoria.dart';
import 'package:condosocio/src/pages/ouvidoria/detalhes_ouvidoria.dart';
import 'package:condosocio/src/pages/perfil.dart';
import 'package:condosocio/src/pages/reservas/reserva.dart';
import 'package:condosocio/src/pages/encomendas/qrcode.dart';
import 'package:condosocio/src/pages/sobre.dart';
import 'package:condosocio/src/pages/acessos/visualizar_acessos.dart';
import 'package:condosocio/src/pages/veiculos/pagVagasLimit.dart';
import 'package:condosocio/src/pages/veiculos/veiculos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'src/components/convites/detalhe_convite_widget.dart';
import 'src/pages/list_of_condo.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeController themeController = Get.put(ThemeController());
  final LoginController loginController = Get.put(LoginController());
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    OneSignal.shared.setAppId('d2a1bd8c-4a9a-4355-ac9b-e52691e7de23');
    // final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      print("Accepted permission: $accepted");
    });

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      var titulo = result.notification.title;
      var subtitulo = result.notification.subtitle;
      print('SUBTITULO $subtitulo');

      print('NOTIFICACAO ABERTA: $titulo');
      authController.rota.value.text = '/login';
      if (titulo == 'CONTROLE DE ACESSO') {
        authController.rota.value.text = '/visualizarAcessos';
      } else if (titulo == 'AVISO!') {
        authController.rota.value.text = '/avisos';
      } else if (titulo == 'COMUNICADO') {
        authController.rota.value.text = '/comunicados';
      } else if (titulo == 'DOCUMENTO') {
        authController.rota.value.text = '/documentos';
      } else if (titulo == 'OCORRÊNCIA RESOLVIDA') {
        authController.rota.value.text = '/ocorrencias';
      } else if (titulo == 'RESERVA') {
        authController.rota.value.text = '/visualizarReservas';
      } else if (titulo == 'OUVIDORIA') {
        authController.rota.value.text = '/visualizarOuvidoria';
      } else if (titulo == 'OCORRÊNCIA') {
        authController.rota.value.text = '/visualizarOcorrencias';
      } else if (titulo == 'RECONHECIMENTO FACIAL') {
        authController.rota.value.text = '/visualizarAcessos';
      } else if (titulo == 'CADASTRO FACIAL') {
        authController.rota.value.text = '/dependentes';
      } else {}
    });

    return GetMaterialApp(
      localizationsDelegates: [
        RefreshLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [Locale('pt')],
      theme: themeController.theme,
      darkTheme: themeController.theme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',

      // navigatorKey: navigatorKey,
      getPages: [
        GetPage(name: '/login', page: () => Login()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/senha', page: () => Senha()),
        GetPage(name: '/perfil', page: () => Perfil()),
        GetPage(name: '/comunicados', page: () => Comunicados()),
        GetPage(name: '/sobre', page: () => Sobre()),
        GetPage(name: '/ouvidoria', page: () => Ouvidoria()),
        GetPage(name: '/ocorrencias', page: () => Ocorrencias()),
        GetPage(name: '/alvoTv', page: () => AlvoTv()),
        GetPage(name: '/visualizarAcessos', page: () => VisualizarAcessos()),
        GetPage(name: '/detalhesOuvidoria', page: () => DetalhesOuvidoria()),
        GetPage(name: '/documentos', page: () => Documentos()),
        GetPage(name: '/ataDocumentos', page: () => Ata()),
        GetPage(name: '/contratosDocumentos', page: () => Contratos()),
        GetPage(name: '/convencaoDocumentos', page: () => Convencao()),
        GetPage(name: '/editaisDocumentos', page: () => Editais()),
        GetPage(name: '/outrosDocumentos', page: () => Outros()),
        GetPage(name: '/prestacaoDocumentos', page: () => Prestacao()),
        GetPage(name: '/regulamentoDocumentos', page: () => Regulamento()),
        GetPage(name: '/reserva', page: () => Reserva()),
        GetPage(name: '/listOfCondo', page: () => ListOfCondo()),
        GetPage(name: '/convites', page: () => Convite()),
        GetPage(name: '/detalhesConvite', page: () => DetalheConviteWidget()),
        GetPage(name: '/whatsAppConvite', page: () => WhatsAppConvitesWidget()),
        GetPage(name: '/dependentes', page: () => Dependentes()),
        GetPage(
            name: '/visualizarAcessosSaidas',
            page: () => VisualizarAcessosSaidas()),
        GetPage(
            name: '/detalhesAcessosSaida', page: () => DetalhesAcessosSaida()),
        GetPage(name: '/addReservas', page: () => AddReservas()),
        GetPage(name: '/calendario', page: () => TableCalendarWidget()),
        GetPage(name: '/termos', page: () => TermosReservas()),
        GetPage(name: '/detalheReservas', page: () => DetalhesReservas()),
        GetPage(name: '/respostaOcorrencia', page: () => RespostaOcorrencias()),
        GetPage(name: '/enquetes', page: () => Enquetes()),
        GetPage(name: '/votarEnquetes', page: () => VotarEnquete()),
        GetPage(name: '/infoEnquete', page: () => InfoEnquetes()),
        GetPage(name: '/fotoOcorrencia', page: () => FotoOcorrencia()),
        GetPage(name: '/acheAqui', page: () => AcheAqui()),
        GetPage(name: '/listaAcheAqui', page: () => ListaAcheAqui()),
        GetPage(name: '/acheAquiForm', page: () => AcheAquiForm()),
        GetPage(name: '/detalhesAcheAqui', page: () => EmpresaAcheAqui()),
        GetPage(name: '/pesquisarAcheAqui', page: () => PesquisaAcheAqui()),
        GetPage(name: '/encomendas', page: () => Encomendas()),
        GetPage(name: '/detalhesEncomendas', page: () => DetalhesEncomendas()),
        GetPage(name: '/qrCode', page: () => QrCode()),
        GetPage(name: '/avisos', page: () => Avisos()),
        GetPage(name: '/detalhesaviso', page: () => DetalhesAvisos()),
        GetPage(name: '/esqueci', page: () => Esqueci()),
        GetPage(name: '/visualizarconvites', page: () => VisualizarConvite()),
        GetPage(name: '/boleto', page: () => BoletoPage()),
        GetPage(name: '/visualizarBoletos', page: () => VisualizarBoletos()),
        GetPage(name: '/visualizarReservas', page: () => VisualizarReservas()),
        GetPage(
            name: '/visualizarOcorrencias',
            page: () => VisualizarOcorrencias()),
        GetPage(
            name: '/visualizarOuvidoria', page: () => VisualizarOuvidoria()),
        GetPage(
            name: '/verificarVisitantes', page: () => VerificarVisitantes()),
        GetPage(name: '/veiculos', page: () => Veiculos()),
        GetPage(name: '/vagasexcedidas', page: () => VagasLimit()),
        GetPage(name: '/facial', page: () => Facial()),
        GetPage(name: '/fotoFacial', page: () => FotoFacial()),
        GetPage(name: '/facialacesso', page: () => FacialAcesso()),
        GetPage(name: '/acessosespera', page: () => AcessosEspera()),
      ],
    );
  }
}
