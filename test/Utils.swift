//
//  Utils.swift
//  Stacker
//
//  Created by Daniel Dao on 11/8/15.
//  Copyright © 2015 Daniel Dao. All rights reserved.
//

import Foundation
import SpriteKit

let numColumns = 7
let numRows = 4

// tile bounds
let tileWidth:CGFloat = 32.0
let tileHeight:CGFloat = 36.0

// bounds of the grid
let rightBounds = CGFloat(256)
let leftBounds = CGFloat(0)

// declare the blocks
private var blocks = Array2D<Block>(rows: numRows, columns: numColumns)

// declare empty false bool array
var boolBlocks:Array2D = Array2D<Bool>(rows: numRows, columns: numColumns)
// Might want to set all values to false
// right now they are all nil

// get block from 2d grid
func getBlock(column: Int, row:Int) -> Block?{
    assert(column >= 0 && column < numColumns)
    assert(row >= 0 && row < numRows)
    
    return blocks[column, row]
}

// add block to 2d grid
func addBlock(block:Block) {
    blocks[block.row, block.column] = block
}

func getBlocks(row:Int) -> [Block]{
    var rowBlocks:[Block] = []
    
    for(var i = 0; i < numColumns; i++){
        let block = getBlock(i, row: row)
        if(block != nil){
            rowBlocks.append(block!)
        }
    }
    
    return rowBlocks
}

func deleteBlock(row:Int, column:Int){
    // delete the block at the current row
    blocks[column, row] = nil
}


func pointForColumn(column: Int, row: Int) -> CGPoint {
    return CGPoint(
        x: CGFloat(column) * tileWidth + tileWidth/2,
        y: CGFloat(row) * tileHeight + tileHeight/2)
}
