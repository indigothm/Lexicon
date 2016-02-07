//
//  DetailViewController.swift
//  Lexicon
//
//  Created by Ilia Tikhomirov on 06/02/16.
//  Copyright © 2016 Ilia Tikhomirov. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var targetLabel: UILabel!
    
    @IBOutlet weak var pronounLabel: UILabel!
    
    @IBOutlet weak var transLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        targetLabel.text = Data.sharedInstance.Ctarget
        pronounLabel.text = Data.sharedInstance.Cpronoun
        transLabel.text = Data.sharedInstance.Ctrans
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backDidTouch(sender: AnyObject) {
        
        print("TOUCH!!")
        
        let navController = self.navigationController
        
        navController!.popViewControllerAnimated(true)
        
            
        
            
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
