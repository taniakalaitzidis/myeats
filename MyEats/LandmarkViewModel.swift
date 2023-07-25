//
//  LandmarkViewModel.swift
//  MyEats
//
//  Created by Tania CATS on 7/25/23.
//


import Foundation
import MapKit

struct LandmarkViewModel: Identifiable {
    let placemark: MKPlacemark
    
    let id = UUID()
    var name: String {
        placemark.name ?? ""
    }
    
    var title: String {
        placemark.title ?? ""
    }
    
    var coordinate: CLLocationCoordinate2D {
        placemark.coordinate
    }
}

