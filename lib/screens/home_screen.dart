import 'package:flutter/material.dart';
import 'package:fosfor_calculator/widgets/aboutMaker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  final items = ["Juda ko'p", "Yetarli", "O'rta", "Kam", "Juda kam"];

  String dropdownValue = "Juda ko'p";

  double? _result;

  void calculateFosfor() {
    double controllerValue = double.parse(_controller.text);

    double minValue = controllerValue * 1.5;

    if (dropdownValue == "Juda ko'p") {
      _result = minValue * 1;
    } else if (dropdownValue == "Yetarli") {
      _result = minValue * 2;
    } else if (dropdownValue == "O'rta") {
      _result = minValue * 3;
    } else if (dropdownValue == "Kam") {
      _result = minValue * 4;
    } else if (dropdownValue == "Juda kam") {
      _result = minValue * 5;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Fosfor Calculator"),
      ),
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(
                height: 140,
              ),
              Column(
                children: [
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Maydon o'lchami (sentnerda)",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'(\d+)').hasMatch(value)) {
                          return "Raqam kiriting";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                          height: 40,
                          width: 150,
                          child: Text(
                            "Tuproq to'yinganlik darajasi =>",
                            textAlign: TextAlign.center,
                          )),
                      const SizedBox(
                        width: 30,
                      ),
                      DropdownButton<String>(
                        value: dropdownValue,
                        items:
                            items.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 300,
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),

                  // #Hisobla_Button

                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 18),
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        final isValidForm = formKey.currentState!.validate();
                        if (isValidForm) {
                          setState(() {
                            calculateFosfor();
                            if (_result != null) {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: const Text('Natija'),
                                        content: Text(
                                          "Zarur Fosfor miqdori => ${_result?.toStringAsFixed(2)}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text(
                                                'OK',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 22),
                                              ))
                                        ],
                                      ));
                            }
                          });
                        }
                      },
                      child: const Text(
                        "Hisobla",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  if (_result != null)
                    Text(
                      "Zarur Fosfor miqdori => ${_result?.toStringAsFixed(2)}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                ],
              ),
              const Spacer(),

              // #AboutMaker
              const AboutMaker(),

              const SizedBox(
                height: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
