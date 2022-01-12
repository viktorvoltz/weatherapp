import 'package:flutter/material.dart';

class DropDownWIdget extends StatefulWidget {
  const DropDownWIdget({ Key? key }) : super(key: key);

  @override
  _DropDownWIdgetState createState() => _DropDownWIdgetState();
}

class _DropDownWIdgetState extends State<DropDownWIdget> {

  String dropdownvalue = 'london';

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: dropdownvalue,
      icon: Icon(Icons.arrow_drop_down),
      onChanged: (String? newValue){
        setState(() {
          dropdownvalue = newValue!;
        });
      },
      items: <String>['nsukka', 'london', 'cairo', 'tokyo'].map<DropdownMenuItem<String>>((String value){
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList()
    );
  }
}