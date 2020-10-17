# The Cat App

### Introduction
This application is my submission to Udacity's iOS Developer
nanodegree program.

### Overview
The basic idea of this application is that upon opening the app, a list
of cat breeds is downloaded from an API [The Cat API](https://thecatapi.com/) and shown in a table view as a list.

You can scroll through the list view and pick any breed of cat you'd like
to learn more about. Clicking on the table cell for that breed will open up the breed detail view for that particular breed.

A photo of that breed of cat will load with the ability to both get a new
random image of this breed and to save any picture that you would like
to save. This view also lists some characteristics about that breed of cat
which are also sourced from [The Cat API](https://thecatapi.com/).

These attributes are rather self explanatory and the are either described with a string or with a number from 0-5 where 0 is equivalent to "not at all" and 5 being "absolutely". If no value exists from the API for any particular attribute it will be marked as "Unknown". There is also an "Info" bar item in the navigation panel that will open a new view that will give a description and a temperament for the breed of cat.

### Externally Sourced Data
As stated above, all of the data for this application is sourced from [https://thecatapi.com/](https://thecatapi.com/).

### Breed List View
Scroll through the table and select the breed of cat you are interested in learning more about. If you want to see photos that you have previously saved to your device, click the "Photos" bar button in the navigation panel.

### Breed Detail View
This view shows more detail about the breed as discussed in the overview section. The photo(s) from this view may be persisted if you so choose with a long touch gesture on the image. If the image was saved successfully, an alert will inform you that it was saved successfully. If there was an error, an alert will also warn you of that.

Pressing the "Info" bar button item in the navigation panel will open a new view that contains a description of the breed and its temperament. Back on the breed detail view you will notice a refresh button, pressing this will load a new random photo of this particular breed of cat.

### Breed Description and Temperament View
This was discussed above.

### Saved Photos View
This view is a collection view that shows all of the users saved photos. Note that you can delete any particular photo with a tap gesture on the photo that you would like to delete.

### Running the app
There are no external dependencies, just open it in Xcode (note that I built this in Xcode 12 for iOS 14), pick an appropriate simulator (I used an iPhone 11 simulator), and press run.

