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
    let successLabel = SKLabelNode(fontNamed: "Chalkduster")
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.white
        setupButtons(total: 3)
        setupSuccessLabel()
    }
    
    func setupButtons(total: Int) {
        for number in 0...total {
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
    
    func setupSuccessLabel() {
        successLabel.text = "Success!"
        successLabel.fontSize = 65
        successLabel.fontColor = UIColor.green
        successLabel.position = CGPoint(x: size.width * 0.5, y: size.height * 0.75)
        successLabel.isHidden = true
        addChild(successLabel)
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
        let previousNumber = number - 1
        successLabel.isHidden = true
        if buttons[number].unlocked {
            if nextNumber < buttons.count && !buttons[nextNumber].pressed {
                buttons[nextNumber].unlocked = true
            } else if number == buttons.count - 1 {
                buttons[number].canBeReleased = true
            }
        }
        
        if previousNumber > -1 && buttons[previousNumber].canBeReleased {
            buttons[previousNumber].canBeReleased = false
        }
    }
    
    func didReleaseButton(number: Int) {
        successLabel.isHidden = true
        if buttons[number].unlocked {
            for i in number + 1 ..< buttons.count {
                buttons[i].unlocked = false
                buttons[i].canBeReleased = false
            }
        }
        
        if buttons[number].canBeReleased {
            buttons[number].canBeReleased = false
            let previousNumber = number - 1
            if previousNumber > -1 {
                buttons[previousNumber].canBeReleased = true
            }
            if number == 0 {
                successLabel.isHidden = false
            }
        }
    }
}
