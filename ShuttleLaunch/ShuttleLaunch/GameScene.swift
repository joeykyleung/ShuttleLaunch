//
//  GameScene.swift
//  ShuttleLaunch
//
//  Created by Joey Leung on 25/5/2016.
//  Copyright (c) 2016 Joey Leung. All rights reserved.
//

import SpriteKit
import UIKit

class GameScene: SKScene {
    
    var shuttleNode:spaceShuttle?
    var checkpointNode: [checkpoint] = []
    var checkpoint1: checkpoint? = checkpoint(imageNamed:"platform")
    var checkpoint2: checkpoint? = checkpoint(imageNamed:"platform")
    var checkpoint3: checkpoint? = checkpoint(imageNamed:"platform")
    var checkpoint4: checkpoint? = checkpoint(imageNamed:"platform")
    var checkpoint5: checkpoint? = checkpoint(imageNamed:"platform")
    var checkpoint6: checkpoint? = checkpoint(imageNamed:"platform")
    var bgImage: background?
    var container = CGSizeMake(0, 0)
    var score = 0
    var scoreLabel:SKLabelNode!
    var heightLabel:SKLabelNode!
    var startScreen:background?
    var startLabel:SKLabelNode!
    var launchPad:SKSpriteNode!
    var bgMax: Bool! = false
    var objNode: [backgroundobj] = []
    var satellite: backgroundobj? = backgroundobj(imageNamed: "satellite")
    var plane: backgroundobj? = backgroundobj(imageNamed: "planeL")
    
    var held: Bool! = false
    var hit: Bool! = false
    var ingame: Bool! = false
    func positionIncrementer(amountOfCheckpoints amount:UInt32)->()->CGFloat{
        var next_pos:CGFloat = 380
        var counter:UInt32 = 0
        let spacing:UInt32 = (3800/amount)+380
        func incrementer()->CGFloat{
            let upper = (spacing*(counter+1))
            let lower = spacing*counter
            let random = arc4random_uniform(upper-lower)+(lower)
            next_pos=CGFloat(random)
            counter+=1
            return next_pos
        }
        return incrementer
    }
    override func didMoveToView(view: SKView) {
        
        self.backgroundColor = SKColor.purpleColor()
        self.scaleMode = SKSceneScaleMode.AspectFill
        let container = CGSizeMake(self.frame.width, self.frame.height*3/4)
        self.physicsBody = SKPhysicsBody (edgeLoopFromRect: CGRectMake(0, 0, container.width, container.height))
        self.physicsBody?.restitution = 0
        self.physicsWorld.gravity = CGVectorMake(0, -9.81)
        
        bgImage = background(imageNamed: "background")
        bgImage!.position = CGPointMake(CGRectGetMidX(self.frame), bgImage!.frame.size.height/2)
        bgImage!.zPosition = 1
        
        launchPad = SKSpriteNode(color: UIColor.grayColor(), size: CGSizeMake(140, 50))
        launchPad!.position = CGPointMake(560, 0)
        launchPad!.physicsBody = SKPhysicsBody(rectangleOfSize: launchPad!.size)
        launchPad!.physicsBody?.dynamic = false
        launchPad!.physicsBody?.allowsRotation = false
        launchPad!.physicsBody?.restitution = 0
        launchPad!.zPosition = 0.5
        
        checkpointNode.append(checkpoint1!)
        checkpointNode.append(checkpoint2!)
        checkpointNode.append(checkpoint3!)
        checkpointNode.append(checkpoint4!)
        checkpointNode.append(checkpoint5!)
        checkpointNode.append(checkpoint6!)
        let checkpointIncrementer = positionIncrementer(amountOfCheckpoints: UInt32(checkpointNode.count))
        for checkpoint in checkpointNode{
            checkpoint.position = CGPointMake(CGFloat(arc4random_uniform(265))+380,
                                              checkpointIncrementer())
            checkpoint.zPosition = 2
        }
        
        shuttleNode = spaceShuttle(imageNamed:"spaceshuttle")
        shuttleNode!.position = CGPointMake(CGRectGetMidX(self.frame)+49, 118)
        shuttleNode!.zPosition = 3
        
        objNode.append(plane!)
        plane!.position = CGPointMake(CGFloat(arc4random_uniform(580))+220,
                                      CGFloat(arc4random_uniform(900))+380)
        objNode.append(satellite!)
        satellite!.position = CGPointMake(CGFloat(arc4random_uniform(580))+220,
                                         CGFloat(arc4random_uniform(1200))+1480)
        for backgroundobj in objNode{
            backgroundobj.zPosition = 1.5
        }
        
        scoreLabel = SKLabelNode(fontNamed: "Arial")
        scoreLabel.text = "Score: 0"
        scoreLabel.fontSize = 20
        scoreLabel.position = CGPointMake(self.frame.maxX/2-150, self.frame.maxY-50)
        scoreLabel.zPosition = 4
        
        heightLabel = SKLabelNode(fontNamed: "Arial")
        heightLabel.text = "3.2.1..."
        heightLabel.fontSize = 20
        heightLabel.position = CGPointMake(self.frame.maxX/2+150, self.frame.maxY-50)
        heightLabel.zPosition = 4
        
        startScreen = background(imageNamed: "gray")
        startScreen!.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        startScreen!.zPosition = 5
        
        startLabel = SKLabelNode(fontNamed: "Arial")
        startLabel.text = "Touch to Start"
        startLabel.fontSize = 40
        startLabel.position = CGPointMake(self.frame.midX, self.frame.midY)
        startLabel.zPosition = 5.1
        
        addChild(bgImage!)
        addChild(launchPad!)
        addChild(shuttleNode!)
        
        for backgroundobj in objNode{
            addChild(backgroundobj)
        }
        
        for checkpoint in checkpointNode{
            addChild(checkpoint)
        }
        
        addChild(scoreLabel)
        addChild(heightLabel)
        addChild(startScreen!)
        addChild(startLabel)
    }
    
