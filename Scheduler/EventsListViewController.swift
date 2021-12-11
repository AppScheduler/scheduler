//
//  EventsListViewController.swift
//  Scheduler
//
//  Created by Asad Rizvi on 12/10/21.
//

import UIKit
import Parse

class EventsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var events = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Gets events from database
        let query = PFQuery(className:"Events")
        query.includeKeys(["user", "name", "address", "time", "latitude", "longitude"])
        query.findObjectsInBackground { (events, error) in
            if events != nil {
                self.events = events!
                self.tableView.reloadData()
            } else {
                print("Error: \(error)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // All events for current post
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let event = events[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell") as! EventCell

        let user = event["user"] as! PFUser
        
        cell.nameLabel.text = event["name"] as? String
        cell.addressLabel.text = event["address"] as? String
        cell.timeLabel.text = event["time"] as? String
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let event = events[indexPath.row]
        
        let latitude = (event["latitude"] as? Double)!
        let longitude = (event["longitude"] as? Double)!
        
        // Launch Google Maps
        self.openGoogleMapDirections(latitude: latitude, longitude: longitude)
    }
    
    // Open Google Maps to give directions to event location
    func openGoogleMapDirections(latitude:Double, longitude: Double) {
        let url = URL(string: "comgooglemaps://?saddr=&daddr=\(latitude),\(longitude)&directionsmode=driving")

        // Launch Google Maps iOS app
        if UIApplication.shared.canOpenURL(url!) {
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        }
        // Otherwise launch Google Maps web app if iOS app not available
        else {
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
