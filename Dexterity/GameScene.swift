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
    
    var numberOfButtons = 4
    var buttons: [Button] = []
    var desiredButtonPressOrder: [Int] = []
    var buttonPressOrder: [Int] = []
    var pressNumber = 0 {
        didSet {
            if pressNumber == 8 {
                checkOrder()
                pressNumber = 0
                buttonPressOrder = []
            }
        }
    }
    let successLabel = SKLabelNode(fontNamed: "Chalkduster")
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.white
        setupButtons(total: numberOfButtons)
        setupButtonPressOrder(total: numberOfButtons)
        setupSuccessLabel()
    }
    
    func setupButtons(total: Int) {
        for number in 0..<total {
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
    
    func setupButtonPressOrder(total: Int) {
        for number in 0..<total {
            desiredButtonPressOrder.append(number)
        }
        for number in (0..<total).reversed() {
            desiredButtonPressOrder.append(number)
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
}

extension GameScene: ButtonDelegate {
    
    func didTouchButton(number: Int) {
        if number == 0 {
            pressNumber = 0
            buttonPressOrder = []
            successLabel.isHidden = true
        }
        addNumberToOrder(number: number)
    }
    
    func didReleaseButton(number: Int) {
        addNumberToOrder(number: number)
    }
    
    func addNumberToOrder(number: Int) {
        buttonPressOrder.append(number)
        pressNumber += 1
    }
    
    func checkOrder() {
        print(buttonPressOrder)
        if (buttonPressOrder == desiredButtonPressOrder) {
            successLabel.isHidden = false
        }
    }
}
