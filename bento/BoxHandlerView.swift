//
//  BoxHandlerView.swift
//  bento
//
//  Created by Mike Crandall on 1/23/18.
//  Copyright © 2018 Eyebrowman. All rights reserved.
//

import UIKit

protocol BoxHandlerDelegate {
//    func onRotateBox()
    func onRotateBoxRight()
    func onRotateBoxLeft()
    func onRotatePanel()
}

enum RotateDirection {
    case left
    case right
}

class BoxHandlerView: UIView {
    
    var view: UIView!
    var delegate : BoxHandlerDelegate?
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    func xibSetup() {
        view = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        view.frame = bounds
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "BoxHandlerView", bundle: bundle)
        let newView = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view = newView
        
        setUpDisplay()
        
        return view
    }
    
    func setUpDisplay(){
        self.view.layer.borderColor = UIColor.gray.cgColor
        self.view.layer.borderWidth = 2
    }


    @IBAction func onRotateBoxRight(){
        print("onRotateBoxRight")
        if delegate != nil {
            delegate?.onRotateBoxRight()
        }
    }

    @IBAction func onRotateBoxLeft(){
        print("onRotateBoxLeft")
        if delegate != nil {
            delegate?.onRotateBoxLeft()
        }
    }

    @IBAction func onRotatePanel(){
        if delegate != nil {
            delegate?.onRotatePanel()
        }
    }


    
    
}

