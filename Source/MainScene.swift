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
    var timer: Double = 5.0
    var gameState: String = "nothing" {
        didSet {
            
        }
    }
    
    func didLoadFromCCB () {
        var drop = CCBReader.load("Drop") as! Drop
        var twist = CCBReader.load("Twist") as! Twist
        var lift = CCBReader.load("Lift") as! Lift
        var shake = CCBReader.load("Shake") as! Shake
        schedule("randomAction", interval: 3)
        

        motionKit.getGyroValues(interval: 1.0){
            (gyroX, gyroY, gyroZ) in
        }
        
        
        schedule("shakeDetection", interval: 0.2)
//        CCDirector.sharedDirector().view.addGestureRecognizer(s)
    
    }
    
    
     override func onEnter() {
        super.onEnter()
        
    }
    
   override func update(delta: CCTime) {
        timer -= 0.01
    if timer <= 0 {
        gameOver()
    }
    
    
    }

    func gameOver() {
        println("game is over")
    }

    func randomStateChange() {
        
          var randomNumber = arc4random_uniform(4)
        
        drop.visible = false
        twist.visible = false
        lift.visible = false
        shake.visible = false
        
        if randomNumber == 0 {
            drop.visible = true
            gameState = "drop"
        } else if randomNumber == 1 {
            twist.visible = true
             gameState = "twist"
        } else if randomNumber == 2 {
            lift.visible = true
             gameState = "lift"
        } else if randomNumber == 3 {
            shake.visible = true
             gameState = "shake"
            schedule("shakeDetection", interval: 0.2)
            
        }
    }
    
    func dropDetection() {
        let threshold = 2.1;
        
        motionKit.getAccelerometerValues(interval: 1.0){
            (xAcc, yAcc, zAcc) in
            
            if xAcc > threshold || xAcc < -threshold ||
                yAcc > threshold || yAcc < -threshold ||
                zAcc > threshold || zAcc < -threshold {
                    println("Drop Detected")
            }
        }
    }
    
    func liftDetection() {
        let threshold = 2.1;
        
        motionKit.getAccelerometerValues(interval: 1.0){
            (xAcc, yAcc, zAcc) in
            
            if xAcc > threshold || xAcc < -threshold ||
                yAcc > threshold || yAcc < -threshold ||
                zAcc > threshold || zAcc < -threshold {
                    println("Lift Detected")
            }
        }
    }
    
    func twistDetection() {
        let threshold = 2.1;
        
        motionKit.getGyroValues(interval: 1.0){
            (gyroX, gyroY, gyroZ) in
            
            if gyroX > threshold || gyroX < -threshold ||
                gyroY > threshold || gyroY < -threshold ||
                gyroZ > threshold || gyroZ < -threshold {
                    println("Twist Detected")
            }
        }
    }
    
    
    
    
    func shakeDetection() {
       let threshold = 2.1;
        
        motionKit.getAccelerometerValues(interval: 1.0){
            (xAcc, yAcc, zAcc) in
            
            if xAcc > threshold || xAcc < -threshold ||
                yAcc > threshold || yAcc < -threshold ||
                zAcc > threshold || zAcc < -threshold {
                    println("Shake Detected")
            }
    
        }

    }
    


}//Class






















