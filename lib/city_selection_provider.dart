import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CitySelectionProvider extends ChangeNotifier {
  bool _isLoading = true;
  get isLoading => _isLoading;
  List<String> _statesList = [];
  get statesList => _statesList;
  Map<String, List<String>> _citiesList = {};
  get citiesList => _citiesList;
  String _selectedState = '';
  String get selectedState => _selectedState;
  String _selectedCity = '';
  String get selectedCity => _selectedCity;
  getStates() async {
    _isLoading = true;
    notifyListeners();
    var stateDataInBytes = await rootBundle.loadString('assets/states.json');
    var stateDataJson = jsonDecode(stateDataInBytes);
    _statesList = stateDataJson["states"].cast<String>();
    for (var state in statesList) {
      citiesList[state] = stateDataJson[state].cast<String>();
    }
    _isLoading = false;
    notifyListeners();
  }

  selectedStateValue(var state) {
    _selectedState = state;
    _selectedCity = '';
    notifyListeners();
  }

  selectedCityValue(var state) {
    _selectedCity = state;
    notifyListeners();
  }
}
