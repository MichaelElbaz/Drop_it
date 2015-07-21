import Foundation
import CoreMotion

// drop check y acess points then reset
// twist it check z range it 
// 


class MainScene: CCNode {
    
    var xAcc: Double!
    var yAcc: Double!
    var zAcc: Double!
    weak var drop: CCNode!
    weak var twist: CCNode!
    weak var lift: CCNode!
    weak var shake: CCNode!
    var gyroX: Double!
    var gyroY: Double!
    var gyroZ: Double!
    var gyroData: CMGyroData!
    var gyroAvailable: Bool!
    let motionKit = MotionKit()
    weak var label: CCLabelTTF!

    
    func didLoadFromCCB () {
        var drop = CCBReader.load("Drop") as! Drop
        var twist = CCBReader.load("Twist") as! Twist
        var lift = CCBReader.load("Lift") as! Lift
        var shake = CCBReader.load("Shake") as! Shake
        schedule("randomAction", interval: 3)
        

        motionKit.getGyroValues(interval: 1.0){
            (gyroX, gyroY, gyroZ) in
            //Do whatever you want with the x, y and z values
            println("\(gyroX)","\(gyroY)","\(gyroZ)")
        }
        
        motionKit.getAccelerometerValues(interval: 1.0){
            (xAcc, yAcc, zAcc) in
            
            println("\(xAcc)","\(yAcc)","\(zAcc)")
        }
    
//        CCDirector.sharedDirector().view.addGestureRecognizer(s)
    
    }
    
    
     override func onEnter() {
        super.onEnter()
        
    }
    
   override func update(delta: CCTime) {
        
//        println("Motion =")
    }


    func randomAction() {
            
        var randomNumber = arc4random_uniform(4)

    
        drop.visible = false
        twist.visible = false
        lift.visible = false
        shake.visible = false
        
        if randomNumber == 0 {
            drop.visible = true
        } else if randomNumber == 1 {
            twist.visible = true
        } else if randomNumber == 2 {
            lift.visible = true
        } else if randomNumber == 3 {
            shake.visible = true
        }
        
        }//randomAction
    
        
    
    }//Class






















