//
//  AppDelegate.swift
//  DipSampleApp
//
//  Created by Olivier Halligon on 04/10/2015.
//  Copyright © 2015 AliSoftware. All rights reserved.
//

import UIKit
import Dip

enum PersonFormatterTags : String {
    case MassHeight
    case EyesHair
}

let dip: DependencyContainer = {
    let dip = DependencyContainer()
    dip.register(instance: SWAPIWebService() as WebServiceAPI)
    dip.register(instance: SWAPIPersonFactory() as PersonFactoryAPI)
    dip.register(instance: JSONSerializer() as SerializerAPI)
    dip.register(PersonFormatterTags.MassHeight.rawValue, instance: MassHeightFormatter() as PersonFormatterAPI)
    dip.register(PersonFormatterTags.EyesHair.rawValue, instance: EyesHairFormatter() as PersonFormatterAPI)
    return dip
}()


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        return true
    }
}
