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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
