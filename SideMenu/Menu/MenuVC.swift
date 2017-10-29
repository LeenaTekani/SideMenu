//
//  MenuVC.swift
//  SideMenu
//
//  Created by Apple on 29/10/17.
//  Copyright © 2017 leena. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {

    @IBOutlet  var cntTrailing: NSLayoutConstraint!
    @IBOutlet  var cntLeading: NSLayoutConstraint!
    @IBOutlet weak var viewContainter: UIView!
    var sideWidth = 200 //Set as per your need
    let navController = UINavigationController()
    var menuBtn : UIBarButtonItem!
    
    let panRec = UIPanGestureRecognizer()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.doInitialSettings()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK :- Class Methods
    
    func doInitialSettings()
    {
        let aVCObj = self.setUpCenterViewController()
        
        let aBtn = UIButton(type: .custom)
        aBtn.setImage(#imageLiteral(resourceName: "MenuIcon"), for: .normal)
        aBtn.addTarget(self, action: #selector(self.btnMenuAction(_:)), for: .touchUpInside)
        
        menuBtn = UIBarButtonItem(customView: aBtn)
        aVCObj.navigationItem.leftBarButtonItem = menuBtn
        
//        panRec.addTarget(self, action: #selector(draggedView(_:)))
//        navController.view.addGestureRecognizer(panRec)
//        navController.view.isUserInteractionEnabled = true
    }
    
    @objc func draggedView(_ sender:UIPanGestureRecognizer){
        
        let translation = sender.translation(in: self.view)
        let tmp:CGFloat! = sender.view?.center.x  //x translation
        let aCenter = CGPoint(x:tmp!+translation.x, y:(sender.view?.center.y)!)
        
        print("the translation x:\(aCenter.x) & y:\(aCenter.y)")

        if(aCenter.x <= (self.view.frame.size.width) && aCenter.x > (self.view.frame.size.width/2.0))
        {
            sender.view?.center = aCenter
            sender.setTranslation(CGPoint.zero, in: self.viewContainter)
        }
    }
    
    func setUpCenterViewController() -> UIViewController
    {
        let aStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let aVC = aStoryboard.instantiateViewController(withIdentifier: "BaseVC") as! BaseVC
        aVC.strScreenName = "Screen 1"
        aVC.view.backgroundColor = self.generateRandomColor()
        navController.view.frame = self.viewContainter.bounds
        navController.viewControllers = [aVC]
        
        self.addChildViewController(navController)
        self.viewContainter.addSubview(navController.view)
        navController.didMove(toParentViewController: self)
        self.setConstraints()

        return aVC
        
    }
    
    func setConstraints()
    {
        let aView = self.viewContainter
        let aSubView = navController.view
        // align aSubview from the left and right
        aView?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": aSubView!]));
        
        // align aSubview from the top and bottom
        aView?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[view]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": aSubView!]));

    }
    
    func generateRandomColor() -> UIColor {
        let hue : CGFloat = CGFloat(arc4random() % 256) / 256 // use 256 to get full range from 0.0 to 1.0
        let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from white
        let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from black
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }
    
    @objc func btnMenuAction(_ btnMenu:UIButton)  {
        btnMenu.isSelected = !btnMenu.isSelected
        
        let aOffset = btnMenu.isSelected ? self.sideWidth : 0
        
        UIView.animate(withDuration: 0.5) {
            self.cntLeading.constant = CGFloat(aOffset)
            self.cntTrailing.constant = CGFloat(-aOffset)
            self.view.layoutIfNeeded()
        }
    }
    
    func hideMenu()  {
        UIView.animate(withDuration: 0.5) {
            self.cntLeading.constant = 0
            self.cntTrailing.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    
    func changeCenterViewController(_ viewController:UIViewController)  {
        navController.viewControllers = [viewController]
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

extension MenuVC : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let aCell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! MenuTblViewCell
        
        aCell.lblMenuName.text = "Screen" + "\(indexPath.row + 1)"
        aCell.selectionStyle = .none
        return aCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.hideMenu()
        let aStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let aVC = aStoryboard.instantiateViewController(withIdentifier: "BaseVC") as! BaseVC
        aVC.strScreenName = "Screen" + "\(indexPath.row + 1)"
        aVC.view.backgroundColor = self.generateRandomColor()
        aVC.navigationItem.leftBarButtonItem = menuBtn

        self.changeCenterViewController(aVC)
    }
}

class MenuTblViewCell : UITableViewCell
{
    
    @IBOutlet weak var lblMenuName: UILabel!
    
}


