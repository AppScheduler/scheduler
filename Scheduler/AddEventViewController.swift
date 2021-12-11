//
//  AddEventViewController.swift
//  Scheduler
//
//  Created by Frank Choukouali on 12/4/21.
//

import UIKit
import Parse
import CoreLocation

class AddEventViewController: UIViewController {
    
    @IBOutlet weak var eventName: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var time: UITextField!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // Add an event
    @IBAction func onConfirm(_ sender: Any) {
        // Convert String address to coordingates
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address.text!) {
            placemarks, error in
            let placemark = placemarks?.first
            let latitude = (placemark?.location?.coordinate.latitude)!
            let longitude = (placemark?.location?.coordinate.longitude)!
            
            print("latitude: \(latitude)")
            print("longitude: \(longitude)")
            
            // Store event info
            let event = PFObject(className: "Events")
            event["name"] = self.eventName.text!
            event["address"] = self.address.text!
            event["time"] = self.time.text!
            event["latitude"] = latitude
            event["longitude"] = longitude
            event["user"] = PFUser.current()!
            
            // Save event to user data
            event.saveInBackground { (success, error) in
                if success {
                    print("User data saved!")
                } else {
                    print("Error saving user data: \(error?.localizedDescription)")
                }
            }
            
        }
        
    }
    
    // Cancel adding an event
    @IBAction func onCancel(_ sender: Any) {
        eventName.text! = ""
        address.text! = ""
        time.text! = ""
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
