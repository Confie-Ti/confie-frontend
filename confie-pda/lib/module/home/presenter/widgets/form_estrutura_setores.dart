import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';
import 'package:conformeia/module/home/infra/data/cache_manager.dart';

class EstruturaSetoresForm extends StatefulWidget {
  const EstruturaSetoresForm({super.key});

  @override
  State<EstruturaSetoresForm> createState() => _EstruturaSetoresFormState();
}

class _EstruturaSetoresFormState extends State<EstruturaSetoresForm> {
  final TextEditingController _sectorNumberController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _selectedPdfPath;

  @override
  void dispose() {
    _sectorNumberController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          TextField(
            controller: _sectorNumberController,
            decoration: InputDecoration(
              labelText: 'Numero do Setor',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 8),
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
            controller: _descriptionController,
            decoration: InputDecoration(
              labelText: 'Descricao',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.attach_file),
              Text(_selectedPdfPath?.split('/').last ?? "Nenhum arquivo selecionado",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                  )),
              TextButton(
                onPressed: _selectPdf,
                child: Text("Selecionar PDF"),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _addItem,
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
    );
  }

  void _selectPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _selectedPdfPath = result.files.single.path;
      });
    }
  }

  void _addItem() async {
    final sector = {
      'sectorNumber': _sectorNumberController.text,
      'name': _nameController.text,
      'description': _descriptionController.text,
      'pdfPath': _selectedPdfPath ?? '',
    };

    // Lógica para adicionar o item ao cache
    await CacheManager().saveSector(sector);

    // Limpar os campos após adicionar
    _sectorNumberController.clear();
    _nameController.clear();
    _descriptionController.clear();
    setState(() {
      _selectedPdfPath = null;
    });

    // Atualizar a tabela de risco
    setState(() {});
  }
}
