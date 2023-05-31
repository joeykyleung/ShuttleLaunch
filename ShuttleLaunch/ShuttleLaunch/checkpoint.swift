//
//  checkpoint.swift
//  ShuttleLaunch
//
//  Created by Joey Leung on 26/5/2016.
//  Copyright © 2016 Joey Leung. All rights reserved.
//

import Foundation
import SpriteKit

enum shuttledirection{
    case left
    case right
}

class checkpoint: SKSpriteNode{
    
    var dy: CGFloat
    var dx: CGFloat
    var isAlive:Bool
    var direction:shuttledirection = .left
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init (imageNamed: String){
        
        let imageTexture = SKTexture(imageNamed: imageNamed)
        dy = 0
        dx = 3
        isAlive = true
        super.init(texture: imageTexture, color:UIColor.clear, size: imageTexture.size())
    }
    
    func addPhysics(imageNamed:String){
        let imageTexture = SKTexture(imageNamed: imageNamed)
        self.physicsBody = SKPhysicsBody(rectangleOf: imageTexture.size())
        self.physicsBody?.isDynamic = false
        self.physicsBody?.allowsRotation = false
    }
    
    func moveY(){
        self.position.y = self.frame.midY-dy
    }
    
    func moveX(){
        let min = CGFloat.init(384)
        let max = CGFloat.init(640)
        
        if (self.position.x <= min){
            direction = .left
        }
        
        if (self.position.x >= max){
            direction = .right
        }
        
        if direction == .left{
            self.position.x = self.frame.midX+dx
        }
        if direction == .right{
            self.position.x = self.frame.midX-dx
        }
    }
}
