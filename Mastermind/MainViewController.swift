//
//  ViewController.swift
//  Mastermind
//
//  Created by Collongues Clément on 19/03/2018.
//  Copyright © 2018 Collongues Clément. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    @IBOutlet var tableView: UITableView!
    
    let textCellIdentifier = "TextCell"
    
    var actualTentatives: [Tentative] = []
    // actualTentatives.append(Tentative(code:[1,1,1,1], verification:[1,1,1,1]))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(notificationRecevied(notification:)), name: NSNotification.Name(rawValue: "userCode"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(createAlert(notification:)), name: NSNotification.Name(rawValue: "isWon"), object: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actualTentatives.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath) as! TentativeTableViewCell
        
        let row = indexPath.row
        cell.SelectControl.setupButtons(code: actualTentatives[row].code)
        cell.DecoderControl.setupButtons(decoded: actualTentatives[row].verification)
        return cell
    }
    
    @objc func notificationRecevied(notification: Notification) {
        let userCode = notification.object as! Array<Int>
        let secretCode = UserDefaults.standard.array(forKey: "secretCode") as! Array<Int>
        let verificationCode = Tentative(code: userCode, verification: [0,0,0,0])
        let complete = verificationCode?.getVerifCode(code: secretCode,usercode: userCode)
        
        
        let result = Tentative(code: userCode, verification: complete!)
        actualTentatives.append(result!)
        updateLastRow()
    }
    
    @objc func createAlert(notification: Notification) {
        let alert = UIAlertController(title: "Félicitation", message: "Vous avez gagné!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Click", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func updateLastRow() {
        tableView.reloadData()
    }
}














//        let file = "file.json" //this is the file. we will write to and read from it
//
//        let text = String(describing: secretCode) //just a text
//
//        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
//
//            let fileURL = dir.appendingPathComponent(file)
//
//            //writing
//            do {
//                try text.write(to: fileURL, atomically: false, encoding: .utf8)
//            }
//            catch {/* error handling here */}
//reading
//            do {
//                let text2 = try String(contentsOf: fileURL, encoding: .utf8)
//            }
//            catch {/* error handling here */}
//        }
