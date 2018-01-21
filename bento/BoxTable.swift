//
//  BoxTable.swift
//  bento
//
//  Created by Mike Crandall on 1/21/18.
//  Copyright © 2018 Eyebrowman. All rights reserved.
//

import UIKit

class BoxTable: UIView, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView : UITableView!

    var view: UIView!
    
    
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
        let nib = UINib(nibName: "BoxTable", bundle: bundle)
        let newView = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view = newView
        
        setUpDisplay()
        
        return view
    }
    
    
    func setUpDisplay(){
        self.view.backgroundColor = .red
        self.tableView.backgroundColor = .orange
        
        let nib = UINib(nibName: "BoxTableCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "boxTableCell")

    }
    
    //
    // MARK: UITableView dataSource
    //
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "boxTableCell", for: indexPath) as! BoxTableCell
        cell.selectionStyle = .none
        
        cell.titleLabel.text = "yo yo yoyo yo yoyo yo yoyo yo yoyo yo yoyo yo yoyo yo yoyo yo yo"
        cell.titleLabel.textColor = .black
        cell.contentView.backgroundColor = .green
        
        return cell
    }
    
    
    //
    // MARK: UITableView delegate
    //
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print("didSelectRowAt \(indexPath.row)")
    }


}
