import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'qr_scanner_page.dart';
import 'add_assets_page.dart';

class CheckAssetsPage extends StatelessWidget {
  const CheckAssetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Check Assets"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search and Scan
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "SEARCH",
                      filled: true,
                      fillColor: Colors.grey.shade300,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () {},
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QRScannerPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade900,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("SCAN"),
                ),
              ],
            ),
            const SizedBox(height: 10),
            
            // Table Header
            Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.blueGrey.shade900,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("SERIAL NO", style: TextStyle(color: Colors.white)),
                  Text("DESCRIPTION", style: TextStyle(color: Colors.white)),
                  Text("LOCATION", style: TextStyle(color: Colors.white)),
                  Text("SITE", style: TextStyle(color: Colors.white)),
                  Text("OTHER", style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            
            // Fetch and Display Assets
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('assets').snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text("No data available", style: TextStyle(color: Colors.black54)));
                  }

                  return ListView(
                    children: snapshot.data!.docs.map((doc) {
                      var data = doc.data() as Map<String, dynamic>?;
                      if (data == null) return const SizedBox();
                      return ListTile(
                        title: Text(data['serialNumber'] ?? "Unknown"),
                        subtitle: Text(data['description'] ?? "No Description"),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            FirebaseFirestore.instance.collection('assets').doc(doc.id).delete();
                          },
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
            
            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AddAssetsPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey.shade900),
                  child: const Text("ADD NEW", style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey.shade900),
                  child: const Text("EDIT", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            
            // Delete All Button
            ElevatedButton(
              onPressed: () async {
                var assets = await FirebaseFirestore.instance.collection('assets').get();
                for (var doc in assets.docs) {
                  await doc.reference.delete();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey.shade900,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("DELETE ALL", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
