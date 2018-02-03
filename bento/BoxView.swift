//
//  BoxView.swift
//  bento
//
//  Created by Mike Crandall on 1/21/18.
//  Copyright © 2018 Eyebrowman. All rights reserved.
//

import UIKit

protocol BoxDelegate{
    func boxSelected(box:BoxView)
}

let boxTypes : [String:Any] = [
    "ulu" : ["type":"ulu","fileName":"box8"],
    "uru" : ["type":"uru","fileName":"box4"],
    "dld" : ["type":"dld","fileName":"box2"],
    "drd" : ["type":"drd","fileName":"box7"],
    "uld" : ["type":"uld","fileName":"box1"],
    "urd" : ["type":"urd","fileName":"box6"],
    "dlu" : ["type":"dlu","fileName":"box5"],
    "dru" : ["type":"dru","fileName":"box3"],
]

//enum testBoxType {
//    typealias RawValue = [Int]
//
//    case box1 = []
//}

let topLeft = "0"
let topRight = "1"
let rightUp = "2"
let rightDown = "3"
let bottomRight = "4"
let bottomLeft = "5"
let leftDown = "6"
let leftUp = "7"

enum BoxType : String {
    case box1 = "leftUp,bottomLeft,rightUp"
    case box2 = "leftUp,bottomRight,rightUp"
    case box3 = "leftDown,bottomLeft,rightDown"
    case box4 = "leftDown,bottomRight,rightDown"
    case box5 = "leftUp,bottomLeft,rightDown"
    case box6 = "leftUp,bottomRight,rightDown"
    case box7 = "leftDown,bottomLeft,rightUp"
    case box8 = "leftDown,bottomRight,rightUp"
//    case box1 = "ulu"
//    case box2 = "uru"
//    case box3 = "dld"
//    case box4 = "drd"
//    case box5 = "uld"
//    case box6 = "urd"
//    case box7 = "dlu"
//    case box8 = "dru"


    init?(index: Int) {
        switch index {
        case 0: self = .box1
        case 1: self = .box2
        case 2: self = .box3
        case 3: self = .box4
        case 4: self = .box5
        case 5: self = .box6
        case 6: self = .box7
        case 7: self = .box8
        case 8: self = .box1
        case 9: self = .box2
        case 10: self = .box3
        case 11: self = .box4
        case 12: self = .box5
        case 13: self = .box6
        case 14: self = .box7
        case 15: self = .box8
        default: return nil
        }
    }
}

class BoxView: UIView, UIGestureRecognizerDelegate {

    var view: UIView!
    var delegate : BoxDelegate?
    
    var currRotate : CGFloat = 0.0

    @IBOutlet weak var idLabel : UILabel!
    @IBOutlet weak var boxIV : UIImageView!
    @IBOutlet weak var panelIV : UIImageView!
    @IBOutlet weak var panelWidthLC : NSLayoutConstraint!
    @IBOutlet weak var panelHeightLC : NSLayoutConstraint!
    @IBOutlet weak var selectedView : UIView!
    
    var boxType : BoxType? {
        didSet{
            if let boxD = boxTypes[(boxType?.rawValue)!] as! [String:String]?{
                if let fileName = boxD["fileName"] {
                    let image = UIImage(named:fileName)
                    boxIV.image = image
                }
            }
        }
    }
    
    var tapGR : UITapGestureRecognizer!
    var isSelected : Bool = false
    
    var boxId : Int = 0 {
        didSet{
            idLabel.text = "\(boxId)"
        }
    }
    
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
        panelWidthLC.constant = 5.0
        idLabel.backgroundColor = .clear
        
        self.selectedView.isHidden = true
        
        tapGR = UITapGestureRecognizer(target: self, action: #selector(onTapGR))
        self.view.addGestureRecognizer(tapGR)

        //set the delegate
        tapGR.delegate? = self
        
    }
    
    var currRotatePosition:Int{
        get{
            
            let pos = Int(abs(boxAngle) / 90)
            
            return pos
        }
    }
    
    func openings()->[Int]{
        let posString = self.boxType!.rawValue
        var components = posString.components(separatedBy: ",")
        let pos = self.currRotatePosition
        var result : [Int] = []
        for i in 0..<components.count{
            let s = components[i]
            var val : Int = 0
            switch s {
            case "topLeft" :
                val = 0
            case "topRight" :
                val = 1
            case "rightUp" :
                val = 2
            case "rightDown" :
                val = 3
            case "bottomRight" :
                val = 4
            case "bottomLeft" :
                val = 5
            case "leftDown" :
                val = 6
            case "leftUp" :
                val = 7
            default:
                val = 0
            }
            
            // adjust for current box position
            var adjusted = val + (pos*2)
            if adjusted > 7 { adjusted -= 8 }
            
            result.append(adjusted)
        }
        
        return result
    }

    var boxAngle : CGFloat = 0.0
    var panelAngle : CGFloat = 0.0
    func rotateBox(direction:RotateDirection){
//        var pos = self.currRotatePosition
//        print("boxAngle:\(boxAngle) pos:\(pos) openings:\(self.openings())")
        if direction == .right {
            boxAngle += 90
            if boxAngle >= 360 { boxAngle = 0.0 }
            panelAngle += 90
        }else if direction == .left {
            boxAngle -= 90
            panelAngle -= 90
        }
        
        
        UIView.animate(withDuration: 0.25, animations: {
            self.boxIV.transform = CGAffineTransform(rotationAngle: (self.boxAngle * .pi) / 180.0)
            self.panelIV.transform = CGAffineTransform(rotationAngle: (self.panelAngle * .pi) / 180.0)
            self.selectedView.transform = CGAffineTransform(rotationAngle: (self.boxAngle * .pi) / 180.0)

        }, completion: { finished in
            if self.boxAngle < 0 {
                self.boxAngle = 360 + self.boxAngle
            }
            let pos = self.currRotatePosition
            print("boxAngle:\(self.boxAngle) pos:\(pos) openings:\(self.openings())")

        })

//        UIView.animate(withDuration: 0.25, animations: {
//            self.boxIV.transform = CGAffineTransform(rotationAngle: (self.boxAngle * .pi) / 180.0)
//            self.panelIV.transform = CGAffineTransform(rotationAngle: (self.panelAngle * .pi) / 180.0)
//            self.selectedView.transform = CGAffineTransform(rotationAngle: (self.boxAngle * .pi) / 180.0)
//        }completion:{ finished in
////                self.blurBg.hidden = true
//        })
    }

    func rotatePanel(){
        panelAngle += 90
        UIView.animate(withDuration: 0.25, animations: {
            self.panelIV.transform = CGAffineTransform(rotationAngle: (self.panelAngle * .pi) / 180.0)
        })
    }


    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        //condition to recognise the gesture
        return true
    }
    
    @objc func onTapGR(){
        print("onTapGR")
        delegate?.boxSelected(box: self)
    }
    
    func toggleSelected(){
        isSelected = !isSelected
        self.setSelected(doSelect: isSelected)
    }
    
    func setSelected(doSelect:Bool){
        isSelected = doSelect
        self.selectedView.isHidden = !doSelect
        
    }

}
