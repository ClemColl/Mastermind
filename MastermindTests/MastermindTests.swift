//
//  MastermindTests.swift
//  MastermindTests
//
//  Created by Collongues Clément on 19/03/2018.
//  Copyright © 2018 Collongues Clément. All rights reserved.
//

import XCTest
@testable import Mastermind

class MastermindTests: XCTestCase {
    
//MARK: Tentative Class Tests
    
    
    // Confirm that the Tentative initializer returns a Tentative object when passed valid parameters.
    func testTentativeInitializationSucceeds() {
        
        // No verification
        let noVerification = Tentative.init(code: [1,2,4,2], verification: [])
        XCTAssertNotNil(noVerification)
        
        // Normal Tentative
        let allData = Tentative.init(code: [1,2,4,2], verification: [1,0,1,0])
        XCTAssertNotNil(allData)
    }
    

    
    // Confirm that the Tentative initialier returns nil when passed an empty code or too short code.
    func testTentativeInitializationFails() {
        
        // No code
        let noCode = Tentative.init(code: [], verification: [])
        XCTAssertNil(noCode)
        
        // Only 3 values in code
        let threeValues = Tentative.init(code: [1,2,4], verification: [1,0,1])
        XCTAssertNil(threeValues)
        
        // 5 values in code
        let fiveValues = Tentative.init(code: [1,2,4,2,2], verification: [1,0,1,0,1])
        XCTAssertNil(fiveValues)
    }
    

    
}
