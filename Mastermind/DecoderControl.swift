//
//  DecoderControl.swift
//  Mastermind
//
//  Created by Collongues Clément on 20/03/2018.
//  Copyright © 2018 Collongues Clément. All rights reserved.
//

import UIKit

@IBDesignable class DecoderControl: UIStackView {

    //MARK: Properties
    private var pionButtons = [UIButton]()
    var decoded : Array<Int>?
    
    var buttonSize: CGSize = CGSize(width: 20.0, height: 20.0)
    let secretCode = UserDefaults.standard.string(forKey: "secretCode")
    var pionCount: Int = 4 {
        didSet {
            setupButtons(decoded: nil)
        }
    }
    
    
    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons(decoded: nil)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons(decoded: nil)
    }
    
    func changePionColor(button: UIButton) {
        
        // Init Button Images
        let bundle = Bundle(for: type(of: self))
        let value = Int(button.currentTitle!)!
        //0 = none 1 = white 2 = red
        switch (value) {
        case 1:
            let whitePion = UIImage(named: "white", in: bundle, compatibleWith: self.traitCollection)
            button.setImage(whitePion, for: .normal)
            button.setTitle(String(value), for: .normal)
        case 2:
            let redPion = UIImage(named:"red", in: bundle, compatibleWith: self.traitCollection)
            button.setImage(redPion, for: .normal)
            button.setTitle(String(value), for: .normal)
        default:
            let defaultPion = UIImage(named:"empty", in: bundle, compatibleWith: self.traitCollection)
            button.setImage(defaultPion, for: .normal)
            button.setTitle(String(value), for: .normal)
        }
    }
    
    //MARK: Private Methods
    func setupButtons(decoded: [Int]?) {
        if decoded?.isEmpty == nil {
        for _ in 0..<pionCount {
            
            // Create the button
            let button = UIButton()
            
            // Load Button Image
            let bundle = Bundle(for: type(of: self))
            let defaultPion = UIImage(named:"empty", in: bundle, compatibleWith: self.traitCollection)
            
            // Set the button images
            button.setImage(defaultPion, for: .normal)
            
            // Set tag
            button.setTitle("0", for: .normal)
            
            // Add constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: buttonSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: buttonSize.width).isActive = true
            
            // Add the button to the stack
            addArrangedSubview(button)
            
            // Add the new button to the rating button array
            pionButtons.append(button)
        }
        } else {
            for button in pionButtons {
                removeArrangedSubview(button)
                button.removeFromSuperview()
            }
            
            pionButtons.removeAll()
            
            for x in 0..<pionCount {
                // Create the button
                let button = UIButton()
                button.setTitle(String(decoded![x]), for: .normal)
                
                changePionColor(button: button)
                
                // Add constraints
                button.translatesAutoresizingMaskIntoConstraints = false
                button.heightAnchor.constraint(equalToConstant: buttonSize.height).isActive = true
                button.widthAnchor.constraint(equalToConstant: buttonSize.width).isActive = true
                
                // Add the button to the stack
                addArrangedSubview(button)
                
                // Add the new button to the rating button array
                pionButtons.append(button)
            }
        }
    }
}
