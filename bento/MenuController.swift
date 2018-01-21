//
//  MenuController.swift
//  bento
//
//  Created by Mike Crandall on 1/21/18.
//  Copyright © 2018 Eyebrowman. All rights reserved.
//

import UIKit

class MenuController: UIViewController {
    
    @IBOutlet weak var titleLabel : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)

        self.titleLabel.text = "MenuController"
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onGameplay(){
        print("onGameplay")
        let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = sb.instantiateViewController(withIdentifier: "gameplayController") as! GameplayController
        let _ = self.navigationController?.pushViewController(vc, animated: true)

    }
}
