//
//  PlacesViewController.swift
//  Lexicon
//
//  Created by Ilia Tikhomirov on 06/02/16.
//  Copyright © 2016 Ilia Tikhomirov. All rights reserved.
//

import UIKit
import Spring

class PlacesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    func loadFromNibNamed(nibNamed: String, bundle : NSBundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiateWithOwner(nil, options: nil)[0] as? UIView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        twitterAnimation ()
        
        let head = loadFromNibNamed("ParH")
        head?.frame = CGRectMake(0,0, self.view.frame.width, 273)
        let headerView: ParallaxHeaderView = ParallaxHeaderView.parallaxHeaderViewWithSubView(head) as! ParallaxHeaderView
        self.tableView.tableHeaderView = headerView
        
    }
    
    func twitterAnimation () {
        
        /*
        let imageView = UIImage(frame: self.view.frame, named: "logo")
        self.view.addSubview(imageView)
        */
        let lexS = SKSplashIcon(image: UIImage(named: "logo"), animationType: SKIconAnimationType.Bounce)
        let color = UIColor(red:0.04, green:0.11, blue:0.16, alpha:1.0)
        let splashView = SKSplashView(splashIcon: lexS, backgroundColor: color, animationType: SKSplashAnimationType.None)
        splashView.animationDuration = 0.7
        self.view.addSubview(splashView)
        splashView.startAnimation()
        
        
    }
    

    
    func  scrollViewDidScroll(scrollView: UIScrollView) {
        let header: ParallaxHeaderView = self.tableView.tableHeaderView as! ParallaxHeaderView
        header.layoutHeaderViewForScrollViewOffset(scrollView.contentOffset)
       
        self.tableView.tableHeaderView = header
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("pheader")
        
        cell?.frame = CGRectMake(0, 0, self.view.frame.width, 53)
                
        return cell

    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("phraseC", forIndexPath: indexPath) as! PhraseTableViewCell
        
        return cell
    }
    
     func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let cellA = cell as! PhraseTableViewCell
        
        cellA.transLabel.animation = "zoomIn"
        cellA.transLabel.duration = 0.5
        cellA.transLabel.animate()
        
        
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


