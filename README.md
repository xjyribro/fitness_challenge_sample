# sample_fitness_project

##  Data objects
There are 2 main data objects: User and Challenge. The main method creates a sample challenge object in  _./lib/main.dart_
1. User - The user object holds information like username and other user details, and it also stores the reward points. Foudn in _./lib/data/user.dart_
2. Challenge - The challenge object will store the challenge details and checkpoints. _./lib/data/challenge.dart_

## Database helpers

Database helper methods can be found in _./lib/data/helpers.dart_ These helpers use Firestore as the database provider, but can be changed to any DB provider easily due to the modular code structure.


