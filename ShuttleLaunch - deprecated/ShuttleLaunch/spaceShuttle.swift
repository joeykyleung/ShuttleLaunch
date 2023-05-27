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
        super.init(texture: imageTexture, color:UIColor.clearColor(), size: imageTexture.size())
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: imageTexture.size())
        self.physicsBody?.dynamic = false
        self.physicsBody?.allowsRotation = false
        
        rect = CGRectMake(self.frame.midX, self.frame.midY, self.frame.width, self.frame.height)
    }
    
    init(imageNamed: String, no: Int){
        let imageTexture = SKTexture(imageNamed: imageNamed)
        vector = CGVectorMake(0, 0)
        rect = CGRectMake(0,0,0,0)
        super.init(texture: imageTexture, color:UIColor.clearColor(), size: imageTexture.size())
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: imageTexture.size())
        self.physicsBody?.dynamic = false
        self.physicsBody?.allowsRotation = false
        
        rect = CGRectMake(self.frame.midX, self.frame.midY, self.frame.width, self.frame.height)
    }
    func move(){
        self.physicsBody?.applyImpulse(vector)
    }
    func moveShuttle(touch:UITouch){
        let force = (touch.force > 1 ? touch.force : 1)
        
        vector = CGVectorMake(0, force/4*3)
        self.physicsBody?.applyImpulse(vector)
    }
}