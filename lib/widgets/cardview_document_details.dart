import 'package:flutter/material.dart';

class CardviewDocumentDetails extends StatelessWidget {
  const CardviewDocumentDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      elevation: 4.0,
      surfaceTintColor:  Color.fromRGBO(220, 222, 224, 0.8),
      margin:  EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Upload Documents',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
                'Untuk mobil baru produksi 2022 yang belum memiliki STNK, silakan untuk mengunggah dokumen berupa (KTP dan BASTK).'),
            SizedBox(height: 16.0),
            Text(
                'Untuk mobil dengan polis lama yang masih berlaku, silakan untuk mengunggah dokumen berupa (KTP, STNK dan Existing Policy).'),
            SizedBox(height: 16.0),
            Text(
                'Untuk mobil tanpa polis, silakan untuk mengunggah dokumen berupa (KTP, STNK, Survey, ODO).'),
          ],
        ),
      ),
    );
  }
}
