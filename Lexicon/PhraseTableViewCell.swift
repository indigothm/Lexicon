//
//  PhraseTableViewCell.swift
//  Lexicon
//
//  Created by Ilia Tikhomirov on 06/02/16.
//  Copyright © 2016 Ilia Tikhomirov. All rights reserved.
//

import UIKit
import Spring

class PhraseTableViewCell: UITableViewCell {

    @IBOutlet weak var targetLabel: SpringLabel!

    @IBOutlet weak var proLabel: SpringLabel!
    
    @IBOutlet weak var transLabel: SpringLabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width
        
        self.frame = CGRectMake(0,0, screenWidth, 90)

        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
