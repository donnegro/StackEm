//
//  Block.swift
//  Stacker
//
//  Created by Daniel Portillo on 11/09/15.
//  Copyright © 2015 Daniel Portillo. All rights reserved.
//

import SpriteKit

class Block: CustomStringConvertible, Hashable, Equatable {
    
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
    
    var hashValue:Int {
        return (row * 10) + column
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
    
    func getRow() -> Int {
        return self.row
    }
    
    func getColumn() -> Int {
        return self.column
    }
    
    func setRow(row:Int) {
        self.row = row
    }
    
    func setColumn(column:Int) {
        self.column = column
    }
}

func ==(lhs: Block, rhs: Block) -> Bool {
    return lhs.column == rhs.column && lhs.row == rhs.row
}