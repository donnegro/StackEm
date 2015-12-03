//
//  Tile.swift
//  Stacker
//
//  Created by Daniel Portillo on 11/09/15.
//  Copyright (c) 2015 DAPortillo. All rights reserved.
//

import SpriteKit

class Tile {
    // MARK: - PROPERTIES
    /****************************************************************************/
    /****************************************************************************/
    /*                                PROPERTIES                                */
    /****************************************************************************/
    /****************************************************************************/
    
    // MARK: - Type Properties
    
    // MARK: Stored Properties
    
    /* Keep track of location for tile */
    let row:Int
    let column:Int
    
    var occupied:Bool
    var block:Block?
    
    // MARK: Computed Properties
    
    // MARK: - INITIALIZERS
    /****************************************************************************/
    /****************************************************************************/
    /*                               INITIALIZERS                               */
    /****************************************************************************/
    /****************************************************************************/
    
    init(row:Int, column:Int) {
        self.row    = row
        self.column = column
        self.occupied = false
        self.block = nil
    }
    
    // MARK: - INSTANCE METHODS
    /****************************************************************************/
    /****************************************************************************/
    /*                             INSTANCE METHODS                             */
    /****************************************************************************/
    /****************************************************************************/
    
    // MARK: - Public Instance Methods
    
    func addBlock(block:Block) {
        self.block = block
    }
}