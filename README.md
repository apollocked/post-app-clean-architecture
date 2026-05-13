# Posts App Clean Architecture 📱

A high-performance Flutter application that demonstrates clean architecture using **Cubit** for state management. The app features efficient pagination (infinite scrolling), a local search by ID system, and a custom-styled UI with error handling.

## ✨ Features

- **Infinite Scrolling:** Automatically fetches posts in batches of 10, up to 100 posts.
- **ID Search:** Search through already loaded posts by their unique ID.
- **Search Protection:** Logic prevents pagination from overwriting active search results.
- **Graceful Error Handling:** Includes a local cache fallback message and connection-loss handling.
- **Custom UI:** Modern design featuring:
- Teal & Gold color palette.
- Clean Card-based layout with elevation.
- Static Footer for data source attribution.

## 🛠 Tech Stack

- **Framework:** [Flutter](https://flutter.dev)
- **State Management:** [Flutter Bloc (Cubit)](https://pub.dev/packages/flutter_bloc)
- **HTTP Client:** [Dio](https://pub.dev/packages/dio) (or preferred API repository)
- **Icons:** Material Symbols

## 📂 Project Structure

```text
lib/
├── core/
│   └── utils/          # Global colors and constants
├── features/
│   └── posts/
│       ├── data/       # Models and Repositories
│       ├── logic/      # PostCubit and PostState
│       └── ui/         # Screens and Widgets
└── main.dart           # App entry point

```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK installed.
- An IDE (VS Code, Android Studio, etc.).

## ⚙️ Logic Breakdown

### Pagination & Search Conflict Resolution

To prevent the "infinite loading" bug when searching:

1.  **`isSearching` flag:** When a user searches, the Cubit locks the pagination.
2.  **Scroll Listener:** The scroll listener in `MainScreen` checks the `isSearching` flag. If true, it refuses to trigger new API calls, preserving the user's search view.
3.  **Conditional Rendering:** The `BlocBuilder` only shows a full-screen loading spinner during the initial empty-state fetch, ensuring the UI doesn't "flicker" when loading more data.
