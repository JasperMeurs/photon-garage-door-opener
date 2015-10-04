//
//  ViewController.swift
//  photon-garage-door-opener
//
//  Created by Jasper Meurs on 04/10/15.
//  Copyright © 2015 Jasper Meurs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var myPhoton : SparkDevice?
    let particleConfig = ParticleConfiguration()
    
    override func viewWillAppear(animated: Bool) {
        if SparkCloud.sharedInstance() == nil {
            print("Nog instance created yet, logging in...")
        SparkCloud.sharedInstance().loginWithUser(particleConfig.particleUsername, password: particleConfig.particlePassword) { (error:NSError!) -> Void in
            if let _=error {
                print("Wrong credentials!")
            } else {
                print("Logged in!")
            }
        }
        }
        
        if myPhoton == nil {
        SparkCloud.sharedInstance().getDevices { (sparkDevices:[AnyObject]!, error:NSError!) -> Void in
            if let _=error
            {
                print("Check your internet connectivity")
            }
            else
            {
                if let devices = sparkDevices as? [SparkDevice]
                {
                    for device in devices
                    {
                        if device.name == self.particleConfig.particleTargetDevice
                        {
                            self.myPhoton = device
                            print("Device found")
                        }
                        
                    }
                }
            }
        }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func operateGarageDoorButtonPressed() {
        if myPhoton != nil {
        let funcArgs = ["open"]
        myPhoton!.callFunction("operateDoor", withArguments: funcArgs) { (resultCode : NSNumber!, error : NSError!) -> Void in
            if (error == nil) {
                print("The door is opening")
            }
        }
        } else {
            print("Particle not yet loaded")
        }
    }
    


}

