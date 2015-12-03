//
//  GameScene.swift
//  Stacker
//
//  Created by Daniel Portillo on 11/09/15.
//  Copyright (c) 2015 Daniel Portillo. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    let board:Board /* Model used for the board. Keeps track of... */
    let tileSize:CGSize /* Contains the dimensions of each tile (dependent on screen size) */
    
    var currentRow = 9
    var currentColumn = 0
    var currentDirection = CGFloat(1)
    
    var currentNumberOfBlocks = 4
    
    var score = 0
    var label:SKLabelNode = SKLabelNode(fontNamed: "AvenirNext-Heavy")
    
    var start = false
    var stop = false
    
    var currentBlocks:[Block?] = [Block?](count:8, repeatedValue: nil)
    
    let gameLayer:SKNode = SKNode() /* Contains all nodes for the game */
    let boardLayer:SKNode = SKNode() /* Contains all tile nodes (board) */
    let blockLayer:SKNode = SKNode() /* Contains all block nodes */
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) is not used in this app")
    }
    
    init(size: CGSize, board: Board) {
        // self.board must be set before super.init() is called
        self.board = board
        self.tileSize = CGSize(width: size.width / CGFloat(self.board.numberOfColumns), height: size.width / CGFloat(self.board.numberOfColumns))
        
        super.init(size: size)
        
        // Change the origin of the scene
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        // Apply a background to the scene
        self.backgroundColor = SKColor.blackColor()
        
        // CGPoint North-West relative to the origin of the scene
        let layerPosition = CGPoint(
            x: -self.tileSize.width * CGFloat(board.numberOfColumns) / 2,
            y: self.tileSize.height * CGFloat(board.numberOfRows) / 2)
        
        self.blockLayer.zPosition = 100.0
        
        // Add layers to the scene (Game --> Board --> Block)
        self.addChild(gameLayer)
        self.boardLayer.position = layerPosition
        self.gameLayer.addChild(boardLayer)
        self.boardLayer.addChild(blockLayer)
        
        label.text = String(self.score)
        label.fontSize = 40
        label.fontColor = SKColor.redColor()
        label.position = CGPointMake(0, -self.size.height/2)
        self.addChild(label)
    }
    
    /////////////////////////// PUBLIC INSTANCE METHODS //////////////////////////
    
    /* Adds a visual representation of the model (self.board) to the scene. This
    includes correct number of rows and columns and positioning of a tile relative
    to where they are located in the model. For example, a tile positioned at
    row: 0, column: 0 in the model (self.board) should be located at the top left
    of the scene relative to the boardLayer */
    func addTiles() {
        for row in 0..<board.numberOfRows {
            for column in 0..<board.numberOfColumns {
                // Create the sprite, calculate point where to place it,
                // and add it the tileLayer
                let shapeNode = SKShapeNode(rectOfSize: self.tileSize)
                shapeNode.strokeColor = SKColor.redColor()
                let tileNode: SKShapeNode = shapeNode
                tileNode.position = pointForRowAndColumn(row, column: column)
                boardLayer.addChild(tileNode)
            }
        }
    }
    
    /////////////////////////// PRIVATE HELPER FUNCTIONS /////////////////////////
    
    /* Returns a point that corresponds to the location (row, column) of a given
    tile within the model (self.board) to be used in the tileLayer or sphereLayer */
    private func pointForRowAndColumn(row: Int, column: Int) -> CGPoint {
        return CGPoint(
            x: CGFloat(column)*self.tileSize.width + self.tileSize.width/2,
            y: -CGFloat(row)*self.tileSize.height - self.tileSize.height/2)
    }
    
    private func pointForTile(tile: Tile) -> CGPoint {
        return (pointForRowAndColumn(tile.row, column: tile.column))
    }
    
    /* Returns a tuple that contains corresponding row and column of the point touched */
    private func convertPoint(point: CGPoint) -> (row: Int, column: Int) {
        return (Int(-point.y / self.tileSize.height), Int(point.x / self.tileSize.width))
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // Create a new sprite that will be added to the UI
        // The number of sprites depends on numberOfNodesForRow
        
        if (start == true) {
            for i in 0..<self.currentNumberOfBlocks {
                // Reposition the current blocks so that they are in the center of a tile
                let (rowForBlock, columnForBlock) = convertPoint(CGPointMake((currentBlocks[i]?.sprite?.position.x)!, (currentBlocks[i]?.sprite?.position.y)!))
                
                // Retreive the corresponding tile for rowForBlock and columnForBlock
                let currentTile = board.tileAt(rowForBlock, column: columnForBlock)
                
                // Reposition the block to the middle x and y for tile
                currentBlocks[i]?.sprite?.position.x = pointForTile(currentTile).x
                
                // Before saving block to tile, there must be a block in the tile underneath it (with the exception of the very bottom row)
                if (currentRow == 9) {
                    // Add that the tile is being occupied (change boolean value)
                    currentTile.occupied = true
                    
                    // Save each block in currentBlocks to respective tile
                    currentTile.addBlock(currentBlocks[i]!)
                } else {
                    // Not the bottom row
                    // Only add if there is a block in the tile underneath it
                    if (!board.tileAt(currentRow + 1, column: currentTile.column).occupied) {
                        // Delete the sprite from the screen
                        currentBlocks[i]?.sprite?.removeFromParent()
                        self.currentNumberOfBlocks--
                        
                        if (self.currentNumberOfBlocks == 0) {
                            //print("YOU LOSE")
                            //print(score)
                            stop = true
                            
                            let reveal = SKTransition.flipHorizontalWithDuration(0.5)
                            let scene = GameOverScene(size: self.size, score:self.score)
                            self.view?.presentScene(scene, transition: reveal)
                        }
                    } else {
                        // Add that the tile is being occupied (change boolean value)
                        currentTile.occupied = true
                        
                        // Save each block in currentBlocks to respective tile
                        currentTile.addBlock(currentBlocks[i]!)
                    }
                }
            }
            
            self.score = self.score + ((currentRow - 9)*(-10))
            
            if (stop == false) {
                self.currentRow--
                if (currentDirection < 0) {
                    currentDirection -= 3.0
                } else {
                    currentDirection += 3.0
                }
                
                if (self.currentRow < 0) {
                    stop = true
                    //print("YOU WIN")
                    //print(score)
                    self.score = 4000
                    
                    let reveal = SKTransition.flipHorizontalWithDuration(0.5)
                    let scene = GameOverScene(size: self.size, score:self.score)
                    self.view?.presentScene(scene, transition: reveal)
                }
            }
        }
        
        if (stop == false) {
            for i in 0..<self.currentNumberOfBlocks {
                let newBlock:Block = Block(row: self.currentRow, column: i + 2)
                
                let blockNode = SKShapeNode(rect: CGRectMake(-21, -21, self.tileSize.width - 5, self.tileSize.height - 5))
                blockNode.position = pointForRowAndColumn(newBlock.row, column: newBlock.column)
                blockNode.fillColor = SKColor.blueColor()
                blockNode.strokeColor = SKColor.blackColor()
                
                newBlock.sprite = blockNode
                self.currentBlocks[i] = newBlock
                self.blockLayer.addChild(newBlock.sprite!)
            }
            
            start = true
        }
    }
    
    override func update(currentTime: NSTimeInterval) {
        self.label.text = String(self.score)
        if (self.start == true && stop == false) {
            for i in 0..<self.currentNumberOfBlocks {
                let currentBlock = self.currentBlocks[i]
                
                let currentBlockSprite = currentBlock!.sprite
                
                if (currentBlockSprite?.position.x <= 350 && currentBlockSprite?.position.x >= self.tileSize.width / 2) {
                    currentBlockSprite?.position.x = (currentBlockSprite?.position.x)! + currentDirection
                    
                    if currentBlockSprite?.position.x > 350 {
                        var difference = (currentBlockSprite?.position.x)! - 350
                        currentBlockSprite?.position.x = 350
                        currentDirection = -1*currentDirection
                        
                        // Shift all other nodes by the difference
                        for j in 0..<self.currentNumberOfBlocks-1 {
                            var currentBlock = self.currentBlocks[j]
                            let currentBlockSprite = currentBlock!.sprite
                            currentBlockSprite?.position.x -= difference
                        }
                    }
                } else {
                    currentDirection = -1*currentDirection
                    currentBlockSprite?.position.x = (currentBlockSprite?.position.x)! + currentDirection
                }
            }
        }
    }
}