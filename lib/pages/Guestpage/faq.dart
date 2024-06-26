import 'package:flutter/material.dart';

class FAQPage extends StatefulWidget {
  @override
  _FAQPageState createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  List<Item> _data = generateItems();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BHC FAQ'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Add your logic to download Buyers Application PDF
                      },
                      child: Text('Buyers Application'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Add your logic to download Lease Application PDF
                      },
                      child: Text('Lease Application'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildPanel(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: ListTile(
            title: Text(item.expandedValue),
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems() {
  return [
    Item(
      headerValue: 'Why do I need a conveyancer to transfer property?',
      expandedValue: 'Only a conveyancer can transfer property according to the laws of Botswana.',
    ),
    Item(
      headerValue: 'When I buy a BHC property; Do your lawyers process transfer and bonding of this property?',
      expandedValue: 'Yes, BHC lawyers handle the transfer and bonding process for properties bought from BHC.',
    ),
    Item(
      headerValue: 'I am not a citizen of Botswana, am I eligible to buy a BHC house?',
      expandedValue: 'Non-citizens are eligible to buy a BHC house subject to certain conditions and approval.',
    ),
    Item(
      headerValue: 'How many houses can my company be allowed to buy?',
      expandedValue: 'A company can buy multiple houses from BHC, subject to certain terms and conditions.',
    ),
    Item(
      headerValue: 'Can I sell the property I am renting from BHC?',
      expandedValue: 'No, you cannot sell a property you are renting from BHC until you have fully purchased it.',
    ),
    Item(
      headerValue: 'Since I am only allowed to buy one house from BHC, can my husband buy a house as well?',
      expandedValue: 'Yes, your husband can buy a house separately from BHC.',
    ),
    Item(
      headerValue: 'Can I buy more than one property from BHC?',
      expandedValue: 'Generally, you are allowed to buy one property, but additional purchases may be considered under specific conditions.',
    ),
    Item(
      headerValue: 'Does BHC maintain my house after I have purchased it?',
      expandedValue: 'No, maintenance after purchase is the responsibility of the homeowner.',
    ),
    Item(
      headerValue: 'Am I allowed to make alterations/fittings to the house I\'ve bought?',
      expandedValue: 'Yes, you are allowed to make alterations and fittings to your house after purchase, following BHC guidelines.',
    ),
    Item(
      headerValue: 'Can I lease out my BHC house while it\'s still on TPS/SOS?',
      expandedValue: 'No, you cannot lease out your house while it is still under TPS/SOS.',
    ),
    Item(
      headerValue: 'Where can I inquire about my TPS/SOS balance?',
      expandedValue: 'You can inquire about your TPS/SOS balance at the BHC office or through their customer service portal.',
    ),
    Item(
      headerValue: 'Does BHC have mortgage protection cover for the death of the TPS/SOS Purchasers?',
      expandedValue: 'Yes, BHC provides mortgage protection cover in case of the death of the TPS/SOS purchaser.',
    ),
    Item(
      headerValue: 'For those who purchased houses before the introduction of VAT, how does it affect them?',
      expandedValue: 'Houses purchased before the introduction of VAT are not subject to VAT on their purchase price.',
    ),
    Item(
      headerValue: 'Why do I have to pay penalties at Deeds Registry for my TPS/SOS property?',
      expandedValue: 'Penalties are charged for late registration or other violations of the deeds registry regulations.',
    ),
    Item(
      headerValue: 'Why do I have to pay rates when I\'m purchasing under TPS/SOS while BHC still holds the title?',
      expandedValue: 'Rates are a legal obligation for property usage, regardless of title holding under TPS/SOS.',
    ),
    Item(
      headerValue: 'I have been paying the required monthly instalments, but my balance does not decrease significantly, why?',
      expandedValue: 'The balance may not decrease significantly due to interest charges, fees, or other financial factors associated with the loan.',
    ),
  ];
}
