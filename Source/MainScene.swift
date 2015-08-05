import Foundation
import CoreMotion



class MainScene: CCNode {
    
    weak var xMark: CCSprite!
    weak var check: CCSprite!
    weak var scoreLabel: CCLabelTTF!
    var xAcc: Double!
    var yAcc: Double!
    var zAcc: Double!
    var xRot: Double!
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
    var dropIt: Bool! = false
    var twistIt: Bool! = false
    var liftIt: Bool! = false
    var shakeIt: Bool! = false
    weak var life1: CCSprite!
    weak var life2: CCSprite!
    weak var life3: CCSprite!
    

    
    var gameState: String = "nothing" {
        didSet {
            
        }
    }
    var previousAction: Int = 0
    
    var score: Int = 0 {
        didSet {
            scoreLabel.string = "\(score)"
        }
    }
    
    func didLoadFromCCB () {
        var drop = CCBReader.load("Drop") as! Drop
        var twist = CCBReader.load("Twist") as! Twist
        var lift = CCBReader.load("Lift") as! Lift
        var shake = CCBReader.load("Shake") as! Shake
        
        randomStateChange()
        
        motionKit.getDeviceMotionObject(interval: 1.0){
            (deviceMotion) -> () in
            
            var rotationX = deviceMotion.rotationRate.x
            
        }
        

    }
    
    override func onEnter() {
        super.onEnter()
    }
    
    override func update(delta: CCTime) {
               if life3.visible == true {
            
            life3.visible == false
            
        } else if life2.visible == true {
            life2.visible == false
            
        } else if life1.visible == true {
            life1.visible == false
                gameOver()
         }
    }

    func gameOver() {
        println("game is over")
    }

    func randomStateChange() {
        
        var randomNumber = arc4random_uniform(4)
        
        do {
            randomNumber = arc4random_uniform(4)
        } while Int(randomNumber) == previousAction
        
        println("Random number = \(randomNumber)")
        
        drop.visible = false
        twist.visible = false
        lift.visible = false
        shake.visible = false
        check.visible = false

    
        
        if randomNumber == 0 && previousAction != 0{
            drop.visible = true
            gameState = "drop"
            scheduleOnce("dropDetection", delay: 0)
        } else if randomNumber == 1 && previousAction != 1{
            twist.visible = true
            gameState = "twist"
            scheduleOnce("twistDetection", delay: 0)
        } else if randomNumber == 2 && previousAction != 2{
            lift.visible = true
            gameState = "lift"
            scheduleOnce("liftDetection", delay: 0)
        } else if randomNumber == 3 && previousAction != 3{
            shake.visible = true
            gameState = "shake"
            scheduleOnce("shakeDetection", delay: 0)
        }
    }
    
    func dropDetection() {
        
        let thresholdY = 0.217819213867188
        let thresholdZ = -0.734298706054688
        var dropIt = false
        
        motionKit.getAccelerometerValues(interval: 0.65) {
            (xAcc, yAcc, zAcc) in
            println("\(yAcc) , \(zAcc)")
            
            if  zAcc >  thresholdZ && yAcc > thresholdY{
                if  zAcc >  -0.8698 && yAcc > 0.3015 {
                    println("Drop Detected")
                    self.previousAction = 0
                    self.randomStateChange()
                    self.check.visible = true
                    self.score++
                }
            } 
        }
    }
    
 
    func liftDetection() {
        let thresholdYy = -0.717
        let thresholdZz = -0.638
        var liftIt = false

        motionKit.getAccelerometerValues(interval: 0.65) {
            (xAcc, yAcc, zAcc) in
            
            println("\(yAcc) , \(zAcc)")
            if  zAcc > thresholdZz && yAcc > thresholdYy {
                if zAcc >  -0.311 && yAcc > -0.80 {
                    println("Lift Detected")
                    self.previousAction = 2
                    self.check.visible = true
                    self.score++
                    self.randomStateChange()
                    
                    
                }
            }
            
        }
    }
    
    func twistDetection() {
        
        let thresholdx = -0.80
        var twistIt = false
        
        motionKit.getRotationRateFromDeviceMotion(interval: 1.0) {
            (xRot, y, z) -> () in
                
            println("\(xRot)" )
            
            if  xRot < thresholdx {
                
                println("Twist Detected")
//                self.unschedule("twistDetection")
                self.previousAction = 1
                self.check.visible = true
                self.randomStateChange()
                self.score++
            }
        }
    }


    
    
    
    func shakeDetection() {
        let threshold = 1.0
        var shakeIt = false
        motionKit.getAccelerometerValues(interval: 1) {
            (xAcc, yAcc, zAcc) in

            if  xAcc > threshold || xAcc < -threshold ||
                yAcc > threshold || yAcc < -threshold ||
                zAcc > threshold || zAcc < -threshold {
                    println("Shake Detected")
                    self.previousAction = 3
                    self.check.visible = true
                    self.randomStateChange()
                    self.score++
            }
        }
    }


}//Class
