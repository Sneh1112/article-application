# article_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.


##Flutter Article Application


This Flutter Application fetches and displays a list of articles from a public API and displays them in a searchable list, and allows users to mark favorites using Riverpod for state management. 

The application has two main screens: "All Articles" and "Favorites", accessible via a bottom navigation bar. Favorites are saved with SharedPreferences to persist across app restarts. 


##Features

API integration


Search functionality


Favorites management with local storage


Navigation between screens


Clean and reusable code using Riverpod State Management.

## Setup Instructions
1. Clone the repo:
    git clone <https://github.com/Sneh1112/article-application.git>
      cd article_app
      
2. Install dependencies:

    flutter pub add http
    flutter pub add flutter_provider
    flutter pub add flutter_riverpod
    flutter pub add shared_preferences
    
    After adding dependencies run below command
    
    flutter pub get



3. Run the app:
    flutter run



##Install Dependencies

http, flutter_provider, flutter_riverpod, shared_preferences


##Tech Stack

Flutter SDK:  Flutter 3.29.0 
State Management: Riverpod
HTTP Client: http
Persistence: shared_preferences


##State Management Explanation 

articlesProvider is a type of FutureProvider<List<Article>> which fetches articles from an API.

searchQueryProvider is a type of StateProvider<String> which holds the current search query and is used for filtering the list of articles.

avoritesProvider is a StateNotifierProvider used to manage a list of favorites article IDs with persistent storage.


##Known Issues / Limitations [List anything incomplete or improvable] 

We can add categories and filter articles by catogory.

AddTheme mode feature which allows toggling between light/dark mode.

We can also add a share option which helps us to share articles via Gmail, WhatsApp, ect.







