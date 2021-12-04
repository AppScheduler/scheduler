//
//  AddEventViewController.swift
//  Scheduler
//
//  Created by Frank Choukouali on 12/4/21.
//

import UIKit
import CoreLocation

class AddEventViewController: UIViewController {

    @IBOutlet weak var eventName: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var time: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func AddEvent(_ sender: Any) {
        let eventName = eventName.text!
        let address = address.text!
        let time = time.text!
        print("Lat: \(address), Lon: \(eventName)")
        var geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) {
            placemarks, error in
            let placemark = placemarks?.first
            let lat = placemark?.location?.coordinate.latitude
            let lon = placemark?.location?.coordinate.longitude
            print("Lat: \(lat), Lon: \(lon)")
            self.openGoogleMapDirections(latitude: lat!, longitude: lon!);
        }
    }
    func openGoogleMapDirections(latitude:Double, longitude: Double) {
           // let latitude = locationManager.location.latitude
           // let longitude = locationManager.location.longitude
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
