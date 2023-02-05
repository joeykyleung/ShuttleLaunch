//
//  checkpoint.swift
//  ShuttleLaunch
//
//  Created by Joey Leung on 26/5/2016.
//  Copyright © 2016 Joey Leung. All rights reserved.
//

import Foundation
import SpriteKit

enum objdirection{
    case left
    case right
}

class backgroundobj: SKSpriteNode{
    
    var dy: CGFloat
    var dx: CGFloat
    var isAlive:Bool
    var direction:objdirection = .left
    var rect: CGRect
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init (imageNamed: String){
        
        let imageTexture = SKTexture(imageNamed: imageNamed)
        dy = 0
        dx = 1
        isAlive = true
        rect = CGRectMake(0,0,0,0)
        super.init(texture: imageTexture, color:UIColor.clearColor(), size: imageTexture.size())
        rect = CGRectMake(self.frame.midX, self.frame.midY, self.frame.width, self.frame.height)
    }
    
    func addPhysics(imageNamed:String){
        let imageTexture = SKTexture(imageNamed: imageNamed)
        self.physicsBody = SKPhysicsBody(rectangleOfSize: imageTexture.size())
        self.physicsBody?.dynamic = false
        self.physicsBody?.allowsRotation = false
    }
    
    func moveY(){
        self.position.y = self.frame.midY-dy
    }
    
    let rand = arc4random_uniform(2)
    func moveX(){
        let min = CGFloat.init(370-self.frame.width-100)
        let max = CGFloat.init(650+self.frame.width+100)
        
        if rand == 0{
            direction = .left
        }
        if rand == 1{
            direction = .right
        }
        
        if direction == .left{
            self.position.x = self.frame.midX-dx
            if (self.position.x <= min){
                self.position.x = max
            }
        }
        if direction == .right{
            self.position.x = self.frame.midX+dx
            if (self.position.x >= max){
                self.position.x = min
            }
        }
    }
}