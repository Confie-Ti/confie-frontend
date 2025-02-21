import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PessoalForm extends StatefulWidget {
  const PessoalForm({super.key});

  @override
  State<PessoalForm> createState() => _PessoalFormState();
}

class _PessoalFormState extends State<PessoalForm> {
  String? _selectedRole = "Gerente da Planta";
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _rgController = TextEditingController();
  final TextEditingController _creaController = TextEditingController();
  final TextEditingController _cargoController = TextEditingController();
  final List<Map<String, TextEditingController>> _autorizadosControllers = [];

  @override
  void dispose() {
    _nameController.dispose();
    _rgController.dispose();
    _creaController.dispose();
    _cargoController.dispose();
    for (var controller in _autorizadosControllers) {
      controller['nome']!.dispose();
      controller['rg']!.dispose();
      controller['matricula']!.dispose();
      controller['cargo']!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButton<String>(
            value: _selectedRole,
            hint: const Text("Selecione um cargo"),
            items: const [
              DropdownMenuItem(
                  value: "Gerente da Planta", child: Text("Gerente da Planta")),
              DropdownMenuItem(
                  value: "Profissional habilitado responsável",
                  child: Text("Profissional habilitado responsável")),
              DropdownMenuItem(
                  value: "Responsável pelo PIE",
                  child: Text("Responsável pelo PIE")),
              DropdownMenuItem(
                  value: "Profissionais autorizados",
                  child: Text("Profissionais autorizados")),
            ],
            onChanged: (value) {
              setState(() {
                _selectedRole = value;
                _clearAllFields();
              });
            },
          ),
          const SizedBox(height: 16),
          if (_selectedRole == "Gerente da Planta") _buildGerenteDaPlantaForm(),
          if (_selectedRole == "Profissional habilitado responsável")
            _buildProfissionalHabilitadoForm(),
          if (_selectedRole == "Responsável pelo PIE")
            _buildResponsavelPIEForm(),
          if (_selectedRole == "Profissionais autorizados")
            _buildProfissionaisAutorizadosForm(),
          const SizedBox(height: 16),
          if (_selectedRole != "Profissionais autorizados")
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _addPerson,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Adicionar Pessoa',
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _clearAllFields() {
    _nameController.clear();
    _rgController.clear();
    _creaController.clear();
    _cargoController.clear();
    _autorizadosControllers.clear();
  }

  Widget _buildGerenteDaPlantaForm() {
    return Column(
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
          controller: _rgController,
          decoration: InputDecoration(
            labelText: 'RG',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfissionalHabilitadoForm() {
    return Column(
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
          controller: _rgController,
          decoration: InputDecoration(
            labelText: 'RG',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _creaController,
          decoration: InputDecoration(
            labelText: 'CREA',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _cargoController,
          decoration: InputDecoration(
            labelText: 'Cargo',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResponsavelPIEForm() {
    return Column(
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
          controller: _rgController,
          decoration: InputDecoration(
            labelText: 'RG',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _cargoController,
          decoration: InputDecoration(
            labelText: 'Cargo',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfissionaisAutorizadosForm() {
    if (_autorizadosControllers.isEmpty) {
      _autorizadosControllers.add({
        'nome': TextEditingController(),
        'rg': TextEditingController(),
        'matricula': TextEditingController(),
        'cargo': TextEditingController(),
      });
    }
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: _autorizadosControllers.length,
          itemBuilder: (context, index) {
            final controllers = _autorizadosControllers[index];
            return Column(
              children: [
                TextField(
                  controller: controllers['nome'],
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: controllers['rg'],
                  decoration: InputDecoration(
                    labelText: 'RG',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: controllers['matricula'],
                  decoration: InputDecoration(
                    labelText: 'Número matrícula',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: controllers['cargo'],
                  decoration: InputDecoration(
                    labelText: 'Cargo',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            );
          },
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _autorizadosControllers.add({
                'nome': TextEditingController(),
                'rg': TextEditingController(),
                'matricula': TextEditingController(),
                'cargo': TextEditingController(),
              });
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Adicionar Pessoa',
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _addPerson,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Adicionar Todos',
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
          ),
        ),
      ],
    );
  }

  void _addPerson() {
    if (_selectedRole == "Profissionais autorizados") {
      for (var controllers in _autorizadosControllers) {
        if (controllers['nome']!.text.isEmpty ||
            controllers['rg']!.text.isEmpty ||
            controllers['matricula']!.text.isEmpty ||
            controllers['cargo']!.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Preencha todos os campos obrigatórios")),
          );
          return;
        }
      }
      for (var controllers in _autorizadosControllers) {
        print(
            "Pessoa adicionada: Nome: ${controllers['nome']!.text}, RG: ${controllers['rg']!.text}, Matrícula: ${controllers['matricula']!.text}, Cargo: ${controllers['cargo']!.text}");
      }
    } else {
      if (_nameController.text.isEmpty || _rgController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Preencha todos os campos obrigatórios")),
        );
        return;
      }
      print(
          "Pessoa adicionada: Nome: ${_nameController.text}, RG: ${_rgController.text}");
    }

    _clearAllFields();
  }
}
