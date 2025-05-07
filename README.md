# exercise1

THE FRUIT SHOP - Flutter App

A simple, responsive, and beautiful Flutter application for shopping fruits. Users can view fruit items, add them to a cart with quantities, view a summary page, and clear the cart. The app supports both light and dark modes.

---

1. Requirements

Before running the project, ensure the following are installed:

System Requirements
- Flutter SDK (3.x or higher recommended)
- Dart SDK
- Android Studio / VS Code
- Android/iOS Emulator or real device

Dependencies

In your pubspec.yaml:

dependencies:
  flutter:
    sdk: flutter
  fluttertoast: ^8.2.2

Assets

Make sure the following image assets are included under the assets/ folder and declared in pubspec.yaml:

assets/
  - apples.png
  - bananas.png
  - oranges.png
  - pineapples.png

Declare them like this:

flutter:
  assets:
    - assets/apples.png
    - assets/bananas.png
    - assets/oranges.png
    - assets/pineapples.png

---

2. App Structure & Design Reasoning

Folder Structure

lib/
  └── main.dart         # All logic and UI code in one file (for this exercise)
assets/
  └── *.png             # Fruit images

Code Design

- ShopItem model: Represents each fruit with name, price, and image path.
- cart as Map: Allows storing quantity (Map<ShopItem, int>) for efficient updates.
- Responsive GridView: Uses MediaQuery to show 2 or 4 columns based on screen width.
- Navigation: Uses Navigator.push() to move between product detail and summary pages.
- Theme Support: Light/Dark mode is enabled based on system preferences.
- Toast Notifications: fluttertoast provides visual feedback when items are added or cleared.

---

3. Additional Components

- Dark Mode Support: Auto-adapts using ThemeMode.system.
- Shopping Cart Icon in AppBar: Navigates to summary page.
- Item Detail Page: Shows an enlarged image, name, price, and an "Add to Cart" button.
- Toast Confirmation: Confirms adding or clearing cart using fluttertoast.
- Clear Cart Button: Lets the user reset the cart from the main screen.
- Responsive Design: Grid adapts between small and large screens (e.g., phones vs tablets).
- Summary Page: Lists all items in the cart with quantities and subtotal.

---

4. Code Overview (main.dart)

Main Widgets

- MyApp: Root of the app. Sets the theme and starts with ShopPage.
- ShopPage: Main shopping screen with a grid of fruit items and a cart summary bar.
- DetailPage: Shows a large view of the selected fruit and allows adding to cart.
- SummaryPage: Displays a list of selected items and total cost.

Core Logic

- Adding to Cart:
  cart.update(item, (value) => value + 1, ifAbsent: () => 1);

- Calculating Total:
  double totalPrice = cart.entries.fold(
      0.0, (sum, entry) => sum + entry.key.price * entry.value);

- Clear Cart:
  cart.clear();

- Responsive Layout:
  final crossAxisCount = screenWidth < 600 ? 2 : 4;

- Navigation:
  Navigator.push(context, MaterialPageRoute(...));

- Toast Message:
  Fluttertoast.showToast(msg: "Item added to cart");

---

Screenshots
(Insert emulator screenshots here showing the main screen, detail page, and summary page)

---
