## Design Strategy

### Planning
- Used a spreadsheet to calculate all the expected results for our tests
- Used the steps taken in the spreadsheet as pseudocode for both methods and helper methods

### Red, Green, Refactor
- Refactored along the way by having all members review and approve each PR and submit ideas for improvement

### Performance
- Created objects on the fly by reading our data line by line as opposed to reading the entire csv files into memory
- Kept our objects as lean as possible by excluding raw data that is not needed for the desired stat calcs
- Refactored any methods using nested iteration with non-nested iteration solutions
- Used Mocks and stubs in expensive test methods to reduce test time from 91s -> 65s seconds when testing with full dataset
- Used fixture files to significantly improve test performance
- Used class variables in tests instead of setup methods to ensure data was only loaded once

### Inheritance and Modules
- Created a Mathable module to hold an average method that is used in multiple calculations
- Created a Helpable module that holds helper methods used for calculations in each of the data classes
- Since Team, Game, and GameTeam are all classes that hold sets of data, we created a DataSet superclass to hold methods that are shared between those classes
- Stored collections of Team, Game, and GameTeam data in class variables for each respective class (this was a transition from using Collection classes for each type of object)
- Created class methods for methods that used all instances within that class 

### Graphical Representation

![alt text](https://user-images.githubusercontent.com/47278429/88852464-28a50800-d1a3-11ea-9674-0e59f175a367.png)
