//
//  Array2D.swift
//  Stacker
//
//  Created by Daniel Portillo on 11/09/15.
//  Copyright (c) 2015 DAPortillo. All rights reserved.
//

struct Array2D<T> {
    
    // MARK: - PROPERTIES
    /****************************************************************************/
    /****************************************************************************/
    /*                                PROPERTIES                                */
    /****************************************************************************/
    /****************************************************************************/
    
    // MARK: - Stored Properties
    
    let rows    :Int
    let columns :Int
    
    private var array:Array<T?>
    
    // MARK: Computed Properties
    
    var count:Int {
        return (rows * columns)
    }
    
    // MARK: - INITIALIZERS
    /****************************************************************************/
    /****************************************************************************/
    /*                               INITIALIZERS                               */
    /****************************************************************************/
    /****************************************************************************/
    
    init(rows:Int, columns:Int) {
        self.rows       = rows
        self.columns    = columns
        self.array      = [T?](count: (rows * columns), repeatedValue: nil)
    }
    
    subscript(row:Int, column:Int) -> T? {
        get {
            return array[(row * self.columns) + column]
        }
        set {
            array[(row * self.columns) + column] = newValue
        }
    }
}