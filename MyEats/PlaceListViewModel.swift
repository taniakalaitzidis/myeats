//
//  PlaceListViewModel.swift
//  MyEats
//
//  Created by Tania CATS on 7/25/23.
//

import Foundation
import Combine
import MapKit

class PlaceListViewModel: ObservableObject {
    private var locationManager: LocationManager
    var cancellable: AnyCancellable?
    @Published var currentLocation: CLLocationCoordinate2D?
    @Published var landmarks: [LandmarkViewModel] = []
    
    init() {
        locationManager = LocationManager()
        
       cancellable = locationManager.$location.sink { (location) in
           if let location = location {
               DispatchQueue.main.async {
                   self.currentLocation = location.coordinate
                   self.locationManager.stopUpdates()
               }
           }
        }
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdates()
    }
    
    func searchLandmarks(searchText: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            if let error = error {
                print(error)
            } else if let response = response {
                let mapItems = response.mapItems
                self.landmarks = mapItems.map {
                    return LandmarkViewModel(placemark: $0.placemark)
                }
            }
        }
    }
    
}
