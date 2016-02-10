//
//  PlacesViewController.swift
//  Lexicon
//
//  Created by Ilia Tikhomirov on 06/02/16.
//  Copyright © 2016 Ilia Tikhomirov. All rights reserved.
//

import UIKit
import Spring
import Firebase
import CoreLocation
import SwiftSpinner

class PlacesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var prounLabel: UILabel!
    
    
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
    

    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorView.hidden = true

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.translatesAutoresizingMaskIntoConstraints = true
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()


        
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        formatter.dateFormat = "MMMM, dd"
        
        let dateString = formatter.stringFromDate(NSDate())
        
        Data.sharedInstance.historyArray[dateString] =  dictionary
        
        Data.sharedInstance.firebaseD.setValue(Data.sharedInstance.historyArray)
        
        print(Data.sharedInstance.historyArray)
        
        twitterAnimation ()
    }
    
    @IBOutlet weak var errorView: UIView!
    
    @IBAction func refreshIDidTouch(sender: AnyObject) {
        
        locationManager.requestLocation()
        
    }
    

    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            
            print("Current location: \(location)")
            
            SwiftSpinner.show("Checking your location...")
            Networking.sharedInstance.getVenueTypeForLocation(location, completionHandler: {
            value in
                
                if value == "Error" {
                    
                    self.tableView.hidden = true
                    self.errorView.hidden = false
                    
                }
                
                print("Place!!!")
                print(value)
                self.placeLabel.text = value
                SwiftSpinner.hide()
                
            })
        } else {
            // ...
        }
    }
    

    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error finding location: \(error.localizedDescription)")
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
     
     //  let view = self.tableView.tableHeaderView as! HeaderView
      // view.placeLabel.text = "IT WAS SCROLLED!"
        
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


