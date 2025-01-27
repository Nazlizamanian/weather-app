//
//  Condition.swift
//  ios-final-weatherapp-nazlizamanian
//
//  Created by Nazli  on 17/01/25.
//
import Foundation
import SpriteKit
import SwiftUI

/*
 Source Backgorund: https://www.youtube.com/watch?v=_Ssae8NLHUs
 */

//isDay instead

class Condition: SKScene {
    private let emitterFileNamed: String
    
    init(emitterFileNamed: String){
        self.emitterFileNamed = emitterFileNamed
        super.init(size: UIScreen.main.bounds.size)
        commonSetUp()
    }
    
    required init?(coder aDecoder: NSCoder){
        fatalError("init(coder:) couldnt init ")
    }
    
    private func commonSetUp(){
        scaleMode = .resizeFill
        anchorPoint = CGPoint(x: 0.5, y:1)
        backgroundColor = .clear
        
        if let node = SKEmitterNode(fileNamed: emitterFileNamed){
            addChild(node)
            
            node .particlePositionRange.dx = UIScreen.main.bounds.width
        }
    }
    
}

class Cloudy: Condition{
    init(){
        super.init(emitterFileNamed: "Cloudy.sks")
    }
    @MainActor required init?(coder adecoder: NSCoder){
        fatalError("nint")
    }
}

class Sunny: Condition{
    init(){
        super.init(emitterFileNamed: "Sunny.sks")
    }
    @MainActor required init?(coder adecoder: NSCoder){
        fatalError("init has not been implemented")
    }
}

class RainFall: Condition {
    
    init(){
        super.init(emitterFileNamed: "RainFall.sks")
    }
    
    @MainActor required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SnowFall: Condition{
    
    init(){
        super.init(emitterFileNamed: "SnowFall.sks")
    }
    
    @MainActor required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

