import 'package:conformeia/module/home/presenter/widgets/build_drawer.dart';
import 'package:conformeia/module/home/presenter/widgets/form_empresa.dart';
import 'package:conformeia/module/home/presenter/widgets/form_estrutura_setores.dart';
import 'package:conformeia/module/home/presenter/widgets/form_pessoal.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: buildDrawer(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TabBar(
              controller: _tabController,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.orange,
              ),
              tabs: const [
                Tab(text: "Empresa"),
                Tab(text: "Pessoal"),
                Tab(text: "Estrutura/Setores"),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  EmpresaForm(),
                  PessoalForm(),
                  EstruturaSetoresForm(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
