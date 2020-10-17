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
