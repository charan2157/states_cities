import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/city_selection_provider.dart';
import 'package:provider/provider.dart';

class CitySelectionScreen extends StatefulWidget {
  const CitySelectionScreen({super.key});

  @override
  State<CitySelectionScreen> createState() => _CitySelectionScreenState();
}

class _CitySelectionScreenState extends State<CitySelectionScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CitySelectionProvider>(context, listen: false).getStates();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Consumer<CitySelectionProvider>(
        builder: (context, value, widget) {
          if (value.isLoading) {
            return const CircularProgressIndicator();
          }
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButtonFormField(
                    key: UniqueKey(),
                    hint: const Text('select State'),
                    value: value.selectedState.isNotEmpty
                        ? value.selectedState
                        : null,
                    items: getStatesList(value.statesList),
                    onChanged: (currSelection) {
                      Provider.of<CitySelectionProvider>(context, listen: false)
                          .selectedStateValue(currSelection);
                    }),
                const SizedBox(
                  height: 20,
                ),
                value.selectedState.isNotEmpty
                    ? DropdownButtonFormField(
                        hint: const Text('select city'),
                        key: UniqueKey(),
                        value: value.selectedCity.isNotEmpty
                            ? value.selectedCity
                            : null,
                        items: getCitiesList(
                            value.citiesList[value.selectedState]),
                        onChanged: (currSelection) {
                          Provider.of<CitySelectionProvider>(context,
                                  listen: false)
                              .selectedCityValue(currSelection);
                        })
                    : Container(),
              ],
            ),
          );
        },
      )),
    );
  }

  List<DropdownMenuItem> getStatesList(List<String> states) {
    return states.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }

  List<DropdownMenuItem> getCitiesList(List<String> cities) {
    return cities.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }
}
