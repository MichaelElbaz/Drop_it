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
    var previousAction: Int = 0

    
    func didLoadFromCCB () {
        var drop = CCBReader.load("Drop") as! Drop
        var twist = CCBReader.load("Twist") as! Twist
        var lift = CCBReader.load("Lift") as! Lift
        var shake = CCBReader.load("Shake") as! Shake
        
        randomStateChange()
    }
    
    override func onEnter() {
        super.onEnter()
    }
    
    override func update(delta: CCTime) {
//        timer -= 0.01
//        if timer <= 0 {
//            gameOver()
//        }
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
        
        
        if randomNumber == 0 && previousAction != 0{
            drop.visible = true
            gameState = "drop"
            scheduleOnce("dropDetection", delay: 0)
            previousAction = 0
        } else if randomNumber == 1 && previousAction != 1{
            twist.visible = true
            gameState = "twist"
            self.randomStateChange()
            previousAction = 1
            // schedule("twistDetection", interval: 0.1)
        } else if randomNumber == 2 && previousAction != 2{
            lift.visible = true
            gameState = "lift"
            scheduleOnce("liftDetection", delay: 0)
            previousAction = 2
        } else if randomNumber == 3 && previousAction != 3{
            shake.visible = true
            gameState = "shake"
            scheduleOnce("shakeDetection", delay: 0)
            previousAction = 3
        }
    }
    
    func dropDetection() {
        
        let thresholdY = 0.5718
        let thresholdZ = -0.8417
        
        motionKit.getAccelerometerValues(interval: 0.65) {
            (xAcc, yAcc, zAcc) in
            println("\(yAcc) , \(zAcc)")
            
            if  zAcc >  thresholdZ && yAcc > thresholdY{
                if  zAcc >  -0.8698 && yAcc > 0.715 {
                    println("Drop Detected")
                    self.unschedule("dropDetection")
                    self.randomStateChange()
                    
                } else if zAcc <= 0.2756 && yAcc <= 1.72{
                    
                    println("Chill, dude")
                    
                }
                
                
            }
        }
    }
 
    func liftDetection() {
        let thresholdYy = -0.717
        let thresholdZz = -0.724
        
        motionKit.getAccelerometerValues(interval: 0.65) {
            (xAcc, yAcc, zAcc) in
            
            println("\(yAcc) , \(zAcc)")
            if  zAcc > thresholdZz && yAcc > thresholdYy {
                if zAcc > -0.83 && yAcc > -0.34 {
                println("Lift Detected")
                self.unschedule("liftDetection")
                self.randomStateChange()
                }
            }
        }
    }
    
    func twistDetection() {
        let Gholdx = 0.1
        randomStateChange()
        

        //        motionKit.getRotationRateFromDeviceMotion(interval: 1.0) {
        //(x, y, z) -> () in

//          if Rtwist
//
//          if else Ltwist
//        println("Twist Detected")
//                self.unschedule("twistDetection")
//            }
//        }
//        sleep(1)
    }

    func shakeDetection() {
       let threshold = 1.0
        
        motionKit.getAccelerometerValues(interval: 1.0) {
            (xAcc, yAcc, zAcc) in
            
            if  xAcc > threshold || xAcc < -threshold ||
                yAcc > threshold || yAcc < -threshold ||
                zAcc > threshold || zAcc < -threshold {
                    println("Shake Detected")
                    self.unschedule("shakeDetection")
                    self.randomStateChange()
            }
    
        }

    }

}//Class
