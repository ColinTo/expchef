//
//  MapSwiftUIView.swift
//  expchef
//
//  Created by Colin To on 2022-04-20.
//

import SwiftUI
import MapKit

struct MapSwiftUIView: View {
    
    @ObservedObject private var mapAPI = MapAPI()
    // This is for the String Address
    @State private var text = ""
    
    var body: some View {
        VStack{
            TextField("Enter an address", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            Button("Find address"){
                mapAPI.getLocation(address: text, delta: 0.5)
            }
            
            if #available(iOS 14.0, *) {
                Map(coordinateRegion: $mapAPI.region, annotationItems: mapAPI.locations){
                    location in
                    MapMarker(coordinate: location.coordinate, tint: .blue)
                }
//                .ignoresSafeArea()
            } else {
            }
        }
        .frame(maxWidth: .infinity, maxHeight:400)
        // Change to Align to NavBar in Future
        .padding(EdgeInsets(top:10, leading:0, bottom:0, trailing: 0))
    }
}

struct MapSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        MapSwiftUIView()
    }
}
