//
//  GameplayController.swift
//  bento
//
//  Created by Mike Crandall on 1/21/18.
//  Copyright © 2018 Eyebrowman. All rights reserved.
//

import UIKit

class GameplayController: UIViewController, TurnManagerDelegate {

    @IBOutlet weak var titleLabel : UILabel!
    var turnManager : TurnManagerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLabel.text = "GameplayController"

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
        
        self.view.addSubview(GameManager.shared.gameView)
        
        print("yo")
        
        let f = CGRect(x: 10, y: 10, width: 200, height: 100)
        turnManager = TurnManagerView(frame: f)
        self.view.addSubview(turnManager)
        
        
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

    //
    // MARK: TurnManagerDelegate
    //
    
    func onRotate(){
        print("onRotate")
    }
    
    func onMovePiece(){
        print("onMovePiece")
    }
    
}
