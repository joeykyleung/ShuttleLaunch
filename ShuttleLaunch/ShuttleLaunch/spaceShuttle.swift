//
//  spaceShuttle.swift
//  ShuttleLaunch
//
//  Created by Joey Leung on 25/5/2016.
//  Copyright © 2016 Joey Leung. All rights reserved.
//

import Foundation
import SpriteKit

class spaceShuttle: SKSpriteNode{
    
    var vector : CGVector
    var rect: CGRect
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init (imageNamed: String){
        
        let imageTexture = SKTexture(imageNamed: imageNamed)
        vector = CGVectorMake(0, 0)
        rect = CGRectMake(0,0,0,0)
        super.init(texture: imageTexture, color:UIColor.clear, size: imageTexture.size())
        
        self.physicsBody = SKPhysicsBody(rectangleOf: imageTexture.size())
        self.physicsBody?.isDynamic = false
        self.physicsBody?.allowsRotation = false
        
        rect = CGRectMake(self.frame.midX, self.frame.midY, self.frame.width, self.frame.height)
    }
    
    init(imageNamed: String, no: Int){
        let imageTexture = SKTexture(imageNamed: imageNamed)
        vector = CGVectorMake(0, 0)
        rect = CGRectMake(0,0,0,0)
        super.init(texture: imageTexture, color:UIColor.clear, size: imageTexture.size())
        
        self.physicsBody = SKPhysicsBody(rectangleOf: imageTexture.size())
        self.physicsBody?.isDynamic = false
        self.physicsBody?.allowsRotation = false
        
        rect = CGRectMake(self.frame.midX, self.frame.midY, self.frame.width, self.frame.height)
    }
    func move(){
        self.physicsBody?.applyImpulse(vector)
    }

//    func moveShuttle(touch: UITouch) {
//        let maxForce: CGFloat = 10.0 // Maximum force value for full power
//        let minPressDuration: TimeInterval = 0.1 // Minimum duration in seconds to consider a valid touch
//
//        let initialTimestamp = touch.timestamp // Store the initial touch timestamp
//        let currentTime = CACurrentMediaTime() // Get the current timestamp
//
//        let duration = currentTime - initialTimestamp // Calculate the duration of the touch
//        let normalizedDuration = CGFloat(max(minPressDuration, duration)) / CGFloat(minPressDuration) // Normalize the duration
//
//        let force = touch.force * normalizedDuration * maxForce // Calculate the force based on touch force and duration
//
////        print(duration, normalizedDuration, force)
//
//        vector = CGVector(dx: 0, dy: force * 0.75) // Adjust the vector based on the force
//        self.physicsBody?.applyImpulse(vector)
//    }
    

    func moveShuttle(force:CGFloat){
        vector = CGVectorMake(0, force/4*3)
        self.physicsBody?.applyForce(vector)
    }
}
