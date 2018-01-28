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

class GameplayController: UIViewController {

    @IBOutlet weak var gameDataLabel : UILabel!
    @IBOutlet weak var logLabel : UILabel!
    var turnManager : TurnManagerView!
    var boxHandler : BoxHandlerView!
    var gameState : GameState = .none
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        GameDisplayManager.shared.gameController = self
        
        self.view.addSubview(GameDisplayManager.shared.gameView)

        let bounds = UIScreen.main.bounds
        let f = CGRect(x: 10, y: 40, width: bounds.width - 20, height: 90)
        turnManager = TurnManagerView(frame: f)
        turnManager.delegate = GameDisplayManager.shared
        self.view.addSubview(turnManager)
        
        boxHandler = BoxHandlerView(frame: CGRect.zero)
        boxHandler.delegate = GameDisplayManager.shared
        boxHandler.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(boxHandler)
        
        boxHandler.addConstraints( constraints:
            Constraint.bb.of(of: self.view, offset: -80),
                                   Constraint.LeftToLeft.of(of: self.view, offset: 10),
                                   Constraint.RightToRight.of(of: self.view, offset: -10),
                                   Constraint.Height.of(offset: 40)
        )
        
        boxHandler.isHidden = true

        
        
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

    func showBoxHandler(doShow:Bool){
        boxHandler.isHidden = !doShow
    }

    func logData(text: String) {
        logLabel.text = text
    }
    
    func updateGameDataLabel(text:String){
        gameDataLabel.text = text
    }



}
