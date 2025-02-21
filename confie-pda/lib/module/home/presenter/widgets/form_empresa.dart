import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmpresaForm extends StatefulWidget {
  const EmpresaForm({super.key});

  @override
  State<EmpresaForm> createState() => _EmpresaFormState();
}

class _EmpresaFormState extends State<EmpresaForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _segmentoController = TextEditingController();
  final TextEditingController _cnpjController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _areaController.dispose();
    _segmentoController.dispose();
    _cnpjController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _areaController,
              decoration: InputDecoration(
                labelText: 'Área',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _segmentoController,
              decoration: InputDecoration(
                labelText: 'Segmento',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _cnpjController,
              decoration: InputDecoration(
                labelText: 'CNPJ',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _addEmpresa,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Adicionar',
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addEmpresa() {
    if (_nameController.text.isEmpty ||
        _areaController.text.isEmpty ||
        _segmentoController.text.isEmpty ||
        _cnpjController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Preencha todos os campos obrigatórios")),
      );
      return;
    }

    // Adicione a lógica para processar os dados conforme necessário
    print(
        "Empresa adicionada: Nome: ${_nameController.text}, Área: ${_areaController.text}, Segmento: ${_segmentoController.text}, CNPJ: ${_cnpjController.text}");

    // Limpar os campos após adicionar
    _nameController.clear();
    _areaController.clear();
    _segmentoController.clear();
    _cnpjController.clear();
  }
}
