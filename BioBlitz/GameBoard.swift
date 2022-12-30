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
                
                if row <= rowCount / 2 {
                    if row == 0 && col == 0 {
                        //make sure the player starts pointing away from anything
                        bacteria.direction = .north
                    } else if row == 0 && col == 1 {
                        //make sure nothing points to the player
                        bacteria.direction = .east
                    } else if row == 1 && col == 0 {
                        bacteria.direction = .south
                    } else {
                        //all other pieces are random
                        bacteria.direction = Bacteria.Direction.allCases.randomElement()!
                    }
                } else {
                    //mirror the counterpart
                    if let counterpart = getBacteria(atRow: rowCount - 1 - row, col: columnCount - 1 - col) {
                        bacteria.direction = counterpart.direction.opposite
                    }
                }
                
                newRow.append(bacteria)
            }
            
            grid.append(newRow)
        }
        
        grid[0][0].color = .green
        grid[rowCount - 1][columnCount - 1].color = .red
    }
    
    func getBacteria(atRow row: Int, col: Int) -> Bacteria? {
        guard row >= 0 else { return nil }
        guard row < grid.count else { return nil }
        guard col >= 0 else { return nil }
        guard col < grid[0].count else { return nil }
        return grid[row][col]
    }
    
    func infect(from: Bacteria) {
        objectWillChange.send()
        
        var bacteriaToInfect = [Bacteria?]()
        
        switch from.direction {
        case .north:
            bacteriaToInfect.append(getBacteria(atRow: from.row - 1, col: from.col))
        case .south:
            bacteriaToInfect.append(getBacteria(atRow: from.row + 1, col: from.col))
        case .east:
            bacteriaToInfect.append(getBacteria(atRow: from.row, col: from.col + 1))
        case .west:
            bacteriaToInfect.append(getBacteria(atRow: from.row, col: from.col - 1))
        }
        
        for case let bacteria? in bacteriaToInfect {
            if bacteria.color != from.color {
                bacteria.color = from.color
                infect(from: bacteria)
            }
        }
    }
    
    func rotate(bacteria: Bacteria) {
        objectWillChange.send()
        
        bacteria.direction = bacteria.direction.next
        infect(from: bacteria)
    }
}
