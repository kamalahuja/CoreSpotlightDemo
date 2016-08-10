//
//  StateModelExtension.swift
//  CoreSpotlightSearchDemo
//
//  Created by Kamal Ahuja on 8/8/16.
//  Copyright © 2016 KamalAhuja. All rights reserved.
//

import Foundation
import CoreSpotlight
import MobileCoreServices

extension StateModel {
     static let CORE_SPOTLIGHT_IDENTIFIER : String = "com.Kamal.CoreSpotlightSearchDemo"
    
    public var userActivityInfo : [NSObject : AnyObject] {
        return ["id" : id];
    }
    
    public var userActivity : NSUserActivity {
        let activity = NSUserActivity(activityType: StateModel.CORE_SPOTLIGHT_IDENTIFIER)
        activity.title = stateName
        activity.userInfo = userActivityInfo
        activity.keywords = [capitalName, stateName]
        activity.contentAttributeSet = attributeSet
        return activity
    }
    public var attributeSet: CSSearchableItemAttributeSet {
        let attributeSet = CSSearchableItemAttributeSet(
            itemContentType: kUTTypeContact as String)
        attributeSet.title = stateName
        attributeSet.contentDescription = "\(stateName), \(capitalName)\n\(population)"
        
        attributeSet.keywords = [capitalName, stateName]
        
        return attributeSet
    }
    
    public static func destroyStateIndexing() {
        CSSearchableIndex
            .defaultSearchableIndex()
            .deleteAllSearchableItemsWithCompletionHandler { error in
                if let error = error {
                    print("Error deleting searching state items: \(error)")
                } else {
                    print("State indexing deleted.")
                }
        }
    }
}