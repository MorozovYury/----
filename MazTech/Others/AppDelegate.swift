//
//  AppDelegate.swift
//  MazTech
//
//  Created by Yury Morozov on 22.08.2018.
//  Copyright © 2018 Yury Morozov. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        let scheduleVC = EventScheduleViewController()
        let chatVC = ListOfChatsTableViewController()
        let settVC = SettingsViewController()
        let contactVC = OrganizorsContactsViewController()
        
        //MARK: - create nav controll
        let firstNavContr = UINavigationController(rootViewController: scheduleVC)
        let secondNavContr = UINavigationController(rootViewController: chatVC)
        let thrirdNavContr = UINavigationController(rootViewController: settVC)
        let forthNavContr = UINavigationController(rootViewController: contactVC)
        
        // MARK: - create tabBar controll
        let tabBarVC = UITabBarController()
        tabBarVC.setViewControllers([firstNavContr, secondNavContr,forthNavContr, thrirdNavContr], animated: true)
        tabBarVC.tabBar.backgroundColor = UIColor.black
        tabBarVC.tabBar.barStyle = .black
        tabBarVC.tabBar.tintColor = .white
        scheduleVC.tabBarItem = UITabBarItem(title: "Расписание", image: UIImage(named: "icon-schedule"), tag: 0)
        chatVC.tabBarItem = UITabBarItem(title: "Чат", image: UIImage(named: "icon-chat"), tag: 1)
        contactVC.tabBarItem = UITabBarItem(title: "Организаторы", image: UIImage(named: "icon-contacts"), tag: 2)
        settVC.tabBarItem = UITabBarItem(title: "Настройки", image: UIImage(named: "icon-settings"), tag: 3)
        
        tabBarVC.selectedViewController = secondNavContr
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = tabBarVC
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

