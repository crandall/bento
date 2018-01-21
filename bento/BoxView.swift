//
//  BoxView.swift
//  bento
//
//  Created by Mike Crandall on 1/21/18.
//  Copyright © 2018 Eyebrowman. All rights reserved.
//

import UIKit

class BoxView: UIView {

    var view: UIView!
    @IBOutlet weak var boxIV : UIImageView!
    @IBOutlet weak var panelIV : UIImageView!
    
    @IBOutlet weak var panelWidthLC : NSLayoutConstraint!
    @IBOutlet weak var panelHeightLC : NSLayoutConstraint!

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
        let nib = UINib(nibName: "BoxView", bundle: bundle)
        let newView = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view = newView
        
        setUpDisplay()
        
        return view
    }
    
    func setUpDisplay(){
        
        panelHeightLC.constant = self.frame.height - 10
        
//        self.view.layer.borderColor = UIColor.orange.cgColor
//        self.view.layer.borderWidth = 2
        
    }

}
