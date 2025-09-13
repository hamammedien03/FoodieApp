import 'package:flutter/material.dart';
import 'package:foodie/Model/productMenu.dart';
import 'package:foodie/View/Screens/ProductDetailsScreen.dart';
import 'package:foodie/View/Widgets/FoodCard.dart';

class MainHomeContentScreen extends StatefulWidget {
  const MainHomeContentScreen({super.key});

  @override
  State<MainHomeContentScreen> createState() => _MainHomeContentScreenState();
}

class _MainHomeContentScreenState extends State<MainHomeContentScreen> {
  String searchText = '';
  bool showPopularMenuOnly = false;
  bool showDessertsOnly = false;
  bool showFilter = false;

  String? selectedFoodType;
  String? selectedLocation;
  String? selectedFood;

  List<String> foodTypes = ['Burger', 'Soup', 'Dessert'];
  List<String> locations = ['Cairo', 'Alex', 'Riyadh', 'Dubai'];
  List<String> foodList = ['Cake', 'Soup', 'Appetizer', 'Dessert', 'Burger'];

  var allFoods = productFood;
  List<Map<String, String>> get popularMenu =>
      allFoods.where((f) => f['type'] == 'Burger').toList();

  List<Map<String, String>> get desserts =>
      allFoods.where((f) => f['type'] == 'Dessert').toList();

  List<Map<String, String>> get soups =>
      allFoods.where((f) => f['type'] == 'Soup').toList();

  List<Map<String, String>> get searchResults => allFoods
      .where(
        (f) => f['title']!.toLowerCase().contains(searchText.toLowerCase()),
      )
      .toList();

  List<Map<String, String>> get filteredFoods {
    return allFoods.where((f) {
      final matchesType =
          selectedFoodType == null || f['type'] == selectedFoodType;
      final matchesLocation =
          selectedLocation == null || f['location'] == selectedLocation;
      final matchesFood = selectedFood == null || f['food'] == selectedFood;
      return matchesType && matchesLocation && matchesFood;
    }).toList();
  }

  void resetToMainScreen() {
    setState(() {
      showPopularMenuOnly = false;
      showDessertsOnly = false;
      showFilter = false;
      selectedFoodType = null;
      selectedLocation = null;
      selectedFood = null;
      searchText = '';
    });
  }

