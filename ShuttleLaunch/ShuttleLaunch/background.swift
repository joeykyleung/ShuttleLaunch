//
//  background.swift
//  ShuttleLaunch
//
//  Created by Joey Leung on 26/5/2016.
//  Copyright © 2016 Joey Leung. All rights reserved.
//

import Foundation
import SpriteKit

class background: SKSpriteNode{
    
    var xpos: CGFloat!
    var ypos: CGFloat!
    var dy: CGFloat = 0
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init (imageNamed: String){
        let imageTexture = SKTexture(imageNamed: imageNamed)
        super.init(texture: imageTexture, color:UIColor.clear, size: imageTexture.size())
    }
    
    func addPhysics(imageNamed:String){
        let imageTexture = SKTexture(imageNamed: imageNamed)
        self.physicsBody = SKPhysicsBody(rectangleOf: imageTexture.size())
        self.physicsBody?.isDynamic = false
        self.physicsBody?.allowsRotation = false
    }
    
    func move(){
        self.position = CGPointMake(self.frame.midX, self.frame.midY-dy)
    }
}
