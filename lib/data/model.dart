class Budget {
  String foodTitle;
  String foodDescription;
  String image;
  num foodPrice;
  int quantity;
  bool itemAdded;

  Budget(
      {required this.foodTitle,
      required this.foodDescription,
      required this.foodPrice,
      required this.image,
      required this.quantity,
      required this.itemAdded});

  factory Budget.fromJson(Map<String, dynamic> parsedJson) {
    return Budget(
        foodTitle: parsedJson["title"],
        foodDescription: parsedJson["description"],
        foodPrice: parsedJson["price"],
        image: parsedJson["image"],
        quantity: 1,
        itemAdded: false);
  }

  static List budgetList(List budget) {
    List budgets = [];
    for (var i = 0; i < budget.length; i++) {
      budgets.add(Budget.fromJson(budget[i]));
    }
    return budgets;
  }
}
