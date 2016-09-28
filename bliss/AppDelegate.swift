//
//  AppDelegate.swift
//  bliss
//
//  Created by Amadeu Andrade on 26/09/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // Override point for customization after application launch.
    return true
  }

  func applicationWillResignActive(application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }
  
  func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
    
    let urlComponents = NSURLComponents(URL: url, resolvingAgainstBaseURL: false)
    
    if url.scheme == "blissrecruitment", let urlHost = url.host where urlHost == "questions", let components = urlComponents, let items = components.queryItems {
      if let name = items.first?.name where name == "question_filter", let value = items.first?.value {
        // Value to search box @ QuestionsVC
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController:UINavigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        let questionsVC = storyboard.instantiateViewControllerWithIdentifier("QuestionsVC") as! QuestionsVC
        navigationController.viewControllers = [questionsVC]
        questionsVC.textToSearch = value
        self.window?.rootViewController = navigationController
        return true
      } else if let name = items.first?.name where name == "question_id", let value = items.first?.value {
        // Value with the question ID to DetailVC
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController:UINavigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        let questionsVC = storyboard.instantiateViewControllerWithIdentifier("QuestionsVC") as! QuestionsVC
        let detailsVC = storyboard.instantiateViewControllerWithIdentifier("DetailsVC") as! DetailsVC
        navigationController.viewControllers = [questionsVC, detailsVC]
        detailsVC.questionID = Int(value)
        self.window?.rootViewController = navigationController
        return true
      }
    }
    
    return false
  }


}

