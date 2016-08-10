//
//  StateDetailViewController.swift
//  CoreSpotlightSearchDemo
//
//  Created by Kamal Ahuja on 8/8/16.
//  Copyright © 2016 KamalAhuja. All rights reserved.
//

import UIKit

class StateDetailViewController: UIViewController {

    @IBOutlet weak var populationOutlet: UILabel!
    @IBOutlet weak var capitolNameOutlet: UILabel!
    @IBOutlet weak var stateNameOutlet: UILabel!
    
    var stateModel : StateModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    func populateDetails() {
        self.populationOutlet.text = self.stateModel?.population
        self.stateNameOutlet.text = self.stateModel?.stateName
        self.capitolNameOutlet.text = self.stateModel?.capitalName
    }
    
    func addUserActivity()  {
        let activiy = self.stateModel?.userActivity
        activiy?.eligibleForSearch = true
        self.userActivity = activiy
    }
    
    override func updateUserActivityState(activity: NSUserActivity) {
        activity.addUserInfoEntriesFromDictionary(
            (self.stateModel?.userActivityInfo)!)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.populateDetails()
        self.addUserActivity()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
