//
//  RootViewController.swift
//  CoreSpotlightSearchDemo
//
//  Created by Kamal Ahuja on 8/7/16.
//  Copyright © 2016 KamalAhuja. All rights reserved.
//

import UIKit
import CoreSpotlight


class RootViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
   
    var isRestoringToState : Bool = false
    var objectId : String?
    @IBOutlet weak var usStateSearchBar: UISearchBar!
    @IBOutlet weak var usStateListTableView: UITableView!
    var searchBarTimer : NSTimer?
    var stateTableDataSource : [StateModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpStateData()
        usStateListTableView.dataSource = self
        usStateListTableView.delegate  = self
        usStateSearchBar.delegate = self
        self.restoreToSearchResult()
    }
    
    func restoreToSearchResult()  {
        if isRestoringToState == true && self.objectId != nil {
            self.launchStateDetailViewController(Int(self.objectId!)!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stateTableDataSource.count
    }
    
    func closeStateDetails() {
        
        self.dismissViewControllerAnimated(true, completion: nil);
        
    }
    func launchStateDetailViewController(objectId : NSInteger) {
        self.setUpStateData()
        let stateDetailController : StateDetailViewController = StateDetailViewController()
        let stateModel : StateModel = stateTableDataSource[objectId]
        stateDetailController.stateModel = stateModel
        let stateNavigationModel : UINavigationController = UINavigationController(rootViewController: stateDetailController)
        let closeButton = UIBarButtonItem(title: "Close Details", style: UIBarButtonItemStyle.Done, target: self, action: #selector(self.closeStateDetails))
        stateDetailController.navigationItem.rightBarButtonItem = closeButton
        
        self.presentViewController(stateNavigationModel, animated: true, completion: nil)
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
     self.launchStateDetailViewController(indexPath.row)
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var stateTableViewCell =   tableView.dequeueReusableCellWithIdentifier("stateTableCell")
        if  stateTableViewCell == nil {
            stateTableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "stateTableCell")
        }
        stateTableViewCell?.textLabel?.text = stateTableDataSource[indexPath.row].stateName
        return stateTableViewCell!
    }
    func startSearching(timer : NSTimer) {
        if timer == searchBarTimer {
             self.setUpStateData()
            let searchString : String = usStateSearchBar.text!
            if "" != searchString {
                stateTableDataSource = stateTableDataSource.filter({
                    state in
                    return state.stateName.lowercaseString.containsString(searchString.lowercaseString)
                })
            }
            
            usStateListTableView.reloadData()
            print(usStateSearchBar.text)
            searchBarTimer = nil
        }
        
    }
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String)  {
        if  searchBarTimer  != nil {
           searchBarTimer?.invalidate()
            searchBarTimer = nil
        }
        searchBarTimer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(RootViewController.startSearching(_:)), userInfo: searchText, repeats: false)
        print(searchBar.text)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    func setUpStateData() {
        let njStateObject : StateModel = StateModel(stateName: "New Jersey", capitalName: "Trenton", population: "8,958,013", id: "0");
        let caSTateObject : StateModel = StateModel(stateName: "California", capitalName: "Sacramento", population: "39,144,818", id: "1")
        let texasModel : StateModel = StateModel(stateName: "Texas", capitalName: "Austin", population: "27,469,114", id: "2")
        let floridaState : StateModel = StateModel(stateName: "Florida", capitalName: "Tallahassee", population: "20,271,272", id: "3")
        let newYork : StateModel = StateModel(stateName: "New York", capitalName: "Albany", population: "19,795,791", id: "4")
        let pensylvenilaState : StateModel = StateModel(stateName: "Pennsylvania", capitalName: "HARRISHBURG", population: "12,802,503", id: "5")
        let ohioState : StateModel = StateModel(stateName: "Ohio", capitalName: "Columbus", population: "11,613,423", id: "6")
        let georgiaState : StateModel = StateModel(stateName: "Georgia", capitalName: "ATLANTA", population: "10,214,860", id: "7")
        let northCarolina : StateModel = StateModel(stateName: "North Carlolina", capitalName: "Raleigh", population: "10,042,802", id: "8")
        let michigan : StateModel = StateModel(stateName: "Michigan", capitalName: "Lansing", population: "9,922,576", id: "9")
        let virginia : StateModel = StateModel(stateName: "Virginia", capitalName: "Richmond", population: "8,382,993", id: "10")
        self.stateTableDataSource = [njStateObject, caSTateObject, texasModel, floridaState, newYork, pensylvenilaState, ohioState, georgiaState, northCarolina, michigan, virginia];
    }
}
