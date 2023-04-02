class Budget {
  num id;
  String foodTitle;
  String foodDescription;
  String image;
  num foodPrice;
  int quantity;

  Budget({
    required this.id,
    required this.foodTitle,
    required this.foodDescription,
    required this.foodPrice,
    required this.image,
    required this.quantity,
  });

  factory Budget.fromJson(Map<String, dynamic> parsedJson) {
    return Budget(
      id: parsedJson["id"],
      foodTitle: parsedJson["title"],
      foodDescription: parsedJson["description"],
      foodPrice: parsedJson["price"],
      image: parsedJson["image"],
      quantity: 0,
    );
  }

  static List budgetList(List budget) {
    List budgets = [];
    for (var i = 0; i < budget.length; i++) {
      budgets.add(Budget.fromJson(budget[i]));
    }
    return budgets;
  }
}
