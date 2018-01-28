//
//  GamePiece.swift
//  bento
//
//  Created by Mike Crandall on 1/27/18.
//  Copyright © 2018 Eyebrowman. All rights reserved.
//

import UIKit

class GamePiece: UIView {
    
    var view: UIView!
    
//    @IBOutlet weak var pieceView : UIView!
//    @IBOutlet weak var pieceWidthLC : NSLayoutConstraint!
//    @IBOutlet weak var pieceHeightLC : NSLayoutConstraint!
//    @IBOutlet weak var piece_x_LC : NSLayoutConstraint!
//    @IBOutlet weak var piece_y_LC : NSLayoutConstraint!
    
    var pieceView : UIView!
    var pieceIV : UIImageView!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        xibSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        pieceView = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        pieceView.backgroundColor = .black
        pieceView.layer.cornerRadius = 12.0
        
//        xibSetup()
    }
    
    
//    func xibSetup() {
//        view = loadViewFromNib()
//
//        // use bounds not frame or it'll be offset
//        view.frame = bounds
//        addSubview(view)
//    }
//
//    func loadViewFromNib() -> UIView {
//
//        let bundle = Bundle(for: type(of: self))
//        let nib = UINib(nibName: "GamePiece", bundle: bundle)
//        let newView = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
//        view = newView
//
//        setUpDisplay()
//
//        return view
//    }
    
    func setUpDisplay(){
        
//        self.view.backgroundColor = .clear
//        
//        pieceHeightLC.constant = 24
//        pieceWidthLC.constant = 24
//        
//        pieceView.layer.cornerRadius = 12
//        pieceView.backgroundColor = .black

    }
    
}

