import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CollectAssetsPage extends StatefulWidget {
  const CollectAssetsPage({super.key});

  @override
  _CollectAssetsPageState createState() => _CollectAssetsPageState();
}

class _CollectAssetsPageState extends State<CollectAssetsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController serialNumberController = TextEditingController();
  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController otherInfoController = TextEditingController();

  List<TextEditingController> siteControllers = [TextEditingController()];
  List<TextEditingController> locationControllers = [TextEditingController()];
  List<TextEditingController> departmentControllers = [TextEditingController()];
  List<TextEditingController> categoryControllers = [TextEditingController()];
  List<TextEditingController> modelBrandControllers = [TextEditingController()];

  void addField(List<TextEditingController> controllers) {
    setState(() {
      controllers.add(TextEditingController());
    });
  }

  void removeField(List<TextEditingController> controllers, int index) {
    if (controllers.length > 1) {
      setState(() {
        controllers[index].dispose();
        controllers.removeAt(index);
      });
    }
  }

  void clearAllFields() {
    serialNumberController.clear();
    itemNameController.clear();
    descriptionController.clear();
    otherInfoController.clear();
    setState(() {
      siteControllers = [TextEditingController()];
      locationControllers = [TextEditingController()];
      departmentControllers = [TextEditingController()];
      categoryControllers = [TextEditingController()];
      modelBrandControllers = [TextEditingController()];
    });
  }

  Future<void> scanBarcode() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Scan Barcode"),
        content: SizedBox(
          height: 300,
          width: 300,
          child: MobileScanner(
            onDetect: (barcodeCapture) {
              final String? barcode = barcodeCapture.barcodes.first.rawValue;
              if (barcode != null) {
                serialNumberController.text = barcode;
                Navigator.pop(context);
              }
            },
          ),
        ),
      ),
    );
  }

  Future<void> saveAsset() async {
    if (serialNumberController.text.isEmpty || itemNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Serial number and item name are required!")),
      );
      return;
    }

    await _firestore.collection('assets').add({
      'serialNumber': serialNumberController.text,
      'itemName': itemNameController.text,
      'description': descriptionController.text,
      'otherInfo': otherInfoController.text,
      'sites': siteControllers.map((c) => c.text).toList(),
      'locations': locationControllers.map((c) => c.text).toList(),
      'departments': departmentControllers.map((c) => c.text).toList(),
      'categories': categoryControllers.map((c) => c.text).toList(),
      'modelBrands': modelBrandControllers.map((c) => c.text).toList(),
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Asset saved successfully!")),
    );
    clearAllFields();
  }

  Widget buildDynamicField(List<TextEditingController> controllers) {
    return Column(
      children: List.generate(controllers.length, (index) {
        return Row(
          children: [
            Expanded(
              child: TextField(
                controller: controllers[index],
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade300, // Fixed here
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add_circle, color: Colors.blue),
              onPressed: () => addField(controllers),
            ),
            IconButton(
              icon: const Icon(Icons.remove_circle, color: Colors.red),
              onPressed: () => removeField(controllers, index),
            ),
          ],
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Collect Assets"),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("SERIAL NUMBER:"),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: serialNumberController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade300, // Fixed here
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: scanBarcode,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[900]),
                  child: const Text("SCAN"),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text("ITEM NAME:"),
            TextField(controller: itemNameController, decoration: InputDecoration(filled: true, fillColor: Colors.grey.shade300, border: const OutlineInputBorder())),
            const SizedBox(height: 10),
            const Text("DESCRIPTION:"),
            TextField(controller: descriptionController, maxLines: 2, decoration: InputDecoration(filled: true, fillColor: Colors.grey.shade300, border: const OutlineInputBorder())),
            const SizedBox(height: 10),
            const Text("OTHER INFO:"),
            TextField(controller: otherInfoController, decoration: InputDecoration(filled: true, fillColor: Colors.grey.shade300, border: const OutlineInputBorder())),
            const SizedBox(height: 10),
            const Text("SITE:"), buildDynamicField(siteControllers),
            const Text("LOCATION:"), buildDynamicField(locationControllers),
            const Text("DEPARTMENT:"), buildDynamicField(departmentControllers),
            const Text("CATEGORY:"), buildDynamicField(categoryControllers),
            const Text("MODEL/BRAND:"), buildDynamicField(modelBrandControllers),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: saveAsset, style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[900]), child: const Text("SAVE")),
                ElevatedButton(onPressed: clearAllFields, style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[900]), child: const Text("CLEAR ALL")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
