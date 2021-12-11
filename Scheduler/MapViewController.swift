//
//  MapViewController.swift
//  Scheduler
//
//  Created by Asad Rizvi on 11/19/21.
//

import UIKit
import Parse
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var events = [PFObject]()
    
    private var locationManager: CLLocationManager!
    private var currentLocation: CLLocation?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup map current location
        mapView.delegate = self
        mapView.showsUserLocation = true
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        // Ask user location permission
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        // Set initial location
        let lat = (locationManager.location?.coordinate.latitude)!
        let lon = (locationManager.location?.coordinate.longitude)!
        
        let coordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: lon), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        mapView.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: coordinateRegion), animated: true)
        
        // Gets events from database
        let query = PFQuery(className:"Events")
        query.includeKeys(["user", "name", "address", "time", "latitude", "longitude"])
        query.findObjectsInBackground { (events, error) in
            if events != nil {
                self.events = events!
            } else {
                print("Error: \(error)")
            }
        }
        
        // Adds annotations to map
        for event in events {
            let latitude = (event["latitude"] as? Double)!
            let longitude = (event["longitude"] as? Double)!
            
            let eventAnnotation = Event(name: event["name"] as? String,
                              address: event["address"] as? String,
                              coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))

            mapView.addAnnotation(eventAnnotation)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Gets events from database
        let query = PFQuery(className:"Events")
        query.includeKeys(["user", "name", "address", "time", "latitude", "longitude"])
        query.findObjectsInBackground { (events, error) in
            if events != nil {
                self.events = events!
            } else {
                print("Error: \(error)")
            }
        }
        
        // Adds annotations to map
        for event in events {
            let latitude = (event["latitude"] as? Double)!
            let longitude = (event["longitude"] as? Double)!
            
            let eventAnnotation = Event(name: event["name"] as? String,
                              address: event["address"] as? String,
                              coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
            
            mapView.addAnnotation(eventAnnotation)
        }
    }
    
    // Maintain user location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      defer { currentLocation = locations.last }

      if currentLocation == nil {
          if let userLocation = locations.last {
              let viewRegion = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
              mapView.setRegion(viewRegion, animated: false)
          }
      }
  }
    
    /*override func loadView() {
        super.loadView()
        
        // Gets events from database
        let query = PFQuery(className:"Events")
        query.includeKeys(["user", "name", "address", "time", "latitude", "longitude"])
        query.findObjectsInBackground { (events, error) in
            if events != nil {
                self.events = events!
            } else {
                print("Error: \(error)")
            }
        }
        
        // Adds annotations to map
        for event in events {
            let latitude = (event["latitude"] as? Double)!
            let longitude = (event["longitude"] as? Double)!
            
            let event = Event(name: event["name"] as? String,
                              address: event["address"] as? String,
                              coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
            
            mapView.addAnnotation(event)
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
