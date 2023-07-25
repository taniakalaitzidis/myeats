//
//  RecenterButton.swift
//  MyEats
//
//  Created by Tania CATS on 7/25/23.
//

import SwiftUI

struct RecenterButton: View {
    
    let onTapped: () -> ()
    
    var body: some View {
        Button(action: onTapped, label: {
            Label("Re-center", systemImage: "triangle")
        
        }).padding(10)
            .foregroundColor(.white)
            .background(Color(.systemBlue))
            .clipShape(RoundedRectangle(cornerRadius: 16.0, style: .continuous))
    }
}

struct RecenterButton_Previews: PreviewProvider {
    static var previews: some View {
        RecenterButton(onTapped: {})
    }
}
