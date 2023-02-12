class HairCut {
  final String hairAsset;
  final String price;
  final String description;

  HairCut({
    required this.hairAsset,
    required this.price,
    required this.description,
  });
}

List<HairCut> hairCuts = [
  HairCut(
    hairAsset: 'assets/hair_cut/1.png',
    price: 'Rp. 100.000',
    description: 'Hair Cut 1',
  ),
  HairCut(
    hairAsset: 'assets/hair_cut/2.png',
    price: 'Rp. 200.000',
    description: 'Hair Cut 2',
  ),
  HairCut(
    hairAsset: 'assets/hair_cut/3.png',
    price: 'Rp. 300.000',
    description: 'Hair Cut 3',
  ),
];
