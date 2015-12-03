//
//  Block.swift
//  Stacker
//
//  Created by Daniel Portillo on 11/09/15.
//  Copyright © 2015 Daniel Portillo. All rights reserved.
//

import SpriteKit

class Block: CustomStringConvertible {
    
    // MARK: - PROPERTIES
    /****************************************************************************/
    /****************************************************************************/
    /*                                PROPERTIES                                */
    /****************************************************************************/
    /****************************************************************************/
    
    // MARK: - Stored Properties
    
    var row:Int /* Row value of where the block resides */
    var column:Int /* Column value of where the block resides */
    var sprite:SKShapeNode? /* Sprite that represents the block */
    
    // MARK: Computed Properties
    
    var description:String {
        let rowString = self.row.description
        let colString = self.column.description
        return "Block row: " + rowString + " and Block column: " + colString
    }
    
    // MARK: - INITIALIZERS
    /****************************************************************************/
    /****************************************************************************/
    /*                               INITIALIZERS                               */
    /****************************************************************************/
    /****************************************************************************/
    
    init(row: Int, column: Int) {
        self.row    = row
        self.column = column
    }
    
    // MARK: - INSTANCE METHODS
    /****************************************************************************/
    /****************************************************************************/
    /*                             INSTANCE METHODS                             */
    /****************************************************************************/
    /****************************************************************************/
    
    // MARK: - Public Instance Methods
}