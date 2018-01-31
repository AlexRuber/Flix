//
//  ViewController.swift
//  Flix
//
//  Created by Mihai Ruber on 1/30/18.
//  Copyright © 2018 Mihai Ruber. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    
    
    //Variables

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

