//
//  GameManager.swift
//  bento
//
//  Created by Mike Crandall on 1/21/18.
//  Copyright © 2018 Eyebrowman. All rights reserved.
//

import UIKit

protocol GameManagerDelegate{
    func gameManagerTestFunc()
    func logData(text:String)
}

class GameManager: NSObject, BoxDelegate {

    static let shared = GameManager()
    
    var delegate : GameManagerDelegate?
    
    var gameView : UIView!
    var gameFrame : CGRect!
    var boardFrame : CGRect!
    var board : Board!
    var boxesA : [BoxView] = []
    var boxLocsA : [CGPoint] = []
    
    private override init(){
        super.init()
        self.initItems()
    }
    
    func initItems(){
        
        // containerView:
        let wFrame = UIScreen.main.bounds
        self.gameFrame = CGRect(x: 0, y: 0, width: wFrame.width, height: wFrame.width)
        self.gameView = UIView(frame: gameFrame)
        self.gameView.backgroundColor = UIColor.init(white: 0.75, alpha: 1.0)
        self.gameView.center = CGPoint(x: wFrame.width/2.0, y: wFrame.height/2.0)
        self.gameView.layer.borderColor = UIColor.black.cgColor
        self.gameView.layer.borderWidth = 1.0
        
        
        // the board:
        self.boardFrame = CGRect(x: 2, y: 2, width: gameFrame.width - 4, height: gameFrame.height - 4)
        self.board = Board(frame: boardFrame)
        self.board.view.backgroundColor = .orange
        self.gameView.addSubview(self.board)

        let boxSize : CGFloat = boardFrame.width / 4.0
        boxesA.removeAll()
        for i in 0..<16 {
            let b = BoxView(frame: CGRect(x: 0, y: 0, width: boxSize, height: boxSize))
            b.boxId = i
            b.tag = i
            b.delegate = self
            boxesA.append(b)
        }

        self.placeAllBoxes()
        
        self.logGameData()
    }
    
    func logGameData(){
        
        var text = "no box selected"
        
        if currSelectedBox != nil{
            text = "\(currSelectedBox!.tag)"
        }
        
        delegate?.logData(text: text)
    }
    
    func rotateCurrentBox(){
        if currSelectedBox != nil {
            currSelectedBox?.rotateBox()
        }
    }

    func rotateCurrentPanel(){
        if currSelectedBox != nil {
            currSelectedBox?.rotatePanel()
        }
    }

    func selectOneBox(box:BoxView){
        for box in boxesA{
            box.setSelected(doSelect: false)
        }
        box.setSelected(doSelect: true)
    }

    func unselectAllBoxes(){
        for box in boxesA{
            box.setSelected(doSelect: false)
        }
    }

    func placeAllBoxes(){
        
        var xLoc : CGFloat = 1
        var yLoc : CGFloat = 1
        
        let boxSize : CGFloat = boardFrame.width / 4.0
        
        for i in 0..<16 {
            let b = boxesA[i]

            // place the box:
            let newFrame = CGRect(x: xLoc, y: yLoc, width: boxSize, height: boxSize)
            b.view.frame = newFrame
            board.view.addSubview(b.view)
            
            // update loc values:
            if i + 1 != 1 && (i + 1) % 4 == 0 {
                xLoc = 0
                yLoc += boxSize
            }else{
                xLoc += boxSize
            }
            
        }
    }
    
    //
    // MARK: BoxDelegate
    //
    
    var currSelectedBoxIdx : Int = -1
    var currSelectedBox : BoxView?
    func boxSelected(box:BoxView){
        print("delegate:boxSelected")
        if !box.isSelected {
            self.unselectAllBoxes()
        }
        box.toggleSelected()
        
        if box.isSelected {
            currSelectedBoxIdx = box.tag
            currSelectedBox = box
        }else{
            currSelectedBoxIdx = -1
            currSelectedBox = nil
        }
        logGameData()
    }

    
}
