//
//  AppDelegate.swift
//  WebView
//
//  Created by Nate Armstrong on 6/15/14.
//  Copyright (c) 2014 Nate Armstrong. All rights reserved.
//

import UIKit

struct Tab {
  let navigation: Bool
  let url: NSString
  let index: NSNumber
  let title: NSString
  let icon: NSString

  init(fromDictionary dictionary: NSDictionary) {
    url = dictionary.objectForKey("url") as NSString
    navigation = dictionary.objectForKey("navigation") as Bool
    index = dictionary.objectForKey("index") as NSNumber
    title = dictionary.objectForKey("title") as NSString
    icon = dictionary.objectForKey("icon") as NSString
  }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
    let tabBarAppearance = UITabBar.appearance()
    tabBarAppearance.tintColor = UIColor(red: 255/255.0, green: 167/255.0, blue: 74/255.0, alpha: 1.0)
    tabBarAppearance.backgroundImage = UIImage(named: "tbbg.png")

    window = UIWindow(frame: UIScreen.mainScreen().bounds)
    let tabController = UITabBarController()
    var controllers: UINavigationController[] = Array()
    var tabs: Tab[] = Array()

    let url = NSBundle.mainBundle().URLForResource("Data", withExtension: "plist")
    let dataDictionary = NSDictionary(contentsOfURL: url)
    let tabDictionaries: NSArray = dataDictionary.objectForKey("tabs") as NSArray
    for tabDictionary: AnyObject in tabDictionaries {
      let tab = Tab(fromDictionary: tabDictionary as NSDictionary)
      tabs.append(tab)
    }

    for tab in tabs {
      let viewController = ViewController(url: tab.url)
      viewController.title = tab.title
      let navController = UINavigationController(rootViewController: viewController)
      controllers.append(navController)
    }
    tabController.viewControllers = controllers
    window!.rootViewController = tabController
    window!.makeKeyAndVisible()
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

}
