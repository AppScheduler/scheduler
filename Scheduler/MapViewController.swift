//
//  MapViewController.swift
//  Scheduler
//
//  Created by Asad Rizvi on 11/19/21.
//

import UIKit
import Parse
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var events = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set initial location
        let location = CLLocation(latitude: 38.98, longitude: -76.94)
        mapView.centerToLocation(location)
        
        let coordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 38.98, longitude: -76.94), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        mapView.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: coordinateRegion), animated: true)
        //mapView.setCameraZoomRange(MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 200000), animated: true)
    }
    
    /*override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className:"Events")
        
        // Get author and comments objects
        query.includeKeys(["events"])
        
        // Get previous 20 posts
        query.limit = 20
        
        // Get stored posts list
        query.findObjectsInBackground { (events, error) in
            if events != nil {
                self.events = events!
            } else {
                print("Error: \(error?.localizedDescription)")
            }
        }
    }*/
    
    // Logout user and switch back to login screen
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOut()
        
        // Switch back to login screen
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(identifier: "LoginViewController")
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let
                delegate = windowScene.delegate as? SceneDelegate else { return }
        
        delegate.window?.rootViewController = loginViewController
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

private extension MKMapView {
    
  func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
    let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                              latitudinalMeters: regionRadius,
                                              longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}
