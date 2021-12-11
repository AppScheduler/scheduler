//
//  EventAnnotation.swift
//  Scheduler
//
//  Created by Asad Rizvi on 12/10/21.
//

import Foundation
import MapKit

class Event: NSObject, MKAnnotation {
  let name: String?
  let address: String?
  let coordinate: CLLocationCoordinate2D

  init(name: String?, address: String?, coordinate: CLLocationCoordinate2D) {
    self.name = name
    self.address = address
    self.coordinate = coordinate

    super.init()
  }

  var subtitle: String? {
    return name
  }
}
