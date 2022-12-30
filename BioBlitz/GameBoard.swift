//
//  GameBoard.swift
//  BioBlitz
//
//  Created by Mihai Cerneanu on 30.12.2022.
//

import SwiftUI

class GameBoard: ObservableObject {
    let rowCount = 11
    let columnCount = 22
    
    @Published var grid = [[Bacteria]]()
    
    init() {
        reset()
    }
    
    func reset() {
        grid.removeAll()
        
        for row in 0..<rowCount {
            var newRow = [Bacteria]()
            
            for  col in 0..<columnCount {
                let bacteria = Bacteria(row: row, col: col)
                newRow.append(bacteria)
            }
        }
    }
}
