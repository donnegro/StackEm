//
//  Board.swift
//  Stacker
//
//  Created by Daniel Portillo on 11/09/15.
//  Copyright (c) 2015 DAPortillo. All rights reserved.
//

import Foundation

class Board {
    // MARK: - PROPERTIES
    /****************************************************************************/
    /****************************************************************************/
    /*                                PROPERTIES                                */
    /****************************************************************************/
    /****************************************************************************/
    
    // MARK: - Stored Properties
    
    let numberOfRows        :Int
    let numberOfColumns     :Int
    
    private var arrayOfTiles:Array2D<Tile>
    
    // MARK: Computed Properties
    
    // MARK: - INITIALIZERS
    /****************************************************************************/
    /****************************************************************************/
    /*                               INITIALIZERS                               */
    /****************************************************************************/
    /****************************************************************************/
    
    init(rows:Int, columns:Int) {
        assert(rows >= 0 && columns >= 0, "ERROR: negative input for rows or columns")
        
        self.numberOfRows       = rows
        self.numberOfColumns    = columns
        self.arrayOfTiles      = Array2D<Tile>(rows: rows, columns: columns)
        
        for row in 0..<rows {
            for column in 0..<columns {
                let newTile: Tile = Tile(row: row, column: column)
                
                self.arrayOfTiles[row, column] = newTile
            }
        }
    }
    
    // MARK: - INSTANCE METHODS
    /****************************************************************************/
    /****************************************************************************/
    /*                             INSTANCE METHODS                             */
    /****************************************************************************/
    /****************************************************************************/
    
    // MARK: - Public Instance Methods
    
    func tileAt(row:Int, column:Int) -> Tile! {
        // Must return a tile (cannot return nil)
        return self.arrayOfTiles[row, column]
    }
}