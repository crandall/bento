//
//  TurnManagerView.swift
//  bento
//
//  Created by Mike Crandall on 1/22/18.
//  Copyright © 2018 Eyebrowman. All rights reserved.
//

import UIKit

protocol TurnManagerDelegate {
    func onRotate()
    func onMovePiece()
}

class TurnManagerView: UIView {

    var view: UIView!
    var delegate : TurnManagerDelegate?
    @IBOutlet weak var label : UILabel!
    
    
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
        let nib = UINib(nibName: "TurnManagerView", bundle: bundle)
        let newView = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view = newView
        
        setUpDisplay()
        
        return view
    }
    
    func setUpDisplay(){
        self.view.layer.borderColor = UIColor.gray.cgColor
        self.view.layer.borderWidth = 2
        self.view.backgroundColor = .clear
        
        label.text = "TurnManagerView"
    }
    
    @IBAction func onRotate(){
        if delegate != nil {
            delegate?.onRotate()
        }
    }
    
    @IBAction func onMovePiece(){
        if delegate != nil {
            delegate?.onMovePiece()
        }
    }
    
    func updateLabel(text:String){
        label.text = text
    }


}
