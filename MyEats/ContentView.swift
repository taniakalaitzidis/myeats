//
//  ContentView.swift
//  MyEats
//
//  Created by Tania CATS on 7/18/23.
//

import SwiftUI
import MapKit

enum DisplayType {
    case map
    case list
}

struct ContentView: View {
    @StateObject private var placeListViewModel = PlaceListViewModel()
    @State private var searchText = ""
    @State private var userTrackingMode: MapUserTrackingMode = .follow
    @State private var displayType: DisplayType = .map
    @State private var isDragged: Bool = false
    
    private func getRegion() -> Binding<MKCoordinateRegion> {
        
        guard let coordinate = placeListViewModel.currentLocation else {
            return .constant(MKCoordinateRegion.defaultRegion)
        }
        
        return .constant(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))
        
    }
    
    var body: some View {
        
        VStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 200)
                .padding()
            
            ButtonCategoryView { (category) in
                placeListViewModel.searchLandmarks(searchText: category)
            }.padding(.bottom, 15)
            

            NavigationStack {
//                ButtonCategoryView { (category) in
//                    placeListViewModel.searchLandmarks(searchText: category)
//                }
                TextField("Search", text: $searchText, onEditingChanged: { _ in
                    
                }, onCommit: {
                    // get all landmarks
                    placeListViewModel.searchLandmarks(searchText: searchText)
                }).textFieldStyle(RoundedBorderTextFieldStyle()).padding(15)
                
//                ButtonCategoryView { (category) in
//                    placeListViewModel.searchLandmarks(searchText: category)
//                }
                Picker("Select", selection: $displayType) {
                    Text("Map").tag(DisplayType.map)
                    Text("List").tag(DisplayType.list)
                }.pickerStyle(SegmentedPickerStyle())
                
            if displayType == .map {
                Map(coordinateRegion: getRegion(), interactionModes: .all, showsUserLocation: true, userTrackingMode: $userTrackingMode, annotationItems: placeListViewModel.landmarks) { landmark in
                    MapMarker(coordinate: landmark.coordinate)
                    
                }.ignoresSafeArea()
                .gesture(DragGesture()
                    .onChanged({ (value) in
                        isDragged = true
                    })
                ).overlay(isDragged ? AnyView(RecenterButton {
                    placeListViewModel.startUpdatingLocation()
                    isDragged = false
                        
                }.padding()): AnyView(EmptyView()), alignment: .bottom)
                    
            } else if displayType == .list {
                LandmarkListView(landmarks: placeListViewModel.landmarks)
            }
            }
            

            
        }

        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
