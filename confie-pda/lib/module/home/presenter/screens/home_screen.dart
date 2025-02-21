import 'package:conformeia/core/styles/colors.dart';
import 'package:conformeia/core/styles/text_style.dart';
import 'package:conformeia/module/home/presenter/widgets/build_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        drawer: buildDrawer(context),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Sistema de Conformidade",
                style: GoogleFonts.poppins(
                    textStyle: context.appTextStyles.mediumBlack),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () => Modular.to.navigate("pda-aterramento"),
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: 336,
                  decoration: BoxDecoration(
                      color: AppColors.onPrimary,
                      borderRadius: BorderRadius.circular(16)),
                  child: Text(
                    "PDA e Aterramento",
                    style: context.appTextStyles.smallWhite,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
