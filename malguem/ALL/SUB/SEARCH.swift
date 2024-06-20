//
//  SEARCH.swift
//  malguem
//
//  Created by 부산광역시교육청 on 2021/05/11.
//

import UIKit

class SEARCH_TC: UITableViewCell {
    
    
}

class SEARCH: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func BACK_VC(_ sender: UIButton) { navigationController?.popViewController(animated: true) }
    
    @IBOutlet weak var TABLE_VIEW: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TABLE_VIEW.delegate = self
        TABLE_VIEW.dataSource = self
    }
}

extension SEARCH: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let CELL = tableView.dequeueReusableCell(withIdentifier: "SEARCH_TC", for: indexPath) as! SEARCH_TC
        
        return CELL
    }
}
