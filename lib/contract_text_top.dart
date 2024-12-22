import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContractDetailsText extends StatefulWidget {
  final dynamic contractData; // Contract data fetched from the API
  const ContractDetailsText({super.key, required this.contractData});

  @override
  State<ContractDetailsText> createState() => _ContractDetailsTextState();
}

class _ContractDetailsTextState extends State<ContractDetailsText> {

  @override
  Widget build(BuildContext context) {
    final contract = widget.contractData;

    return Padding(
      padding: const EdgeInsets.only(right: 30.0,top: 30.0,bottom: 30.0,left: 10), // Padding from all sides
      child: Row(
        children: [
          Text(
            "All Contract / ",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
          Text(
            contract['project_name'],
            style: GoogleFonts.poppins(
              fontSize: 18, // Increased font size
              fontWeight: FontWeight.bold, // Bold part
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
