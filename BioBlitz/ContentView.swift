//
//  ContentView.swift
//  BioBlitz
//
//  Created by Mihai Cerneanu on 30.12.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HStack {
                Text ("GREEN: 0")
                
                Spacer()
                
                Text("BIOBLITZ")
                
                Text("RED: 0")
            }
            .font(.system(size: 36).weight(.black))
            
            VStack {
                ForEach(0..<11, id: \.self) { row in
                    HStack {
                        ForEach (0..<22, id: \.self) { col in
                            let bacteria = Bacteria(row: 0, col: 0)
                            
                            BacteriaView(bacteria: bacteria) {
                                
                            }
                        }
                    }
                }
            }
        }
        .padding()
        .fixedSize()
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
