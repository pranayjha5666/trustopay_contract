import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // For date formatting

class MilestonesPage extends StatefulWidget {
  final dynamic contractData; // Contract data fetched from the API

  const MilestonesPage({Key? key, required this.contractData}) : super(key: key);

  @override
  _MilestonesPageState createState() => _MilestonesPageState();
}

class _MilestonesPageState extends State<MilestonesPage> {
  bool showContractSide = true; // Toggle between Contract and Milestones
  late Map<String, bool> milestoneStatus;
  int index=1;// Track milestone completion

  @override
  void initState() {
    super.initState();
    // Initialize milestone completion statuses
    milestoneStatus = {
      for (var milestone in widget.contractData['milestones'])
        milestone['title']: widget.contractData['project_milestone_timeline'][milestone['title']] ?? true
    };
  }

  String formatDate(String dateString) {
    // Parse the timestamp and format it as "day month year"
    final DateTime date = DateTime.parse(dateString);
    return DateFormat("dd MMMM yyyy").format(date);
  }

  @override
  Widget build(BuildContext context) {
    final contract = widget.contractData;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            boxShadow: const [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 4,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 15),
            child: Column(
              children: [
                // Header with toggle buttons
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showContractSide = true;
                        });
                      },
                      child: Text(
                        "Contract Details",
                        style: GoogleFonts.roboto(
                          fontSize: 15,
                          fontWeight: showContractSide ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                    const Text(
                      " | ",
                      style: TextStyle(fontSize: 15),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showContractSide = false;
                        });
                      },
                      child: Text(
                        "Milestones",
                        style: GoogleFonts.roboto(
                          fontSize: 15,
                          fontWeight: showContractSide ? FontWeight.normal : FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Toggle between Contract Side and Milestones
                Expanded(
                  child: showContractSide ? _contractSide(contract) : _milestoneWidget(contract),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Contract Details Widget
  Widget _contractSide(dynamic contract) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "Contract ID: ${contract['contract_unique_id']}",
              style: GoogleFonts.robotoCondensed(fontSize: 16),
            ),
          ),
          const SizedBox(height: 10),
          detailBlock("Buyer / Seller", "${contract['buyer']} / ${contract['seller']}"),
          detailBlock("Project name", contract['project_name']),
          Text(
            "Project description",
            style: GoogleFonts.roboto(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 4),
          Text(
            contract['project_description'],
            style: GoogleFonts.roboto(fontSize: 13, height: 1.5),
          ),
          const SizedBox(height: 10),
          detailBlock("Project category", contract['services']),
          detailBlock("Project deadline", formatDate(contract['project_deadline'])),
          detailBlock("Ownership rights", "Buyer"),
          detailBlock("Number of revisions", "${contract['map_data'][1]["How many pages?"]}"),
        ],
      ),
    );
  }

  // Helper for Detail Blocks (Vertical Layout)
  Widget detailBlock(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.roboto(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.roboto(fontSize: 13),
          ),
        ],
      ),
    );
  }

  // Milestones Widget
  Widget _milestoneWidget(dynamic contract) {
    final milestones = contract['milestones'];
    return ListView.builder(
      itemCount: milestones.length,
      itemBuilder: (context, index) {
        final milestone = milestones[index];
        return milestoneItem(
          index: index + 1, // Add 1 to the index to start numbering from 1
          title: milestone['title'],
          amount: "₹${milestone['amount']}",
          description: [milestone['description']],
          isCompleted: milestoneStatus[milestone['title']] ?? false,
        );
      },
    );
  }

  // Milestone Item
  // Milestone Item
  Widget milestoneItem({
    required int index, // Added index parameter
    required String title,
    required String amount,
    required List<String> description,
    required bool isCompleted,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Display the index as a number
          Container(
            margin: const EdgeInsets.only(right: 8.0),
            width: 25,
            height: 35,
            child: Center(
              child: Text(
                index.toString(),
                style: GoogleFonts.roboto(fontSize: 15),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.only(top: 5, left: 8),
                        height: 35,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          title,
                          style: GoogleFonts.roboto(fontSize: 15),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.only(top: 5, left: 10),
                        height: 35,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          amount,
                          style: GoogleFonts.roboto(fontSize: 15),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          // Update milestone status in the parent state
                          milestoneStatus[title] = !isCompleted;
                        });
                      },
                      child: Icon(
                        isCompleted ? Icons.check_circle : Icons.circle_outlined,
                        color: isCompleted ? Colors.green : Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  margin: const EdgeInsets.only(right: 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: description
                        .map(
                          (desc) => Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("• ", style: TextStyle(fontSize: 12)),
                          Expanded(
                            child: Text(
                              desc,
                              style: GoogleFonts.roboto(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


}
