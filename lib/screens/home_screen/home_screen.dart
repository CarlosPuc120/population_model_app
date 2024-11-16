import 'package:flutter/material.dart';
import 'package:population_model_app/models/population_model/population_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  double? _growthRate;
  double? _initialPopulation;
  double? _carryingCapacity;
  double? _time;
  double? _result;
  String _model = 'Exponencial'; // Modelo por defecto
  String _missingValue = '';
  String _operations = '';

  void _calculatePopulation() {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();
    _operations = '';
    _missingValue = '';
    _result = null;

    try {
      if (_model == 'Exponencial') {
        // Exponencial - Resolver con los tres valores dados
        if (_initialPopulation != null && _growthRate != null && _time != null) {
          _result = PopulationModel.calculateExponential(
            _initialPopulation!,
            _growthRate!,
            _time!,
          );
          _missingValue = 'Población final (P)';
          _operations =
              'P(t) = P₀ * e^(r * t)\nP(t) = ${_initialPopulation!.toStringAsFixed(2)} * e^(${_growthRate!.toStringAsFixed(4)} * $_time)\nP(t) = ${_result!.toStringAsFixed(2)}\n\nP(t): población o monto final';
        }
        // Exponencial - Resolver si falta el valor de la población final (P)
        else if (_initialPopulation != null && _growthRate != null && _result != null) {
          _time = PopulationModel.calculateTimeExponential(
            _result!,
            _initialPopulation!,
            _growthRate!,
          );
          _missingValue = 'Tiempo (t)';
          _operations =
              't = ln(P / P₀) / r\n t = ln(${_result!.toStringAsFixed(2)} / ${_initialPopulation!.toStringAsFixed(2)}) / ${_growthRate!.toStringAsFixed(4)}\n t = ${_time!.toStringAsFixed(2)}\n\nP(t): población o monto final';
        }
        // Exponencial - Resolver si falta la tasa de crecimiento (r)
        else if (_initialPopulation != null && _time != null && _result != null) {
          _growthRate = PopulationModel.calculateExponentialGrowthRate(
            _result!,
            _initialPopulation!,
            _time!,
          );
          _missingValue = 'Tasa de crecimiento (r)';
          _operations =
              'r = ln(P / P₀) / t\n r = ln(${_result!.toStringAsFixed(2)} / ${_initialPopulation!.toStringAsFixed(2)}) / $_time\n r = ${_growthRate!.toStringAsFixed(4)}\n\nP(t): población o monto final';
        }
      } else if (_model == 'Logístico') {
        // Logístico - Resolver con los tres valores dados
        if (_initialPopulation != null && _growthRate != null && _carryingCapacity != null && _time != null) {
          _result = PopulationModel.calculateLogistic(
            _initialPopulation!,
            _growthRate!,
            _carryingCapacity!,
            _time!,
          );
          _missingValue = 'Población final (P)';
          _operations =
              'P(t) = (K * P₀) / (P₀ + (K - P₀) * e^(-r * t))\nP(t) = (${_carryingCapacity!.toStringAsFixed(2)} * ${_initialPopulation!.toStringAsFixed(2)}) / (${_initialPopulation!.toStringAsFixed(2)} + (${_carryingCapacity!.toStringAsFixed(2)} - ${_initialPopulation!.toStringAsFixed(2)}) * e^(-${_growthRate!.toStringAsFixed(4)} * $_time))\nP(t) = ${_result!.toStringAsFixed(2)}\n\nP(t): población o monto final';
        }
        // Logístico - Resolver si falta el valor de la población final (P)
        else if (_initialPopulation != null && _growthRate != null && _carryingCapacity != null && _result != null) {
          _time = PopulationModel.calculateTimeLogistic(
            _result!,
            _initialPopulation!,
            _growthRate!,
            _carryingCapacity!,
          );
          _missingValue = 'Tiempo (t)';
          _operations =
              't = -ln((K - P) / (K - P₀)) / r\n t = -ln((${_carryingCapacity!.toStringAsFixed(2)} - ${_result!.toStringAsFixed(2)}) / (${_carryingCapacity!.toStringAsFixed(2)} - ${_initialPopulation!.toStringAsFixed(2)})) / ${_growthRate!.toStringAsFixed(4)}\n t = ${_time!.toStringAsFixed(2)}\n\nP(t): población o monto final';
        }
        // Logístico - Resolver si falta la tasa de crecimiento (r)
        else if (_initialPopulation != null && _time != null && _carryingCapacity != null && _result != null) {
          _growthRate = PopulationModel.calculateGrowthRateLogistic(
            _result!,
            _initialPopulation!,
            _carryingCapacity!,
            _time!,
          );
          _missingValue = 'Tasa de crecimiento (r)';
          _operations =
              'r = -ln((K - P) / (K - P₀)) / t\n r = -ln((${_carryingCapacity!.toStringAsFixed(2)} - ${_result!.toStringAsFixed(2)}) / (${_carryingCapacity!.toStringAsFixed(2)} - ${_initialPopulation!.toStringAsFixed(2)})) / $_time\n r = ${_growthRate!.toStringAsFixed(4)}\n\nP(t): población o monto final';
        }
        // Logístico - Resolver si falta la capacidad de carga (K)
        else if (_initialPopulation != null && _growthRate != null && _time != null && _result != null) {
          _carryingCapacity = PopulationModel.calculateCarryingCapacityLogistic(
            _result!,
            _initialPopulation!,
            _growthRate!,
            _time!,
          );
          _missingValue = 'Capacidad de carga (K)';
          _operations =
              'K = P(t) * (P₀ + (K - P₀) * e^(-r * t)) / P₀\n K = ${_result!.toStringAsFixed(2)} * (${_initialPopulation!.toStringAsFixed(2)} + (${_carryingCapacity!.toStringAsFixed(2)} - ${_initialPopulation!.toStringAsFixed(2)}) * e^(-${_growthRate!.toStringAsFixed(4)} * $_time)) / ${_initialPopulation!.toStringAsFixed(2)}\n K = ${_carryingCapacity!.toStringAsFixed(2)}\n\nP(t): población o monto final';
        }
      }

      if (_result == null) {
        throw Exception('Datos incompletos para el cálculo.');
      }

      setState(() {});
    } catch (e) {
      setState(() {
        _missingValue = 'Error: Datos inválidos.';
        _operations = 'Por favor verifica los datos ingresados.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modelo de Población'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  value: _model,
                  items: ['Exponencial', 'Logístico']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) => setState(() => _model = value!),
                  decoration: InputDecoration(labelText: 'Modelo'),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Población inicial (P₀)'),
                  onSaved: (value) => _initialPopulation = double.tryParse(value!),
                  validator: (value) => value == null || value.isEmpty ? 'Ingrese un valor válido' : null,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Tasa de crecimiento (r)'),
                  onSaved: (value) => _growthRate = double.tryParse(value!),
                  validator: (value) => value == null || value.isEmpty ? 'Ingrese un valor válido' : null,
                ),
                if (_model == 'Logístico')
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Capacidad de carga (K)'),
                    onSaved: (value) => _carryingCapacity = double.tryParse(value!),
                    validator: (value) => value == null || value.isEmpty ? 'Ingrese un valor válido' : null,
                  ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Tiempo (t)'),
                  onSaved: (value) => _time = double.tryParse(value!),
                  validator: (value) => value == null || value.isEmpty ? 'Ingrese un valor válido' : null,
                ),
                ElevatedButton(
                  onPressed: _calculatePopulation,
                  child: Text('Calcular'),
                ),
                if (_missingValue.isNotEmpty)
                  Text(
                    'Dato calculado: $_missingValue',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                if (_operations.isNotEmpty)
                  Text(
                    'Operaciones:\n$_operations',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
