import 'package:bhc_prop/forms/companyrental.dart';
import 'package:bhc_prop/forms/individualrental.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bhc_prop/core/colors.dart';
import 'package:bhc_prop/pages/Guestpage/houseview/housemodel.dart';

class HouseScreen extends StatefulWidget {
  @override
  _HouseScreenState createState() => _HouseScreenState();
}

class _HouseScreenState extends State<HouseScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;
  int _selectedPage = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  Widget _houseSelector(int index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget? child) {
        double value = 1;
        if (_pageController.position.hasContentDimensions) {
          value = (_pageController.page! - index).abs();
          value = (1 - (value * 0.3)).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 500.0,
            width: Curves.easeInOut.transform(value) * 400.0,
            child: child,
          ),
        );
      },
      child: GestureDetector(
        onTap: () {
           _showActionModal(context, property[index].category);
        },
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: bhcred,
                borderRadius: BorderRadius.circular(20.0),
              ),
              margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 30.0),
              child: Stack(
                children: <Widget>[
                  Center(
                    child: Hero(
                      tag: property[index].imageUrl,
                      child: Image.asset(
                        property[index].imageUrl,
                        height: 280.0,
                        width: 280.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 30.0,
                    right: 30.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'FROM',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                          ),
                        ),
                        Text(
                          '\P${property[index].price}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 30.0,
                    bottom: 40.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          property[index].category.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          property[index].name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 4.0,
              child: RawMaterialButton(
              padding: const EdgeInsets.all(15.0),
              shape: const CircleBorder(),
              elevation: 2.0,
              fillColor: bhcyelow,
              child: const Icon(
                Icons.home_rounded,
                color: Colors.white,
                size: 30.0,
              ),
              onPressed: () {
                _showActionModal(context, property[index].category);
              },
            ),

            ),
          ],
        ),
      ),
    );
  }

void _showActionModal(BuildContext context, String category) {
  List<Map<String, dynamic>> buttons = [];
  String modalTitle = "Apply"; // Default title

  if (category == 'Sale') {
    buttons = [
      {'label': 'Sale Application 1', 'action': () {/* Action for Sale Application 1 */}},
      {'label': 'Sale Application 2', 'action': () {/* Action for Sale Application 2 */}},
      {'label': 'Sale Application 3', 'action': () {/* Action for Sale Application 3 */}},
      {'label': 'Sale Application 4', 'action': () {/* Action for Sale Application 4 */}},
    ];
  } else if (category == 'Rental') {
    buttons = [
      {'label': 'Company Application', 'action': () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CompanyApplicationForm()),
        );
      }},
      {'label': 'Individual Application', 'action': () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => IndividualApplicationForm()),
        );
      }},
    ];
  }

  showModalBottomSheet(
    context: context,
    builder: (BuildContext bc) {
      return Container(
        padding: EdgeInsets.all(16.0),
        child: Wrap(
          children: <Widget>[
            Text(
              modalTitle,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Column(
              children: buttons.map((button) {
                return ListTile(
                  title: Text(button['label']),
                  onTap: button['action'],
                );
              }).toList(),
            ),
          ],
        ),
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 60.0),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.arrow_back, size: 30.0, color: Colors.grey),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            const Padding(
              padding: EdgeInsets.only(left: 30.0),
              child: Text(
                'House',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            TabBar(
              controller: _tabController,
              indicatorColor: Colors.transparent,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey.withOpacity(0.6),
              labelPadding: const EdgeInsets.symmetric(horizontal: 35.0),
              isScrollable: true,
              tabs: const <Widget>[
                Tab(
                  child: Text(
                    'All',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Rental',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Sale',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
              onTap: (index) {
                _pageController.animateToPage(index,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut);
              },
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              height: 500.0,
              width: double.infinity,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (int index) {
                  setState(() {
                    _selectedPage = index;
                  });
                },
                itemCount: property.length,
                itemBuilder: (BuildContext context, int index) {
                  if (_tabController.index == 0 ||
                      (_tabController.index == 1 &&
                          property[index].category == 'Rental') ||
                      (_tabController.index == 2 &&
                          property[index].category == 'Sale')) {
                    return _houseSelector(index);
                  } else {
                    return SizedBox(height: 20.0); // Replace with appropriate widget or null if needed
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    property[_selectedPage].category == 'Rental' && _tabController.index == 1
                        ? property[_selectedPage].description
                        : property[_selectedPage].category == 'Sale' && _tabController.index == 2
                            ? property[_selectedPage].description
                            : '',
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
