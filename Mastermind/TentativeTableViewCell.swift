//
//  TentativeTableViewCell.swift
//  Mastermind
//
//  Created by Collongues Clément on 20/03/2018.
//  Copyright © 2018 Collongues Clément. All rights reserved.
//

import UIKit

class TentativeTableViewCell: UITableViewCell {
//MARK: Properties
    
    @IBOutlet weak var SelectControl: SelectControl!
    
    @IBOutlet weak var DecoderControl: DecoderControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
