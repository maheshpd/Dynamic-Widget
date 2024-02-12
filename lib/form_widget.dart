import 'package:flutter/material.dart';

class DynamicWidgetForm extends StatefulWidget {
  const DynamicWidgetForm({super.key});

  @override
  State<DynamicWidgetForm> createState() => _DynamicWidgetFormState();
}

class _DynamicWidgetFormState extends State<DynamicWidgetForm> {
  final List<TextEditingController> _items = [];
  final List<TextEditingController> _quantity = [];
  final List<TextEditingController> _price = [];

  double textFieldBottomPadding = 15,
      textFieldRounded = 10,
      inputFieldPadding = 2;

  //form key
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _addField();
    });
  }

  _addField() {
    setState(() {
      _items.add(TextEditingController());
      _quantity.add(TextEditingController());
      _price.add(TextEditingController());
    });
  }

  _removeItem(i) {
    setState(() {
      _items.removeAt(i);
      _quantity.removeAt(i);
      _price.removeAt(i);
    });
  }

  // void _submit() {
  //   final isValid = _formKey.currentState!.validate();
  //   if (!isValid) {
  //     return;
  //   }
  //   _formKey.currentState!.save();

  //   FormData formData = FormData.fromMap({});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                    onTap: () {
                      _addField();
                    },
                    child: Icon(Icons.add_circle))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    for (int i = 0; i < _items.length; i++)
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                  onTap: () {
                                    _removeItem(i);
                                  },
                                  child: const Icon(Icons.remove_circle))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: EdgeInsets.all(inputFieldPadding),
                                  child: TextFormField(
                                    controller: _items[i],
                                    validator: (value) {
                                      if (value == "") {
                                        return "Please enter item name";
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                          textFieldRounded
                                        ),
                                      ),
                                      label: const Text("Title")
                                    ),
                                    
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.all(inputFieldPadding),
                                  child: TextFormField(
                                    controller: _quantity[i],
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == "" || value == "0") {
                                        return "Required";
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                          textFieldRounded
                                        ),
                                      ),
                                      label: const Text("Quantity")
                                    ),
                                    
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.all(inputFieldPadding),
                                  child: TextFormField(
                                    controller: _price[i],
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == "" || value == "0") {
                                        return "Required";
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                          textFieldRounded
                                        ),
                                      ),
                                      label: const Text("Price")
                                    ),
                                    
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            thickness: 1,
                          )
                        ],
                      )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
