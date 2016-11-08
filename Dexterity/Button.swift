//
//  Button.swift
//  Dexterity
//
//  Created by Iavor Dekov on 11/7/16.
//  Copyright © 2016 Iavor Dekov. All rights reserved.
//

import Foundation
import SpriteKit

class Button: SKSpriteNode {
    
    weak var delegate: ButtonDelegate?
    
    var number: Int = 0
    var unlocked = false {
        didSet {
            color = unlocked ? UIColor.green : UIColor.red
        }
    }
    var pressed = false
    
    init(number: Int) {
        self.number = number
        super.init(texture: nil, color: UIColor.red, size: CGSize.init(width: CGFloat(50), height: CGFloat(50)))
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        pressed = true
        delegate?.didTouchButton(number: number)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        pressed = false
        delegate?.didReleaseButton(number: number)
    }
}

protocol ButtonDelegate: class {
    func didTouchButton(number withNumber: Int)
    func didReleaseButton(number withNumber: Int)
}