    override func update(currentTime: CFTimeInterval) {
        if held == true{
            shuttleNode!.move()
        }
        
        if(shuttleNode!.position.y >= CGRectGetMidY(self.frame)){
            bgImage!.move()
            
            if bgImage!.position.y <= -395 {
                bgImage!.dy = 0
                bgMax = true
                container = CGSizeMake(self.frame.width, self.frame.height)
                self.physicsBody = SKPhysicsBody (edgeLoopFromRect: CGRectMake(0, 0, container.width, container.height))
                
                if shuttleNode!.position.y >= 661{
                    shuttleNode!.hidden = true
                    reset()
                }
            }
            
            for checkpoint in checkpointNode{
                checkpoint.moveY()
            }
            for backgroundobj in objNode{
                backgroundobj.moveY()
            }
        }
        
        for checkpoint in checkpointNode{
            checkpoint.moveX()
            
            if(shuttleNode!.frame.midY >= checkpoint.frame.midY &&
                shuttleNode!.frame.midX >= checkpoint.frame.midX-70 &&
                shuttleNode!.frame.midX <= checkpoint.frame.midX+70 &&
                shuttleNode!.frame.minY <= checkpoint.frame.midY+40 &&
                checkpoint.isAlive == true){
                checkpoint.texture = (SKTexture(imageNamed: "greenplatform"))
                score += 1
                scoreLabel.text = "Score: \(score)"
                checkpoint.isAlive = false
            }
        }
        
        if(bgImage!.position.y < 1100 && shuttleNode!.position.y < 105){
            reset()
        }
        
        if plane!.direction == .right{
            plane!.texture = (SKTexture(imageNamed: "planeR"))
        }
        
        if (shuttleNode!.containsPoint(CGPointMake(plane!.frame.maxX, plane!.frame.minY))) ||
            (shuttleNode!.containsPoint(CGPointMake(plane!.frame.minX, plane!.frame.minY))) ||
            (shuttleNode!.containsPoint(CGPointMake(plane!.frame.midX, plane!.frame.minY))){
            if hit == false{
            shuttleNode!.hidden = true
            plane!.hidden = true
            
            let explosion: SKSpriteNode! = SKSpriteNode(imageNamed: "explosion")
            explosion!.position = CGPointMake(plane!.frame.midX, plane!.frame.midY)
            explosion!.zPosition = 4
            addChild(explosion)
            
            startLabel.hidden = false
            startLabel.text = "Game Over"
            let waitAction = SKAction.waitForDuration(3)
            ingame = true
            self.runAction(waitAction, completion: {
                self.startLabel.hidden = true
                explosion!.hidden = true
                self.reset()
                self.shuttleNode!.hidden = false
                self.plane!.hidden = false
            })
            }
            hit = true
        }
        
        if (shuttleNode!.containsPoint(CGPointMake(satellite!.frame.maxX, satellite!.frame.minY))) ||
            (shuttleNode!.containsPoint(CGPointMake(satellite!.frame.minX, satellite!.frame.minY))) ||
            (shuttleNode!.containsPoint(CGPointMake(satellite!.frame.midX, satellite!.frame.minY))){
            if hit == false{
                shuttleNode!.hidden = true
                satellite!.hidden = true
                
                let explosion: SKSpriteNode! = SKSpriteNode(imageNamed: "explosion")
                explosion!.position = CGPointMake(satellite!.frame.midX, satellite!.frame.midY)
                explosion!.zPosition = 4
                addChild(explosion)
                
                startLabel.hidden = false
                startLabel.text = "Game Over"
                let waitAction = SKAction.waitForDuration(3)
                ingame = true
                self.runAction(waitAction, completion: {
                    self.startLabel.hidden = true
                    explosion!.hidden = true
                    self.reset()
                    self.shuttleNode!.hidden = false
                    self.satellite!.hidden = false
                })
            }
            hit = true
        }
        
        for backgroundobj in objNode{
            backgroundobj.moveX()
        }
        
        if shuttleNode!.physicsBody?.velocity.dy > 0{
            bgImage!.texture = (SKTexture(imageNamed: "backgroundSmoke"))
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if(shuttleNode != nil){
            shuttleNode!.physicsBody?.velocity = CGVectorMake(0, 0)
            shuttleNode!.physicsBody?.dynamic = true
            shuttleNode!.physicsBody?.affectedByGravity = true
        }
        held = true
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch: UITouch = touches.first{
            main(touch, withEvent: event)
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            if startScreen!.containsPoint(location) && ingame == false {
                startLabel.hidden = true
                startScreen!.hidden = true
            }
        }
        held = false
    }
    
    func main(touch:UITouch, withEvent event: UIEvent?){
        let force = (touch.force > 1 ? touch.force : 1)
        for checkpoint in checkpointNode{
            for backgroundobj in objNode{
                if startLabel.hidden == true{
                    shuttleNode!.moveShuttle(touch)
                    shuttleNode!.position.x = touch.locationInView(self.view).x+320
                    
                    //shuttleNode!.position = CGPointMake(touch.locationInView(self.view).x+320,touch.locationInView(self.view).y)
                    
                    checkpoint.addPhysics("platform")
                    if bgMax == false{
                        if(bgImage!.position.y > 1100){
                            bgImage!.dy = force/5
                            checkpoint.dy = force/5
                            backgroundobj.dy = force/5
                            heightLabel.text = ("Launching")
                            launchPad!.position = CGPointMake(560, 0)
                            
                        } else if (bgImage!.position.y > 500){
                            bgImage!.dy = force/2
                            checkpoint.dy = force
                            backgroundobj.dy = force
                            heightLabel.text = ("Earth")
                            launchPad!.position = CGPointMake(500, -100)
                            
                        } else if (bgImage!.position.y > -300){
                            bgImage!.dy = force/4
                            checkpoint.dy = force
                            backgroundobj.dy = force
                            self.physicsWorld.gravity = CGVectorMake(0, -2)
                            heightLabel.text = ("Space")
                            
                        } else if (bgImage!.position.y > -500){
                            bgImage!.dy = force/4
                            checkpoint.dy = force*2
                            backgroundobj.dy = force*2
                            self.physicsWorld.gravity = CGVectorMake(0, 0)
                            heightLabel.text = ("Outer Space")
                            
                        }
                    }
                }
            }
        }
    }
    
    func reset() {
        bgImage!.position = CGPointMake(CGRectGetMidX(self.frame), bgImage!.frame.size.height/2)
        
        let checkpointIncrementer = positionIncrementer(amountOfCheckpoints: UInt32(checkpointNode.count))
        for checkpoint in checkpointNode{
            checkpoint.isAlive = true
            checkpoint.position = CGPointMake(CGFloat(arc4random_uniform(265))+380,
                                              checkpointIncrementer())
            
            checkpoint.texture = (SKTexture(imageNamed: "platform"))
            checkpoint.zPosition = 2
        }
        for backgroundobj in objNode{
            backgroundobj.isAlive = true
            backgroundobj.hidden = false
        }
        plane!.position = CGPointMake(CGFloat(arc4random_uniform(580))+220,
                                      CGFloat(arc4random_uniform(900))+380)
        satellite!.position = CGPointMake(CGFloat(arc4random_uniform(580))+220,
                                          CGFloat(arc4random_uniform(1200))+1480)
        
        shuttleNode!.hidden = false
        shuttleNode!.zPosition = 3
        bgImage!.zPosition = 1
        launchPad!.zPosition = 0.5
        
        let container = CGSizeMake(self.frame.width, self.frame.height*3/4)
        self.physicsBody = SKPhysicsBody (edgeLoopFromRect: CGRectMake(0, 0, container.width, container.height))
        
        self.physicsWorld.gravity = CGVectorMake(0, -9.81)
        
        bgMax = false
        hit = false
        ingame = false
        
        shuttleNode!.position = CGPointMake(CGRectGetMidX(self.frame)+49, 118)
        score = 0
        scoreLabel.text = "Score: \(score)"
        
        shuttleNode!.physicsBody?.velocity.dy = 0
        bgImage!.texture = (SKTexture(imageNamed: "background"))
        
        let waitAction = SKAction.waitForDuration(2)
        
        self.runAction(waitAction, completion: {
        })
    }
}