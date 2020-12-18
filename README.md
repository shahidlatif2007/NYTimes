# NYTimes

This application shows most popular articles from NY times. User can filter by Day, Week and Month. The projct is build using Xcode  11.6. I have not used any external library while buiding this application. This application is built using **MVVM** Architecture. Please checkout **Main** branch to review the assignment.


# Application Structure

- Configurations
- Network
- Storyboads
- View Controllers
- Views
- Models
- Repository
- Extensions
- Helpers



* **Configurations**:

This contains configuration for different schemes. It has Development, Staging and productions. Each build has different app id, app name and application url. It has following schemes.

- NYTDemo-Development
- NYTDemo-Staging
- NYTDemo-Production

* **Storyboads**:

Storyboard which is being used in the code are placed here.

* **Network**:

This section covers handling of network requests.

* **Storyboads**:

This contains LaunchScreen.story and Main.storyboard.

* View Controllers:

There two view controllers. ArticlesViewController contains list of article coming from NYT api. User can click on filter button to filter by Day, Week and Month.

* **Views**: 

This section contain only 1 class which is ArticleTableViewCell. This class is used for table view in ArticlesViewController. Decodable is used for parsing JSON.

* **View Models**:

This section contains View models.

* **Response Models**:

This section contains Response models. 

* **Repository**:

This section is reponsible for sending requests by using network layer. 

* **Extensions**:

This secons contain extension for Dictionary, Label and Image View. Image View extension is used to download and show the image. Label extension is being used to show text and image.

* **Helpers**:

This section contains **Box.swift**. **Box.swift** is used to bind the reqeuired variable to UI. If there is any change the in the variable its listener is called. This is useful instead of callback I have used this class to notify when anything is changed in variable.

# Application Screenshots

* Splash Screen

![splash](https://user-images.githubusercontent.com/2598508/75237534-f26cf200-57d8-11ea-9d2e-1e12c0af6798.png)

* Home Screen

![Home](https://user-images.githubusercontent.com/2598508/102532892-17ab5380-40be-11eb-9b42-ee153ecfd493.png)

* Detail Screen

![Detail](https://user-images.githubusercontent.com/2598508/75229943-5b01a200-57cc-11ea-9dd7-3d67b757dd2e.png)