  void openProductDetails(Map<String, String> food) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => ProductDetailsScreen(food: food)));
  }

  @override
  Widget build(BuildContext context) {
    final bool isSearching = searchText.isNotEmpty;
    final bool isFiltering =
        !showFilter &&
        (selectedFoodType != null ||
            selectedLocation != null ||
            selectedFood != null);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Text(
                'Find Your\nFavourite Food',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 12),
                          Icon(Icons.search, color: Colors.grey),
                          SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search for Food',
                                border: InputBorder.none,
                              ),
                              onChanged: (val) {
                                setState(() {
                                  searchText = val;
                                  showPopularMenuOnly = false;
                                  showDessertsOnly = false;
                                  showFilter = false;
                                });
                              },
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.tune, color: Colors.grey),
                            onPressed: () {
                              setState(() {
                                showFilter = true;
                              });
                            },
                          ),
                          SizedBox(width: 8),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.all(8),
                    child: IconButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/notification'),
                      icon: Icon(Icons.notifications_none),
                      color: Color(0xFFF54748),
                    ),
                  ),
                ],
              ),
              if (showFilter) ...[
                const SizedBox(height: 32),
                DropdownButtonFormField<String>(
                  initialValue: selectedFoodType,
                  hint: Text('Type'),
                  items: foodTypes
                      .map(
                        (type) =>
                            DropdownMenuItem(value: type, child: Text(type)),
                      )
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      selectedFoodType = val;
                    });
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: InputBorder.none,
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: selectedLocation,
                  hint: Text('Location'),
                  items: locations
                      .map(
                        (loc) => DropdownMenuItem(value: loc, child: Text(loc)),
                      )
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      selectedLocation = val;
                    });
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: InputBorder.none,
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: selectedFood,
                  hint: Text('Food'),
                  items: foodList
                      .map(
                        (food) =>
                            DropdownMenuItem(value: food, child: Text(food)),
                      )
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      selectedFood = val;
                    });
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: InputBorder.none,
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFE91E63),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        showFilter = false;
                      });
                    },
                    child: Text('Search', style: TextStyle(fontSize: 18)),
                  ),
                ),
                const SizedBox(height: 24),
              ],
              if (!showFilter &&
                  !showPopularMenuOnly &&
                  !showDessertsOnly &&
                  !isSearching &&
                  !isFiltering) ...[
                //----------------------------------------------
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.centerLeft,
                  height: 150,
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xFFF54748),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Special Deal For December',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 12),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Color(0xFFF54748),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 8,
                                ),
                              ),
                              onPressed: () {},
                              child: Text('Buy Now'),
                            ),
                          ],
                        ),
                      ),
                      Image.asset(
                        'assets/images/Spetialdeal.png',
                        width: 90,
                        height: 90,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Popular Menu',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showPopularMenuOnly = true;
                          showDessertsOnly = false;
                          showFilter = false;
                          searchText = '';
                        });
                      },
                      child: Text(
                        'View More',
                        style: TextStyle(
                          color: Color(0xFFF54748),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  childAspectRatio: 1,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  children: popularMenu
                      .take(2)
                      .map(
                        (food) => GestureDetector(
                          onTap: () => openProductDetails(food),
                          child: FoodCard(
                            image: food['image']!,
                            title: food['title']!,
                            price: '${food['price']}\$',
                            heroTag: food['title']!,
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Deserts',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showDessertsOnly = true;
                          showPopularMenuOnly = false;
                          showFilter = false;
                          searchText = '';
                        });
                      },
                      child: Text(
                        'View More',
                        style: TextStyle(
                          color: Color(0xFFF54748),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  childAspectRatio: 1,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  children: desserts
                      .map(
                        (food) => GestureDetector(
                          onTap: () => openProductDetails(food),
                          child: FoodCard(
                            image: food['image']!,
                            title: food['title']!,
                            price: '${food['price']}\$',
                            heroTag: food['title']!,
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Soups',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  childAspectRatio: 1,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  children: soups
                      .map(
                        (food) => GestureDetector(
                          onTap: () => openProductDetails(food),
                          child: FoodCard(
                            image: food['image']!,
                            title: food['title']!,
                            price: '${food['price']}\$',
                            heroTag: food['title']!,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ] else if (showPopularMenuOnly) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Popular Menu',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: resetToMainScreen,
                      child: Text('Hide'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  childAspectRatio: 1,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  children: popularMenu
                      .map(
                        (food) => GestureDetector(
                          onTap: () => openProductDetails(food),
                          child: FoodCard(
                            image: food['image']!,
                            title: food['title']!,
                            price: '${food['price']}\$',
                            heroTag: food['title']!,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ] else if (showDessertsOnly) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Deserts',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: resetToMainScreen,
                      child: Text('Hide'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  childAspectRatio: 1,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  children: desserts
                      .map(
                        (food) => GestureDetector(
                          onTap: () => openProductDetails(food),
                          child: FoodCard(
                            image: food['image']!,
                            title: food['title']!,
                            price: '${food['price']}\$',
                            heroTag: food['title']!,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ] else if (isSearching) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Results',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: resetToMainScreen,
                      child: Text('Hide'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  childAspectRatio: 1,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  children: searchResults
                      .map(
                        (food) => GestureDetector(
                          onTap: () => openProductDetails(food),
                          child: FoodCard(
                            image: food['image']!,
                            title: food['title']!,
                            price: '${food['price']}\$',
                            heroTag: food['title']!,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ] else if (isFiltering) ...[
                Row(
                  children: [
                    if (selectedFoodType != null)
                      Container(
                        margin: EdgeInsets.only(right: 8),
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Text(selectedFoodType ?? ''),
                            SizedBox(width: 4),
                            GestureDetector(
                              onTap: resetToMainScreen,
                              child: Icon(Icons.close, size: 16),
                            ),
                          ],
                        ),
                      ),
                    if (selectedLocation != null)
                      Container(
                        margin: EdgeInsets.only(right: 8),
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Text(selectedLocation ?? ''),
                            SizedBox(width: 4),
                            GestureDetector(
                              onTap: resetToMainScreen,
                              child: Icon(Icons.close, size: 16),
                            ),
                          ],
                        ),
                      ),
                    if (selectedFood != null)
                      Container(
                        margin: EdgeInsets.only(right: 8),
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Text(selectedFood ?? ''),
                            SizedBox(width: 4),
                            GestureDetector(
                              onTap: resetToMainScreen,
                              child: Icon(Icons.close, size: 16),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Filtered Results',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  childAspectRatio: 1,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  children: filteredFoods
                      .map(
                        (food) => GestureDetector(
                          onTap: () => openProductDetails(food),
                          child: FoodCard(
                            image: food['image']!,
                            title: food['title']!,
                            price: '${food['price']}\$',
                            heroTag: food['title']!,
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 12),
                Center(
                  child: TextButton(
                    onPressed: resetToMainScreen,
                    child: Text('Hide Filter'),
                  ),
                ),
              ],
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
