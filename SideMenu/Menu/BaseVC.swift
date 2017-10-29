
//
//  BaseVC.swift
//  SideMenu
//
//  Created by Apple on 29/10/17.
//  Copyright © 2017 leena. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {

    @IBOutlet weak var lblScreen: UILabel!
    var strScreenName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblScreen.text = strScreenName
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
