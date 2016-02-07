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
    
    let dictionary = [
        
        [
        
        "Target": "Как пройти в библиотеку?",
        "Pronounce": "kak proyti v biblioteku?",
        "Translation": "How can I get to the library"
        
        ],[
            
        "Target": "Идите прямо, потом направо",
        "Pronounce": "idite pryamo, potom napravo",
        "Translation": "go straight, then turn right"
        
        ],[
            
        "Target": "Здание будет слева от вас",
        "Pronounce": "zdanie budet sleva ot vas",
        "Translation": "the building will be to the left of you"
        
        ],[
        
        "Target": "Мне нравится этот университет",
        "Pronounce": "Mne nravitsya etot universitet",
        "Translation": "I like this university"
        
        ]
    
    
    
    ]

    @IBOutlet weak var tableView: UITableView!
    
    func loadFromNibNamed(nibNamed: String, bundle : NSBundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiateWithOwner(nil, options: nil)[0] as? UIView
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.translatesAutoresizingMaskIntoConstraints = true
        
        let head = loadFromNibNamed("ParH") as! HeaderView
        head.placeLabel.text = "@UNIVERSITY"
        head.targetPlace.text = "Университет"
        head.prounPlace.text = "[universitet]"
        head.imageView.image = UIImage(named: "UniversityCircle")
        
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width
        
        head.frame = CGRectMake(0,0, screenWidth, 273)
        let headerView: ParallaxHeaderView = ParallaxHeaderView.parallaxHeaderViewWithSubView(head) as! ParallaxHeaderView
        self.tableView.tableHeaderView = headerView
        tableView.reloadData()
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        formatter.dateFormat = "MMMM, dd"
        
        let dateString = formatter.stringFromDate(NSDate())
        
        Data.sharedInstance.historyArray[dateString] =  dictionary
        
        print(Data.sharedInstance.historyArray)
        
        twitterAnimation ()
    }
    
    func twitterAnimation () {
        
        let lexS = SKSplashIcon(image: UIImage(named: "logo"), animationType: SKIconAnimationType.Bounce)
        let color = UIColor(red:0.04, green:0.11, blue:0.16, alpha:1.0)
        let splashView = SKSplashView(splashIcon: lexS, backgroundColor: color, animationType: SKSplashAnimationType.None)
        splashView.animationDuration = 1.0
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
        return dictionary.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("phraseC", forIndexPath: indexPath) as! PhraseTableViewCell
        
        cell.targetLabel.text = dictionary[indexPath.row]["Target"]
        cell.proLabel.text = dictionary[indexPath.row]["Pronounce"]
        cell.transLabel.text = dictionary[indexPath.row]["Translation"]
        
        return cell
    }
    
     func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let cellA = cell as! PhraseTableViewCell
        
        cellA.transLabel.animation = "zoomIn"
        cellA.transLabel.duration = 0.5
        cellA.transLabel.animate()
        
        
    }
    
    
    var target: String = ""
    var pronoun: String = ""
    var trans: String = ""
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       
        
    
       target = dictionary[indexPath.row]["Target"]! as String
       pronoun = dictionary[indexPath.row]["Pronounce"]! as String
       trans = dictionary[indexPath.row]["Translation"]! as String


        
        performSegueWithIdentifier("open", sender: self)
    }

    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "open" {
            
            
            print(target)
            print(pronoun)
            print(trans)
            
           Data.sharedInstance.Ctarget = target
           Data.sharedInstance.Cpronoun = pronoun
           Data.sharedInstance.Ctrans = trans
        }
        
    }
    

}


