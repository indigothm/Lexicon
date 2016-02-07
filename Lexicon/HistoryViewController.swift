//
//  HistoryViewController.swift
//  Lexicon
//
//  Created by Ilia Tikhomirov on 06/02/16.
//  Copyright © 2016 Ilia Tikhomirov. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var history = [String: AnyObject]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        history = Data.sharedInstance.historyArray
        
        tableView.reloadData()
        
        
        print(Data.sharedInstance.historyArray)
        print(history)

        // Do any additional setup after loading the view.
        
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        print(history.count)
        return history.count
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("pheader") as! DateTableViewCell
        
        cell.frame = CGRectMake(0, 0, self.view.frame.width, 53)
        
        let keys = [String](history.keys)
        
        print(keys)
        
        cell.dateLabel.text = keys[section]
        
        return cell
        
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("phraseC", forIndexPath: indexPath) as! PhraseTableViewCell
        
        let keys = [String](history.keys)
        
        print("ДАННЫЕ")
        print(history[keys[indexPath.section]])
        
        cell.targetLabel.text = history[keys[indexPath.section]]?[indexPath.row]["Target"] as! String
        cell.proLabel.text = history[keys[indexPath.section]]?[indexPath.row]["Pronounce"] as! String
        cell.transLabel.text = history[keys[indexPath.section]]?[indexPath.row]["Translation"] as! String
        
        
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
