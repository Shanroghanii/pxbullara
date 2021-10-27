import 'package:flutter/material.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/services.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AddTextPage extends StatefulWidget {
  @override
  _AddTextPageState createState() => _AddTextPageState();
}

class _AddTextPageState extends State<AddTextPage> {
  bool isEnabled = false;

  TextEditingController controller = TextEditingController();

  Color screenPickerColor;

  // Color for the picker in a dialog using onChanged.
  Color dialogPickerColor;

  // Color for picker using the color select dialog.
  Color dialogSelectColor;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);

    screenPickerColor = Colors.blue; // Material blue.
    dialogPickerColor = Colors.red; // Material red.
    dialogSelectColor = const Color(0xFFA239CA); // A purple color.
  }



  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  List<String> _locations = [
    'Arial',
    'Arial Black',
    'Bahnschrift',
    'Calibri Light',
    'Calibri',
    'Cambria',
    'Candara',
    'Comic Sans MS',
    'Consolas',
    'Constantia',
    'Corbel',
    'Courier New',
    'Ebrima',
    'Gabriola',
    'Gadugi',
    'Georgia',
    'Impact',
    'Ink Free'
  ]; // Option 2
  String _selectedLocation;
  int _value = 32;

  Color currentColor = Colors.limeAccent;
  List<Color> currentColors = [Colors.limeAccent, Colors.green];

  void changeColor(Color color) => setState(() => currentColor = color);

  void changeColors(List<Color> colors) =>
      setState(() => currentColors = colors);

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xff0D0D0D),
      appBar: AppBar(
        backgroundColor: Color(0xff0D0D0D),
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Add Text',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12.0, left: 32, right: 32),
              child: Text(
                'Specify the text you want to display on the Live.',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0, left: 32, right: 32),
              child: Container(
                height: h * 0.08,
                child: TextField(
                  controller: controller,
                  onChanged: (val) {
                    setState(() {
                      isEnabled = true;
                    });
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      fillColor: Color(0x29FFFFFF),
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.0),
                          borderSide: new BorderSide(color: Color(0x29FFFFFF))),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide:
                            BorderSide(color: Color(0x29FFFFFF), width: 0.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide:
                            BorderSide(color: Color(0x29FFFFFF), width: 0.0),
                      ),
                      labelText: 'Text',
                      labelStyle: TextStyle(color: Colors.white)),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Card(
                  color: Color(0xff0D0D0D),
                  elevation: 2,
                  child: ColorPicker(
                    // Use the screenPickerColor as start color.
                    color: screenPickerColor,
                    // Update the screenPickerColor using the callback.
                    onColorChanged: (Color color) =>
                        setState(() => screenPickerColor = color),
                    width: 30,
                    height: 30,
                    borderRadius: 22,
                    heading: Text(
                      'Select color',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    subheading: Text(
                      'Select color shade',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 18.0, left: 32, right: 32),
                child: Text(
                  'Select size',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Slider(
                        value: _value.toDouble(),
                        min: 1.0,
                        max: 100.0,
                        divisions: 100,
                        activeColor: Colors.green,
                        inactiveColor: Colors.grey,
                        // label: '$_value',
                        onChanged: (double newValue) {
                          setState(() {
                            _value = newValue.round();
                          });
                        }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 32.0,left: 5),
                  child: Text('$_value dt',style: TextStyle(color: Colors.white),),
                )
              ],
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 18.0, left: 32, right: 32),
                child: Text(
                  'Select font',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0, left: 22, right: 22),
              child: Container(
                height: h * 0.08,
                decoration: BoxDecoration(
                  color: Color(0x29FFFFFF),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton(
                    dropdownColor: Colors.black,
                    hint: Text(
                        'font                                                             ',
                        style: TextStyle(color: Colors.white)),
                    // Not necessary for Option 1
                    value: _selectedLocation,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedLocation = newValue;
                      });
                    },
                    items: _locations.map((location) {
                      return DropdownMenuItem(
                        child: new Text(
                          location,
                          style: TextStyle(color: Colors.white),
                        ),
                        value: location,
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => OtpPage()),
                // );
                Navigator.pop(context);
                showTopSnackBar(
                  context,
                  CustomSnackBar.success(
                    message: "Added Text Successfully",
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0, left: 32, right: 32),
                child: Container(
                  height: h * 0.08,
                  decoration: BoxDecoration(
                    color: isEnabled ? Colors.green : Color(0xff9D9D9D),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      'Save',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
