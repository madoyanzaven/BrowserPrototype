# BrowserPrototype
This is a simple web browser app built with Swift that allows users to open and browse websites using a WebView component. 
The app also keeps a history of visited URLs using SQLite.

### Installation
* Clone the repository: git clone https://github.com/madoyanzaven/BrowserPrototype.git
* Open the project in Xcode.
* Build and run the app on a simulator or device.

### Usage
* On the first screen, enter a valid URL in the text field.
* Tap the "Go" button.
* The app will display the website in a WebView.
* To view the browsing history, tap the history button on the first screen.
* The history screen will show a list of visited URLs.
* To clear the browsing history, tap the delete button on the history screen.

### Features
* User can enter a URL in the text field on the first screen.
* The entered URL is opened in a WebView on the first screen.
* Visited URLs are saved in a history list.
* The history list is stored in a SQLite database for persistence.

### Architecture
* MVVM (Model-View-ViewModel) + Coordinator

### Built With
* Swift, Combine, UIKit + UI as xib and code
* Database - SQLite
* Tests - XCTestCase
* Frameworks - SnapKit, SQLite

### Good practices followed
* Single responsibility of solid principle
* Dependency inversion principle
* DRY principles
* Clean architecture

##### Commit strategy
* Commit for each unit code
* Single-Purpose Commits

### If future-proof
In the project all layers are abstract, which allows to organize dependency flow, it is also easier for testing and preferable for scalable applications.

### Time it took
It took six hours, development process was without strasess.

