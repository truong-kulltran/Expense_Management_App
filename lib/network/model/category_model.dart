import '../../utilities/utils.dart';

class CategoryModel {
  final int? id;
  final String? name;
  final int? parentId;
  final String? description;
  final int? logoImageID;
  final String? logoImageUrl;
  final List<CategoryModel>? childCategory;
  final String? categoryType;
  final String? createdAt;
  final int? createdBy;
  final bool pay;

  CategoryModel({
    this.id,
    this.name,
    this.parentId,
    this.description,
    this.logoImageID,
    this.logoImageUrl,
    this.childCategory,
    this.categoryType,
    this.createdAt,
    this.createdBy,
    this.pay = false,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      parentId: json['parentId'],
      description: json['description'],
      logoImageID: json['logoImageID'],
      logoImageUrl: json['logoImage'],
      childCategory: isNullOrEmpty(json['childCategory'])
          ? []
          : List<CategoryModel>.generate(
              json['childCategory'].length,
              (index) => CategoryModel.fromJson(json['childCategory'][index]),
            ),
      categoryType: json['categoryType'],
      createdAt: json['createdAt'],
      createdBy: json['createdBy'],
      pay: json['pay'],
    );
  }

  @override
  String toString() {
    return 'CategoryModel{id: $id, name: $name, parentId: $parentId, description: $description, logoImageID: $logoImageID, logoImageUrl: $logoImageUrl, childCategory: $childCategory, categoryType: $categoryType, createdAt: $createdAt, createdBy: $createdBy, pay: $pay}';
  }
}
