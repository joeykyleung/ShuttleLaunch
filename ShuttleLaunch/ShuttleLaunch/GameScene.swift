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
    
    var bgImage: background?
    var shuttleNode:spaceShuttle?
    var checkpointNode: [checkpoint] = []
    var checkpoint1: checkpoint? = checkpoint(imageNamed:"platform")
    var checkpoint2: checkpoint? = checkpoint(imageNamed:"platform")
    var checkpoint3: checkpoint? = checkpoint(imageNamed:"platform")
    var checkpoint4: checkpoint? = checkpoint(imageNamed:"platform")
    var checkpoint5: checkpoint? = checkpoint(imageNamed:"platform")
    var checkpoint6: checkpoint? = checkpoint(imageNamed:"platform")
    var objNode: [backgroundobj] = []
    var satellite: backgroundobj? = backgroundobj(imageNamed: "satellite")
    var plane: backgroundobj? = backgroundobj(imageNamed: "planeL")
    
    var score = 0
    var scoreLabel:SKLabelNode!
    var heightLabel:SKLabelNode!
    var gravityLabel:SKLabelNode!
    var speedLabel:SKLabelNode!
    let font = "Arial"
    var startScreen:background?
    var startLabel:SKLabelNode!
    
    var launchPad:SKSpriteNode!
    var held: Bool! = false
    var hit: Bool! = false
    var ingame: Bool! = false
    var temp_speed: Float = 0
    var start_speed: Float = 45
    var max_speed: Float = 60
    var activeTouches: Set<UITouch> = []
    var shuttle_exhaust = SKSpriteNode()

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
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = SKColor.purple
        self.scaleMode = SKSceneScaleMode.aspectFill
        let container = CGSizeMake(self.frame.width, self.frame.height*3/4)
        self.physicsBody = SKPhysicsBody (edgeLoopFrom: CGRectMake(0, 0, container.width, container.height))
        self.physicsBody?.restitution = 0
        self.physicsWorld.gravity = CGVectorMake(0, -9.81)
        
        bgImage = background(imageNamed: "background")
        bgImage!.position = CGPointMake(CGRectGetMidX(self.frame), bgImage!.frame.size.height/2)
        bgImage!.zPosition = 1
        
        launchPad = SKSpriteNode(color: SKColor.gray, size: CGSizeMake(140, 50))
        launchPad!.position = CGPointMake(560, 0)
        launchPad!.physicsBody = SKPhysicsBody(rectangleOf: launchPad!.size)
        launchPad!.physicsBody?.isDynamic = false
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
            checkpoint.position = CGPointMake(CGFloat(arc4random_uniform(265)) + 380, checkpointIncrementer())
            checkpoint.addPhysics(imageNamed: "platform")
            checkpoint.zPosition = 2
        }
        
        shuttleNode = spaceShuttle(imageNamed:"spaceshuttle")
        shuttleNode!.position = CGPointMake(CGRectGetMidX(self.frame)+49, 118)
        shuttleNode!.zPosition = 3
        
        let shuttle_exhaust_texture = SKTexture(imageNamed: "spaceshuttleFire")
        shuttle_exhaust = SKSpriteNode(texture: shuttle_exhaust_texture, color:UIColor.clear, size: shuttle_exhaust_texture.size())
        shuttle_exhaust.isHidden = true
        shuttle_exhaust.position = shuttleNode!.position
        shuttle_exhaust.zPosition = 2  // Ensure the flame appears behind the shuttle
        addChild(shuttle_exhaust)
        
        objNode.append(plane!)
        plane!.position = CGPointMake(CGFloat(arc4random_uniform(580))+220,
                                      CGFloat(arc4random_uniform(900))+380)
        objNode.append(satellite!)
        satellite!.position = CGPointMake(CGFloat(arc4random_uniform(580))+220,
                                          CGFloat(arc4random_uniform(1200))+1480)
        for backgroundobj in objNode{
            backgroundobj.zPosition = 1.5
        }
        
        scoreLabel = SKLabelNode(fontNamed: font)
        scoreLabel.text = "Score: 0"
        scoreLabel.fontSize = 20
        scoreLabel.position = CGPointMake(self.frame.maxX/2-110, self.frame.maxY-50)
        scoreLabel.zPosition = 4
        
        heightLabel = SKLabelNode(fontNamed: font)
        heightLabel.text = "3.2.1..."
        heightLabel.fontSize = 20
        heightLabel.position = CGPointMake(self.frame.maxX/2+115, self.frame.maxY-50)
        heightLabel.zPosition = 4
        
        gravityLabel = SKLabelNode(fontNamed: font)
        gravityLabel.text = "Gravity: \(abs(round(self.physicsWorld.gravity.dy * 100) / 100))"
        gravityLabel.fontSize = 20
        gravityLabel.position = CGPointMake(self.frame.maxX/2+110, self.frame.maxY-80)
        gravityLabel.zPosition = 4
        
        speedLabel = SKLabelNode(fontNamed: font)
        speedLabel.text = "Speed: \(round((shuttleNode!.physicsBody?.velocity.dy)!))"
        speedLabel.fontSize = 20
        speedLabel.position = CGPointMake(self.frame.maxX/2+115, self.frame.maxY-110)
        speedLabel.zPosition = 4
        
        startScreen = background(imageNamed: "gray")
        startScreen!.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        startScreen!.zPosition = 5
        
        startLabel = SKLabelNode(fontNamed: font)
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
        addChild(gravityLabel)
        addChild(speedLabel)
        addChild(startScreen!)
        addChild(startLabel)
    }
    
    override func update(_ currentTime: CFTimeInterval) {
        gravityLabel.text = "Gravity: \(abs(round(self.physicsWorld.gravity.dy * 100) / 100))"
        speedLabel.text = "Speed: \(round((shuttleNode!.physicsBody?.velocity.dy)!))"
        
        shuttle_exhaust.position = CGPointMake(shuttleNode!.position.x - 13, shuttleNode!.position.y - 40)
        shuttle_exhaust.isHidden = !held || startLabel.isHidden == false
        
        if held == true && ingame == true{
            shuttleNode!.move()
            temp_speed += 1
            temp_speed = (temp_speed >= max_speed ? max_speed : temp_speed)
            if (activeTouches != [] && startLabel.isHidden == true) {
                main(touch: activeTouches.first!)
            }
        }
        
        if(shuttleNode!.position.y >= CGRectGetMidY(self.frame)){
            bgImage!.move()
            
            if bgImage!.position.y <= -410 {
                bgImage!.position.y = -410
                bgImage!.dy = 0
                let container = CGSizeMake(self.frame.width, self.frame.height)
                self.physicsBody = SKPhysicsBody (edgeLoopFrom: CGRectMake(0, 0, container.width, container.height))
                
                if shuttleNode!.position.y >= 661{
                    shuttleNode!.isHidden = true
                    shuttle_exhaust.isHidden = true
                    self.reset()
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
        
        if plane!.direction == .right{
            plane!.texture = (SKTexture(imageNamed: "planeR"))
        }
        
        func gameover(explosion: SKSpriteNode?) {
            ingame = false
            startLabel.text = "Game Over"
            startLabel.isHidden = false
            let waitAction = SKAction.wait(forDuration: 3)
            ingame = true
            self.run(waitAction, completion: { [self] in
                startLabel.isHidden = true
                explosion?.isHidden = true
                reset()
            })
        }
        
        if(bgImage!.position.y < 1100 && shuttleNode!.position.y < 105){
            if startLabel.isHidden {
                shuttleNode!.isHidden = true
                shuttle_exhaust.isHidden = true
                gameover(explosion: nil)
            }
        }
        
        for backgroundobj in objNode{
            backgroundobj.moveX()
            
            if (shuttleNode!.contains(CGPointMake(backgroundobj.frame.maxX, backgroundobj.frame.minY))) ||
                (shuttleNode!.contains(CGPointMake(backgroundobj.frame.minX, backgroundobj.frame.minY))) ||
                (shuttleNode!.contains(CGPointMake(backgroundobj.frame.midX, backgroundobj.frame.minY))){
                if hit == false{
                    shuttleNode!.isHidden = true
                    shuttle_exhaust.isHidden = true
                    backgroundobj.isHidden = true
                    
                    let explosion: SKSpriteNode! = SKSpriteNode(imageNamed: "explosion")
                    explosion!.position = CGPointMake(backgroundobj.frame.midX, backgroundobj.frame.midY)
                    explosion!.zPosition = 4
                    addChild(explosion)
                    gameover(explosion: explosion)
                }
                hit = true
            }
        }
        
        if (shuttleNode!.physicsBody?.velocity.dy)! > 0 && shuttleNode!.position.y > 125 {
            bgImage!.texture = (SKTexture(imageNamed: "backgroundSmoke"))
        }
    }
    
    func main(touch:UITouch) {
        let force = CGFloat(temp_speed)     //(touch.force > 1 ? touch.force : 1)
        
        shuttleNode!.moveShuttle(force:force)
        if shuttleNode!.position.y - launchPad!.position.y > 200 {
            shuttleNode!.position.x = touch.location(in: self.view).x + 320
        }
//        print(bgImage!.position.y)
//        print(shuttleNode!.physicsBody!.velocity.dy)
        
        //refactor below code and change gravity so it keeps increasing, fix ending position of bg
        func calc_force (force: CGFloat) -> CGFloat {
            var new_force = force
            if(bgImage!.position.y > 1100){
                heightLabel.text = ("Launching")
                launchPad!.position = CGPointMake(560, 0)
            } else if (bgImage!.position.y > 500){
                new_force /= 10
                heightLabel.text = ("Earth")
                launchPad!.position = CGPointMake(500, -100)
            } else if (bgImage!.position.y > -300){
                new_force /= 12
                self.physicsWorld.gravity = CGVectorMake(0, -2)
                heightLabel.text = ("Space")
            } else if (bgImage!.position.y > -500){
                new_force /= 15
                self.physicsWorld.gravity = CGVectorMake(0, 0)
                heightLabel.text = ("Outer Space")
            }
            print(new_force, bgImage!.position.y)
            return new_force
        }
        bgImage!.dy = calc_force(force: force)
        
        for checkpoint in checkpointNode{
            checkpoint.dy = calc_force(force: force)
        }
        for backgroundobj in objNode{
            backgroundobj.dy = calc_force(force: force)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(shuttleNode != nil){
            shuttleNode!.physicsBody?.velocity = CGVectorMake(0, 0)
            shuttleNode!.physicsBody?.isDynamic = true
            shuttleNode!.physicsBody?.affectedByGravity = true
        }
        held = true
        activeTouches.formUnion(touches)
    }
    
    //    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    //        if let touch: UITouch = touches.first{
    //            main(touch: touch, withEvent: event)
    //        }
    //            activeTouches.formUnion(touches)
    //    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            if startScreen!.contains(location) && ingame == false {
                startLabel.isHidden = true
                startScreen!.isHidden = true
                ingame = true
            }
        }
        held = false
        activeTouches.subtract(touches)
        temp_speed = start_speed
    }
    
    
    func reset() {
        hit = false
        ingame = false
        
        score = 0
        scoreLabel.text = "Score: \(score)"
        heightLabel.text = "3.2.1..."
        
        shuttle_exhaust.isHidden = false
        shuttleNode!.isHidden = false
        shuttleNode!.physicsBody?.velocity.dy = 0
        shuttleNode!.position = CGPointMake(CGRectGetMidX(self.frame)+49, 118)
        shuttleNode!.zPosition = 3
        launchPad!.position = CGPointMake(560, 0)
        
        bgImage!.texture = (SKTexture(imageNamed: "background"))
        bgImage!.position = CGPointMake(CGRectGetMidX(self.frame), bgImage!.frame.size.height/2)
        bgImage!.zPosition = 1
        
        let checkpointIncrementer = positionIncrementer(amountOfCheckpoints: UInt32(checkpointNode.count))
        for checkpoint in checkpointNode{
            checkpoint.isAlive = true
            checkpoint.position = CGPointMake(CGFloat(arc4random_uniform(265))+380, checkpointIncrementer())
            checkpoint.texture = (SKTexture(imageNamed: "platform"))
            checkpoint.zPosition = 2
        }
        for backgroundobj in objNode{
            backgroundobj.isAlive = true
            backgroundobj.isHidden = false
        }
        plane!.position = CGPointMake(CGFloat(arc4random_uniform(580))+220,
                                      CGFloat(arc4random_uniform(900))+380)
        satellite!.position = CGPointMake(CGFloat(arc4random_uniform(580))+220,
                                          CGFloat(arc4random_uniform(1200))+1480)
        
        let container = CGSizeMake(self.frame.width, self.frame.height*3/4)
        self.physicsBody = SKPhysicsBody (edgeLoopFrom: CGRectMake(0, 0, container.width, container.height))
        self.physicsWorld.gravity = CGVectorMake(0, -9.81)
    }
}
