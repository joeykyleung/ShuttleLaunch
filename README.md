# ShuttleLaunch
### **Demo:**
<img width="200" alt="Starting the game" src="https://github.com/joeykyleung/ShuttleLaunch/assets/77413460/a323eac2-2f55-4442-85c1-6fb5f6e83d7b">
<img width="200" alt="Platform and collision objects" src="https://github.com/joeykyleung/ShuttleLaunch/assets/77413460/e556826e-bfb9-4aa7-916e-9f7c5afc3350">
<img width="200" alt="End game" src="https://github.com/joeykyleung/ShuttleLaunch/assets/77413460/c43ae332-9b89-4f28-8e05-f017daae37c1">
<img width="200" alt="Game over scene" src="https://github.com/joeykyleung/ShuttleLaunch/assets/77413460/c4d4c5d6-cab3-4fac-bfb3-8ff0b52258ec">

&nbsp;
### **Description:**
ShuttleLaunch is an exciting and addictive game where you take control of a shuttle and propel it to outer space. Your objective is to launch the shuttle as high as possible while avoiding obstacles and landing on moving platforms to increase your score.

&nbsp;
### **Game Overview**
ShuttleLaunch is an iOS application that leverages the UIKit framework. Your task is to control the shuttle's upward movement by tapping and holding on the shuttle. The longer you hold, the more the shuttle accelerates upwards, up to a certain speed. Your goal is to time your taps and releases to navigate through the obstacles, such as planes and satellites, while aiming to land on the moving platforms to earn points.

The shuttle follows the horizontal position of your finger, allowing you to maneuver it strategically and avoid obstacles. Be cautious, as colliding with obstacles will result in a game over.

&nbsp;
### **File Descriptions**
* GameScene.swift: This file contains the implementation of the main scene for the game. It uses the game loop from UIKit to update each frame, as well as handles UITouch inputs to propel the shuttle. It handles the game logic, user interactions, physics simulation, scoring, and overall game flow.
* SpaceShuttle.swift: This class represents the shuttle object in the game. It handles the shuttle's movement and physics simulation with other objects. It also enables the shuttle to follow the x-position of the user's finger for precise control.
* Background.swift: This class handles the background image and scrolling functionality. It ensures a seamless scrolling experience and provides a visually appealing backdrop for the game.
* BackgroundObj.swift: This class manages the plane and satellite objects that appear as obstacles in the game. It controls their movement and behaviour in the scene.
* Checkpoint.swift: This class represents the moving platforms in the game. It handles their creation, movement and behavior in the scene.
* Assets.xcassets: This folder contains the project's asset catalog, where graphical assets used in the game, such as images and textures, are stored.


&nbsp;
### **How to Play**
1. Launch the game and wait for game scene.
2. Tap anywhere to start the game.
3. Tap and hold on the shuttle to initiate its upward movement. The longer you hold, the faster it accelerates.
4. Guide the shuttle by moving your finger horizontally to avoid obstacles such as planes and satellites.
5. Try to land on the moving platforms to earn points and increase your score.
6. Be careful not to collide with any obstacles, as it will result in a game over.
7. Score as high as possible
