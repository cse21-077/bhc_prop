class Property {
  final String imageUrl;
  final String name;
  final String category;
  final int price;
  final String size;
  final String description;

  Property({
    required this.imageUrl,
    required this.name,
    required this.category,
    required this.price,
    required this.size,
    required this.description,
  });
}

final List<Property> property = [
  Property(
    imageUrl: 'assets/images/1.png',
    name: 'Residental House',
    category: 'Rental',
    price: 2500,
    size: '3 Bedroom',
    description:
        'A Threebedroom house for your family, with an open kitchen plan area.',
  ),
  
  Property(
    imageUrl: 'assets/images/2.png',
    name: 'Residental House',
    category: 'Rental',
    price: 2500,
    size: '3 Bedroom',
    description:
        'A Threebedroom house for your family, with an open kitchen plan area.',
  ),
  Property(
    imageUrl: 'assets/images/3.png',
    name: 'Residental House',
    category: 'Rental',
    price: 1500,
    size: '1 Bedroom',
    description:
        'A 1 house for your family, with an open kitchen plan area.',
  ),
  Property(
    imageUrl: 'assets/images/5.png',
    name: 'Residental House',
    category: 'Sale',
    price: 500000,
    size: '3 Bedroom',
    description:
        'A Threebedroom house for your family, with an open kitchen plan area.',
  ),
];
// 