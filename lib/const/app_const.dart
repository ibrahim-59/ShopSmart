import 'package:e_commerce/models/category_model.dart';
import 'package:e_commerce/services/assets_manager.dart';

class AppConstants {
  // ignore: non_constant_identifier_names
  static String ProductImage =
      'https://i.ibb.co/8r1Ny2n/20-Nike-Air-Force-1-07.png';

  // ignore: non_constant_identifier_names
  static List<String> BannersImages = [
    AssetsManager.banner1,
    AssetsManager.banner2,
  ];

  // ignore: non_constant_identifier_names
  static List<CategoryModel> CategoriesList = [
    CategoryModel(
      id: AssetsManager.mobiles,
      name: 'Phones',
      image: AssetsManager.mobiles,
    ),
    CategoryModel(
      id: AssetsManager.electronics,
      name: 'electronics',
      image: AssetsManager.electronics,
    ),
    CategoryModel(
        id: AssetsManager.cosmetics,
        name: 'cosmetics',
        image: AssetsManager.cosmetics),
    CategoryModel(
      id: AssetsManager.shoes,
      name: 'shoes',
      image: AssetsManager.shoes,
    ),
    CategoryModel(
      id: AssetsManager.fashion,
      name: 'fashion',
      image: AssetsManager.fashion,
    ),
    CategoryModel(
      id: AssetsManager.watch,
      name: 'watch',
      image: AssetsManager.watch,
    ),
    CategoryModel(
      id: AssetsManager.book,
      name: 'book',
      image: AssetsManager.book,
    ),
    CategoryModel(
      id: AssetsManager.pc,
      name: 'Laptops',
      image: AssetsManager.pc,
    ),
  ];
}
