import 'package:conformeia/core/styles/colors.dart';
import 'package:conformeia/core/styles/text_style.dart';
import 'package:conformeia/module/home/presenter/widgets/build_drawer.dart';
import 'package:conformeia/module/home/presenter/widgets/compilance_chart.dart';
import 'package:conformeia/module/home/presenter/widgets/table_manager_risk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

class ManagerRiskScreen extends StatelessWidget {
  const ManagerRiskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Gerenciamento de Risco",
          style: GoogleFonts.poppins(
              textStyle: context.appTextStyles.mediumBlack),
        ),
        actions: [
          IconButton(
                  icon: Icon(Icons.analytics, color: AppColors.secondary),
                  onPressed: () {
                    // Navegar para a tela de ComplianceChart ao pressionar este botão
                    Modular.to.push(MaterialPageRoute(builder: (_) => const ComplianceChart()));
                  },
                ),
        ],
      ),
      drawer: buildDrawer(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () => Modular.to.navigate("pda"),
                  child: Icon(
                    Icons.arrow_back,
                    size: 24,
                    color: AppColors.secondary,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Gerenciamento de Risco",
                  style: GoogleFonts.poppins(
                      textStyle: context.appTextStyles.mediumBlack),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const TableManagerRisk(),
          ],
        ),
      ),
    );
  }
}
