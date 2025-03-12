# ShuttleLaunch
### **Demo:**
<img width="200" alt="Starting the game" src="https://github.com/joeykyleung/ShuttleLaunch/assets/77413460/a323eac2-2f55-4442-85c1-6fb5f6e83d7b">
<img width="200" alt="Platform and collision objects" src="https://github.com/joeykyleung/ShuttleLaunch/assets/77413460/e556826e-bfb9-4aa7-916e-9f7c5afc3350">
<img width="200" alt="End game" src="https://github.com/joeykyleung/ShuttleLaunch/assets/77413460/c43ae332-9b89-4f28-8e05-f017daae37c1">
<img width="200" alt="Game over scene" src="https://github.com/joeykyleung/ShuttleLaunch/assets/77413460/c4d4c5d6-cab3-4fac-bfb3-8ff0b52258ec">

## Overview
ShuttleLaunch is an engaging iOS game built with UIKit that challenges players to navigate a space shuttle through obstacles while managing physics-based controls. The game demonstrates practical implementation of custom physics, touch-based controls, and dynamic obstacle generation.

## Technical Implementation

### Core Technologies
- **Framework**: UIKit
- **Language**: Swift
- **Design Pattern**: Model-View-Controller (MVC)
- **Graphics**: Custom sprite-based rendering
- **Physics**: Custom implementation for gravity and collision detection

### Technical Challenges & Solutions

#### 1. Physics Engine Implementation
- **Challenge**: Implementing realistic shuttle physics without SpriteKit
- **Solution**: Created a custom physics system in `SpaceShuttle.swift` that:
  - Calculates acceleration based on touch duration
  - Implements velocity dampening for smooth movement
  - Handles collision detection with precise hitbox calculations

#### 2. Smooth Touch Controls
- **Challenge**: Creating responsive yet precise touch controls
- **Solution**: 
  - Implemented touch tracking system that follows finger position
  - Added interpolation for smooth horizontal movement
  - Optimized input latency through efficient event handling

#### 3. Performance Optimization
- **Challenge**: Maintaining smooth gameplay with multiple moving objects
- **Solution**:
  - Implemented object pooling for obstacles and platforms
  - Optimized background scrolling using layer compositing
  - Efficient memory management for asset loading/unloading

## Architecture

### Key Components
1. **GameScene**
   - Manages game loop and state
   - Handles touch input processing
   - Controls object spawning and cleanup

2. **SpaceShuttle**
   - Implements physics calculations
   - Manages collision detection
   - Handles movement controls

3. **Background & Objects**
   - Parallax scrolling implementation
   - Dynamic obstacle generation
   - Platform movement patterns

## Installation & Setup

### Requirements
- Xcode 13.0+
- iOS 14.0+
- Swift 5.0+

### Getting Started
1. Clone the repository:
   ```bash
   git clone https://github.com/joeykyleung/ShuttleLaunch.git
   ```
2. Open `ShuttleLaunch.xcodeproj` in Xcode
3. Select your target device/simulator
4. Build and run (⌘ + R)

## How to Play
1. Launch the game and wait for game scene
2. Tap anywhere to start the game
3. Tap and hold on the shuttle to initiate upward movement
   - Longer holds increase acceleration
   - Release to allow gravity to take effect
4. Guide the shuttle horizontally by moving your finger
5. Land on platforms to score points
6. Avoid obstacles to prevent game over