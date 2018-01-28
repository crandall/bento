//
//  GameplayController.swift
//  bento
//
//  Created by Mike Crandall on 1/21/18.
//  Copyright © 2018 Eyebrowman. All rights reserved.
//

import UIKit

enum GameState {
    case none
    case rotateBox
    case movePiece
}

class GameplayController: UIViewController, GameDisplayManagerDelegate, TurnManagerDelegate, BoxHandlerDelegate {

    @IBOutlet weak var gameDataLabel : UILabel!
    @IBOutlet weak var logLabel : UILabel!
    var turnManager : TurnManagerView!
    var boxHandler : BoxHandlerView!
    var gameState : GameState = .none
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GameDisplayManager.shared.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setUp()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUp(){
        print("setUp")
        
        self.view.addSubview(GameDisplayManager.shared.gameView)

        let bounds = UIScreen.main.bounds
        let f = CGRect(x: 10, y: 40, width: bounds.width - 20, height: 60)
        turnManager = TurnManagerView(frame: f)
        turnManager.delegate = self
        self.view.addSubview(turnManager)
        
        boxHandler = BoxHandlerView(frame: CGRect.zero)
        boxHandler.delegate = self
        boxHandler.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(boxHandler)
        
        boxHandler.addConstraints( constraints:
            Constraint.bb.of(of: self.view, offset: -40),
                                   Constraint.LeftToLeft.of(of: self.view, offset: 10),
                                   Constraint.RightToRight.of(of: self.view, offset: -10),
                                   Constraint.Height.of(offset: 60)
        )

        
        
//        var f = CGRect(x: 20, y: 20, width: 100, height: 100)
//        let b = BoxView(frame: f)
//
//        b.view.backgroundColor = .green
//
//        f.origin = CGPoint(x: 100, y: 200)
//        b.view.frame = f
//
//        self.view.addSubview(b.view)
//
//
//        // the board:
//        var boardFrame = CGRect(x: 20, y: 40, width: 300, height: 300)
//        let board = Board(frame: boardFrame)
//        self.view.addSubview(board)
//
//        // boxTableView:
//        var f1 = CGRect(x: 0, y: 0, width: 300, height: 200)
//        let bt = BoxTable(frame: f1)
//        self.view.addSubview(bt)
//        f1.origin = CGPoint(x: 10, y: 400)
//        bt.frame = f1
        
    }
    
    @IBAction func onDone(){
        print("onDone")
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func onStartGame(){
        GameLoop.shared.startGame()
    }

    //
    // MARK: GameDisplayManagerDelegate
    //

    func gameDisplayManagerTestFunc(){
        print("delegate:gameManagerTestFunc")
    }
    
    func logData(text: String) {
        logLabel.text = text
    }
    
    func updateGameDataLabel(text:String){
        gameDataLabel.text = text
    }


    //
    // MARK: TurnManagerDelegate
    //
    
    func turnRotateBox(){
        print("turnRotateBox")
    }
    func turnRotatePanel(){
        print("turnRotatePanel")
    }
    func turnMovePiece(){
        print("turnMovePiece")
    }
    func turnDone(){
        print("turnDone")
    }


    //
    // MARK: BoxHandlerDelegate
    //
    
    func onRotateBox(){
        GameDisplayManager.shared.rotateCurrentBox()
    }
    
    func onRotatePanel(){
        GameDisplayManager.shared.rotateCurrentPanel()
    }
    
    func onBoxHandlerDone(){
        boxHandler.updateLabel(text: "onBoxHandlerDone")
    }

}
