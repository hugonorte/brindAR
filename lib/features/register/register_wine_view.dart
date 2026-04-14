import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:brindar/core/models/wine.dart';
import 'package:brindar/core/providers/wine_provider.dart';
import 'package:brindar/core/theme.dart';

class RegisterWineView extends StatefulWidget {
  const RegisterWineView({super.key});

  @override
  State<RegisterWineView> createState() => _RegisterWineViewState();
}

class _RegisterWineViewState extends State<RegisterWineView> {
  final _formKey = GlobalKey<FormState>();
  bool _isSaving = false;

  // Controllers
  late final TextEditingController _nameCtrl;
  late final TextEditingController _barcodeCtrl;
  late final TextEditingController _originCtrl;
  late final TextEditingController _regionCtrl;
  late final TextEditingController _grapeCtrl;
  late final TextEditingController _vintageCtrl;
  late final TextEditingController _abvCtrl;
  late final TextEditingController _temperatureCtrl;
  late final TextEditingController _scoreCtrl;
  late final TextEditingController _noteCtrl;

  String _body = 'Medium';
  Wine? _editingWine; // non-null when editing an existing wine

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController();
    _barcodeCtrl = TextEditingController();
    _originCtrl = TextEditingController();
    _regionCtrl = TextEditingController();
    _grapeCtrl = TextEditingController();
    _vintageCtrl = TextEditingController();
    _abvCtrl = TextEditingController();
    _temperatureCtrl = TextEditingController();
    _scoreCtrl = TextEditingController();
    _noteCtrl = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args is Wine) {
      // Edit mode: pre-fill all fields with the existing wine
      if (_editingWine == null) {
        _editingWine = args;
        _nameCtrl.text = args.name;
        _barcodeCtrl.text = args.barcode;
        _originCtrl.text = args.origin;
        _regionCtrl.text = args.region;
        _grapeCtrl.text = args.type;
        _vintageCtrl.text = args.vintage;
        _abvCtrl.text = args.abv.replaceAll('%', '');
        _temperatureCtrl.text = args.temperature.replaceAll('°C', '');
        _scoreCtrl.text = args.score.replaceAll(' PTS', '');
        _noteCtrl.text = args.sommelierNote;
        _body = args.body;
      }
    } else if (args is String) {
      // Register mode: barcode pre-filled from scan
      if (_barcodeCtrl.text.isEmpty) {
        _barcodeCtrl.text = args;
      }
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _barcodeCtrl.dispose();
    _originCtrl.dispose();
    _regionCtrl.dispose();
    _grapeCtrl.dispose();
    _vintageCtrl.dispose();
    _abvCtrl.dispose();
    _temperatureCtrl.dispose();
    _scoreCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    final wine = Wine(
      id: _editingWine?.id ?? const Uuid().v4(),
      barcode: _barcodeCtrl.text.trim(),
      name: _nameCtrl.text.trim(),
      type: _grapeCtrl.text.trim(),
      origin: _originCtrl.text.trim(),
      region: _regionCtrl.text.trim(),
      vintage: _vintageCtrl.text.trim(),
      score: _scoreCtrl.text.trim().isNotEmpty
          ? '${_scoreCtrl.text.trim()} PTS'
          : '—',
      abv: '${_abvCtrl.text.trim()}%',
      body: _body,
      temperature: '${_temperatureCtrl.text.trim()}°C',
      tag: '',
      sommelierNote: _noteCtrl.text.trim(),
    );

    final provider = context.read<WineProvider>();
    if (_editingWine != null) {
      await provider.updateWine(wine);
    } else {
      await provider.saveWine(wine);
    }

    if (mounted) {
      Navigator.pop(context); // go back to scan / library
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = _editingWine != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? 'Editar vinho' : 'Cadastrar vinho',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          children: [
            _buildField(
              controller: _barcodeCtrl,
              label: 'Código de barras (EAN-13 / UPC-A)',
              readOnly: true,
              icon: LucideIcons.barChart2,
            ),
            _buildDivider('Identificação'),
            _buildField(
              controller: _nameCtrl,
              label: 'Nome do vinho',
              icon: LucideIcons.wine,
              validator: _required,
            ),
            _buildField(
              controller: _grapeCtrl,
              label: 'Uva / Tipo',
              icon: LucideIcons.grape,
              validator: _required,
            ),
            _buildField(
              controller: _originCtrl,
              label: 'País de origem',
              icon: LucideIcons.flag,
              validator: _required,
            ),
            _buildField(
              controller: _regionCtrl,
              label: 'Região / Denominação',
              icon: LucideIcons.mapPin,
              validator: _required,
            ),
            _buildField(
              controller: _vintageCtrl,
              label: 'Safra (ano)',
              icon: LucideIcons.calendar,
              keyboardType: TextInputType.number,
              validator: _required,
            ),
            _buildDivider('Ficha Técnica'),
            _buildField(
              controller: _abvCtrl,
              label: 'Teor alcoólico (%)',
              icon: LucideIcons.percent,
              keyboardType: TextInputType.number,
              validator: _required,
            ),
            _buildField(
              controller: _temperatureCtrl,
              label: 'Temperatura ideal de serviço (°C)',
              icon: LucideIcons.thermometer,
              keyboardType: TextInputType.number,
              validator: _required,
            ),
            const SizedBox(height: 8),
            _buildBodySelector(),
            _buildDivider('Avaliação (opcional)'),
            _buildField(
              controller: _scoreCtrl,
              label: 'Expert Score (0–100)',
              icon: LucideIcons.star,
              keyboardType: TextInputType.number,
            ),
            _buildField(
              controller: _noteCtrl,
              label: 'Nota do Sommelier',
              icon: LucideIcons.edit3,
              maxLines: 3,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: _isSaving ? null : _submit,
                child: _isSaving
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        isEditing ? 'Salvar alterações' : 'Cadastrar vinho',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool readOnly = false,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        maxLines: maxLines,
        keyboardType: keyboardType,
        validator: validator,
        style: Theme.of(context).textTheme.bodyLarge,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, size: 18),
          filled: readOnly,
          fillColor: readOnly ? AppTheme.surfaceContainerLow : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFDDD8CE)),
          ),
        ),
      ),
    );
  }

  Widget _buildBodySelector() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Corpo',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Row(
            children: ['Light', 'Medium', 'Full'].map((option) {
              final selected = _body == option;
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: ChoiceChip(
                  label: Text(option),
                  selected: selected,
                  onSelected: (_) => setState(() => _body = option),
                  selectedColor: AppTheme.primary,
                  labelStyle: TextStyle(
                    color: selected ? Colors.white : AppTheme.onBackground,
                    fontWeight:
                        selected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Text(
            label.toUpperCase(),
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(width: 12),
          const Expanded(child: Divider()),
        ],
      ),
    );
  }

  String? _required(String? value) {
    if (value == null || value.trim().isEmpty) return 'Campo obrigatório';
    return null;
  }
}
