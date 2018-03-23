//
//  StartViewController.swift
//  Mastermind
//
//  Created by Collongues Clément on 20/03/2018.
//  Copyright © 2018 Collongues Clément. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    @IBAction func createGame(_ sender: UIButton) {
        let difficulty = 4 // medium difficulty
        var possibleValues = [Int]()
        var secretCode = [Int]()
        
        for i in 0..<difficulty+1 {
            possibleValues.append(i)
        }
        for _ in 0..<difficulty {
            let randomIndex = Int(arc4random_uniform(UInt32(possibleValues.count)))
            let randomFromList = possibleValues[randomIndex]
            secretCode.append(randomFromList)
        }
        print(secretCode)
        UserDefaults.standard.set(secretCode, forKey: "secretCode")
        
    }
    

}
