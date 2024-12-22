import 'package:flutter/material.dart';
import 'package:trustopay_contract/contract_text_top.dart';
import 'package:trustopay_contract/sideshow_screen.dart';
import 'package:trustopay_contract/top_area.dart';

import 'Services/fetchdata.dart';
import 'buyer_seller_area.dart';
import 'contract_details.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {

  bool isLoading = false;
  bool isError = false;
  dynamic contractData;


  @override
  void initState() {
    super.initState();
    fetchContractData();
  }


  Future<void> fetchContractData() async {
    setState(() {
      isLoading = true;
      isError = false;
    });

    var fetch = Fetch();
    var data = await fetch.fetchContractData();

    setState(() {
      isLoading = false;
      if (data != null) {
        contractData = data;
        print(contractData);
      } else {
        isError = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    if (isError) {
      return Center(child: Text('Error loading contract data.'));
    }


    return Scaffold(
      backgroundColor: Colors.white54,
      body: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.20, // 20% of the screen width
            color: Colors.white, // Optional background color for differentiation
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: SideShowScreen(),
            ),
          ),
          // Right column for main content
          Expanded(
            child: Column(
              children: [
                Container(
                  height: 100, // Adjust the height as needed
                  color: Colors.white, // Optional background color
                  child: CustomAppBar(contractData: contractData),
                ),
                // Divider between the top and bottom areas
                const Divider(height: 1),
                // Bottom area
                Expanded(
                  child: Column(
                    children: [
                      // First row for ContractDetailsText
                       ContractDetailsText(contractData: contractData,),
                      // Second row for MilestonesPage and UserInfoPage
                      Expanded(
                        child: Row(
                          children: [
                            // MilestonesPage (slightly larger space)
                            Expanded(
                              flex: 7, // Adjust the flex ratio to allocate more space
                              child: Container(
                                color: Colors.grey[200], // Optional background color
                                child: MilestonesPage(contractData: contractData,),
                              ),
                            ),
                            // User Info Page (slightly smaller space)
                            Expanded(
                              flex: 3, // Adjust the flex ratio to allocate less space
                              child: Container(
                                color: Colors.grey[50], // Optional background color
                                child: Person(contractData: contractData,),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
