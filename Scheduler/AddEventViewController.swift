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
    
    var currentEvent: PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // Add an event
    @IBAction func onConfirm(_ sender: Any) {
        var latitude: CLLocationDegrees = 38.98
        var longitude: CLLocationDegrees = -76.94
        
        // Convert String address to coordingates
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address.text!) {
            placemarks, error in
            let placemark = placemarks?.first
            latitude = (placemark?.location?.coordinate.latitude)!
            longitude = (placemark?.location?.coordinate.longitude)!
            
            // Launch Google Maps
            self.openGoogleMapDirections(latitude: latitude, longitude: longitude);
        }
        
        // Store event info
        let event = PFObject(className: "Events")
        event["name"] = self.eventName.text!
        event["address"] = self.address.text!
        event["time"] = self.time.text!
        event["latitude"] = latitude
        event["longitude"] = longitude
        event["user"] = PFUser.current()!
        
        // Add event to user data
        currentEvent.add(event, forKey: "events")
        
        // Save event
        currentEvent.saveInBackground { (success, error) in
            if success {
                print("User data saved!")
            } else {
                print("Error saving user data: \(error?.localizedDescription)")
            }
        }
    }
    
    // Cancel adding an event
    @IBAction func onCancel(_ sender: Any) {
        // Segue back to mpa view
    }
    
    // Open Google Maps to give directions to event location
    func openGoogleMapDirections(latitude:Double, longitude: Double) {
            let url = URL(string: "comgooglemaps://?saddr=&daddr=\(latitude),\(longitude)&directionsmode=driving")

            // Launch Google Maps iOS app
            if UIApplication.shared.canOpenURL(url!) {
                UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            }
            // Otherwise launch Google Maps web app if iOS app not available
            else{
                let urlBrowser = URL(string: "https://www.google.co.in/maps/dir/??saddr=&daddr=\(latitude),\(longitude)&directionsmode=driving")
                UIApplication.shared.open(urlBrowser!, options: [:], completionHandler: nil)
            }
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
