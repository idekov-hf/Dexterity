//
//  GameScene.swift
//  Dexterity
//
//  Created by Iavor Dekov on 11/7/16.
//  Copyright © 2016 Iavor Dekov. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var buttons: [Button] = []
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.white
        setupButtons()
    }
    
    func setupButtons() {
        for number in 0...3 {
            let button = Button(number: number)
            button.delegate = self
            button.position = CGPoint(x: size.width * 0.20 * CGFloat(number + 1), y: size.height * 0.5)
            if number == 0 {
                button.unlocked = true
            }
            buttons.append(button)
            addChild(button)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

extension GameScene: ButtonDelegate {
    func didTouchButton(number: Int) {
        let nextNumber = number + 1
        if buttons[number].unlocked {
            if nextNumber < buttons.count && !buttons[nextNumber].pressed {
                buttons[nextNumber].unlocked = true
            } else if number == buttons.count - 1 {
                print("Pressed buttons in correct sequence!")
            }
        }
    }
    
    func didReleaseButton(number: Int) {
        if buttons[number].unlocked {
            for i in number + 1 ..< buttons.count {
                if !buttons[i].unlocked {
                    break
                }
                buttons[i].unlocked = false
            }
        }
    }
}
