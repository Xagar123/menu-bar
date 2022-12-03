//
//  ViewController.swift
//  keep note app
//
//  Created by Admin on 22/11/22.
//

import UIKit

class ViewController: UIViewController{
    
    var sideBarView: UIView!
    var tableView: UITableView!

    var isEnableSideMenuBar: Bool = false
    var arrData = ["Notes","Reminder","Create new lable","Setting"]
    var arrImage:[UIImage] = [UIImage(imageLiteralResourceName: "download"),UIImage(imageLiteralResourceName: "Home"),UIImage(imageLiteralResourceName: "Language"),UIImage(imageLiteralResourceName: "Setting")]
    
    var imageV: UIImageView!
    var lbl: UILabel!
    
    var swipeToRight = UISwipeGestureRecognizer()
    var swipeToLeft = UISwipeGestureRecognizer()
    
    //to close side bar using taping
    var tempView = UIView()
    var tapGesture = UITapGestureRecognizer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Keep Note"
        var addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewItem))
        navigationItem.rightBarButtonItem = addButton
        addButton.tintColor = UIColor.black
        
        sideMenuButton()
        //Swipe to right side
        swipeToRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeToRightSide))
        swipeToRight.direction = .right
        self.view.addGestureRecognizer(swipeToRight)
        
        //Swipe to left side
        
        swipeToLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeToLeftSide))
        swipeToLeft.direction = .left
        self.view.addGestureRecognizer(swipeToLeft)
        
        tempView = UIView(frame: CGRect(x: self.view.bounds.width/1.5, y: 0, width:self.view.bounds.width-(self.view.bounds.width/1.5), height: self.view.bounds.height))
        self.view.addSubview(tempView)
        tempView.isHidden = true
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeSideBarView))
        tempView.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func addNewItem(){
        let alert = UIAlertController(title: "Node", message: "Add new note", preferredStyle: .alert)
        alert.addTextField {
            (field) in
            field.placeholder = "Enter here"
        }
        alert.addAction(UIAlertAction(title: "cancle", style: .cancel))
        present(alert, animated: true)
    }
    
    @objc func closeSideBarView(){
        self.view.addGestureRecognizer(swipeToRight)
        self.view.removeGestureRecognizer(swipeToLeft)
        UIView.animate(withDuration: 0.5) {
            self.sideBarView.frame = CGRect(x: 0, y: 0, width: 0, height: self.view.bounds.height)
            
            self.tableView.frame = CGRect(x: 0, y: 0, width: 0, height: self.view.bounds.height)
        }
        self.tempView.isHidden = true
        //self.isEnableSideBarView = false
    }
    
    @objc func swipeToLeftSide(){
        print("slide out")
        self.view.addGestureRecognizer(swipeToRight)
        self.view.removeGestureRecognizer(swipeToLeft)
        UIView.animate(withDuration: 0.3) {
            self.sideBarView.frame = CGRect(x: 0, y: 0, width: 0, height: self.view.bounds.height)
            self.tableView.frame = CGRect(x: 0, y: 0, width: 0, height: self.view.bounds.height)
        }
        self.tempView.isHidden = true
        isEnableSideMenuBar = false
        
    }

    @objc func swipeToRightSide(){
        print("Slide in")
        self.view.addGestureRecognizer(swipeToLeft)
        self.view.removeGestureRecognizer(swipeToRight)
        UIView.animate(withDuration: 0.3) {
            self.sideBarView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width/1.5, height: self.view.bounds.height)
            self.tableView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width/1.5, height: self.view.bounds.height)
        }
        self.tempView.isHidden = false
        isEnableSideMenuBar = true
    }
    @objc func menuBtnClick(){
        if isEnableSideMenuBar{
            print("its close now")
            self.view.addGestureRecognizer(swipeToRight)
            self.view.removeGestureRecognizer(swipeToLeft)
            UIView.animate(withDuration: 0.3) {
                self.sideBarView.frame = CGRect(x: 0, y: 0, width: 0, height: self.view.bounds.height)
                self.tableView.frame = CGRect(x: 0, y: 0, width: 0, height: self.view.bounds.height)
            }
            self.tempView.isHidden = true
            isEnableSideMenuBar = false
        }
        else{
            print("now its open")
            self.view.addGestureRecognizer(swipeToLeft)
            self.view.removeGestureRecognizer(swipeToRight)
            UIView.animate(withDuration: 0.3) {
                
                self.sideBarView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width/1.5, height: self.view.bounds.height)
                self.tableView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width/1.5, height: self.view.bounds.height)
            }
            self.tempView.isHidden = false
          isEnableSideMenuBar = true
        }
        
    }
    
    func sideMenuButton(){
        var menuBtn = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .done, target: self, action: #selector(menuBtnClick))
        menuBtn.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = menuBtn
        
        sideBarView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: self.view.bounds.height))
        
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: self.view.bounds.height))
        tableView.delegate = self
        tableView.dataSource = self
        
        //cell register
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.view.addSubview(sideBarView)
        self.sideBarView.addSubview(tableView)
        
        tableView.separatorStyle = .none
        
        
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> (Int){
        
        return (self.arrData.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> (UITableViewCell){
        
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        
        imageV = UIImageView(frame: CGRect(x: 20, y: 8, width: cell.bounds.height-16 , height: cell.bounds.height-16))
        imageV.contentMode = .scaleToFill
        imageV.image = self.arrImage[indexPath.row]
        cell.addSubview(imageV)
        
        
        lbl = UILabel(frame: CGRect(x: self.imageV.bounds.width+40, y: 8, width: cell.bounds.width - (self.imageV.bounds.width + 25), height: cell.bounds.height-16))
        lbl.text = self.arrData[indexPath.row]
        lbl.font = UIFont.systemFont(ofSize: 21)
        cell.addSubview(lbl)
        
        
        
        
        return (cell)
    }
    
    
}
