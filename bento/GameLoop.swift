//
//  GameLoop.swift
//  bento
//
//  Created by Mike Crandall on 1/27/18.
//  Copyright © 2018 Eyebrowman. All rights reserved.
//

import UIKit

protocol GameLoopDelegate{
    func gameLoopTestFunc()
}

struct Player {
//    var gamePiece : GamePiece = GamePiece(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
    var name : String!
    var gamePiece : GamePiece!
    var currBoxIdx : Int!
    var startBoxIdx : Int!
    
    init(playerNum : Int, startIdx : Int, playerName:String){
        name = playerName
        gamePiece = GamePiece(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        self.startBoxIdx = startIdx
        self.currBoxIdx = startIdx
    }
    
    func moveToBox(boxIdx : Int){
        let boxFrame = GameDisplayManager.shared.boxLocsA[boxIdx]
        var f = gamePiece.pieceView.frame
        f.origin.x = boxFrame.origin.x + 10
        f.origin.y = boxFrame.origin.y + 40
        self.gamePiece.pieceView.frame = f
    }
}

struct Turn {
    var moveMade : Bool
    var rotateMade : Bool
    var adjacentRotateMade : Bool
    
    var turnDone : Bool {
        get{
            if adjacentRotateMade {
                return true
            }else if moveMade && rotateMade {
                return true
            }
            return false
        }
    }
}

class GameLoop: NSObject {
    static let shared = GameLoop()
    var delegate : GameLoopDelegate?

    var playersA : [Player] = [
        GameDisplayManager.shared.player1,
        GameDisplayManager.shared.player2,
        GameDisplayManager.shared.player3,
        GameDisplayManager.shared.player4,
    ]

    private override init(){
        super.init()
        self.initGame()
    }
    
    func initGame(){
    }
    
    func startGame(){
        self.placePlayersInStartPosition()
    }
    
    func placePlayersInStartPosition(){
        for player in playersA {
            player.moveToBox(boxIdx: player.startBoxIdx)
        }
    }

    func takeTurn(){
        
        // move:
        // turn:
        
        
        // or turn adjacent:
        
        
        
        
        
    }
    
    
}
