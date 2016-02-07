//
//  HeaderView.swift
//  Lexicon
//
//  Created by Ilia Tikhomirov on 06/02/16.
//  Copyright © 2016 Ilia Tikhomirov. All rights reserved.
//

import UIKit
import Spring

class HeaderView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var imageView: SpringImageView!
    @IBOutlet weak var targetPlace: UILabel!
    @IBOutlet weak var prounPlace: UILabel!
    
    
}
