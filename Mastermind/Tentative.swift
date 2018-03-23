//
//  Tentative.swift
//  Mastermind
//
//  Created by Collongues Clément on 19/03/2018.
//  Copyright © 2018 Collongues Clément. All rights reserved.
//

import UIKit

class Tentative {
    //MARK: Properties
    var code: Array<Int>
    var verification : Array<Int> = [0,0,0,0]
    
    //MARK: Initialization
    init?(code: Array<Int>, verification: Array<Int>) {
        // Initialization should fail if there is no name or if the rating is negative.
        if code.isEmpty || code.count < 4 || code.count > 4 {
            return nil
        }
        
        // The code must not be empty
        guard !code.isEmpty else {
            return nil
        }
        
        // The code must be 4 characters
        guard code.count == 4 else {
            return nil
        }
        
        // Initialize stored properties.
        self.code = code
        self.verification = verification
    }
    
    //MARK: Decode
    func getVerifCode(code: Array<Int>, usercode: Array<Int>) -> Array<Int>{
        
        let code = code
        let tried = usercode
        
        var codeA = [0,0,0,0]
        var tryA = [0,0,0,0]
        var bp = 0
        var mp = 0
        
        // Check tous les correct
        print("Secrect code : \(code)")
        print("Utilisateur code : \(tried)")

        for index in 0..<code.count {
            if (tried[index] == code[index]) {
                codeA[index] = 1
                tryA[index] = 1
                bp += 1
            }
        }
        
        // Check tous + 1
        for index in 0..<code.count {
            for index2 in 0..<code.count {
                if (tried[index] == code[index2]) {
                    if !(codeA[index2] == 1 || tryA[index] == 1) {
                        codeA[index2] = 1
                        tryA[index] = 1
                        mp += 1
                    }
                }
            }
        }
        print("Bien placé = \(bp)")
        print("Mal placé = \(mp)")
        if bp == 4 {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "isWon"), object: true)
        }
        // red = 2 / gris = 0 / white = 1
        var verifcode = [Int]()
        for _ in 0..<bp {
            verifcode.append(2)
        }
        for _ in 0..<mp {
            verifcode.append(0)
        }
        for _ in (0..<(4 - verifcode.count)) {
            verifcode.append(1)
        }
        print("verifcode = \(verifcode)")
        return verifcode
    }
}
