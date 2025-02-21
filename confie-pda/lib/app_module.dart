import 'package:conformeia/module/home/presenter/screens/home_screen.dart';
import 'package:conformeia/module/home/presenter/screens/manager_risk.dart';
import 'package:conformeia/module/home/presenter/screens/pda_aterramento.dart';
import 'package:conformeia/module/home/presenter/screens/pda_screen.dart';
import 'package:conformeia/module/home/presenter/screens/register_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ChildRoute> get routes => [
        ChildRoute('/', child: (context, args) => const HomeScreen()),
        ChildRoute('/pda-aterramento',
            child: (context, args) => const PdaAterramentoScreen()),
        ChildRoute('/pda', child: (context, args) => const PdaScreen()),
        ChildRoute('/manager-risk',
            child: (context, args) => const ManagerRiskScreen()),
            ChildRoute('/register', child: (context, args) => const RegisterScreen())
      ];
}
