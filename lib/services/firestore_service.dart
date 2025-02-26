import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Add a new asset
  Future<void> addAsset(String serialNumber, String description, String location, String site, String otherInfo) async {
    await _db.collection("assets").doc(serialNumber).set({
      "serialNumber": serialNumber,
      "description": description,
      "location": location,
      "site": site,
      "otherInfo": otherInfo,
      "timestamp": FieldValue.serverTimestamp(),
    });
  }

  // Fetch all assets
  Stream<QuerySnapshot> getAssets() {
    return _db.collection("assets").orderBy("timestamp", descending: true).snapshots();
  }

  // Update an asset
  Future<void> updateAsset(String serialNumber, String description, String location, String site, String otherInfo) async {
    await _db.collection("assets").doc(serialNumber).update({
      "description": description,
      "location": location,
      "site": site,
      "otherInfo": otherInfo,
    });
  }

  // Delete an asset
  Future<void> deleteAsset(String serialNumber) async {
    await _db.collection("assets").doc(serialNumber).delete();
  }

  // Delete all assets
  Future<void> deleteAllAssets() async {
    final batch = _db.batch();
    final snapshot = await _db.collection("assets").get();
    for (var doc in snapshot.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }
}
