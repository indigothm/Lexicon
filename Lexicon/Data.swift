//
//  Data.swift
//  Lexicon
//
//  Created by Ilia Tikhomirov on 06/02/16.
//  Copyright © 2016 Ilia Tikhomirov. All rights reserved.
//

import Foundation

class Data {
        
        static let sharedInstance = Data()
        
        var historyArray = [String: AnyObject]()
        
        var Ctarget: String = ""
        var Cpronoun: String = ""
        var Ctrans: String = ""
        
    }
    
