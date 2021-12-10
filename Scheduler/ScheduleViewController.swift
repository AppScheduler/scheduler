//
//  ScheduleViewController.swift
//  Scheduler
//
//  Created by Asad Rizvi on 11/19/21.
//

import UIKit
import FSCalendar

class ScheduleViewController: UIViewController, FSCalendarDelegate {

    @IBOutlet var calendar: FSCalendar!
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.delegate = self
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE MM-dd-YYYY"
        let dateString = formatter.string(from: date)
        let myAlert = UIAlertController(title: "Event ", message: dateString, preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Dismiss", style: .cancel)
        myAlert.addAction(dismiss)
        present(myAlert, animated: true, completion: nil)
        print("\(dateString)");
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
