//
//  HeadySampleApp
//
//  Created by mac on 19/05/18.
//  Copyright © 2018 Heady. All rights reserved.
//
import Foundation
import UIKit

protocol SelectRankViewControllerDelegate {
    func selectedRank(rank:ResponseView.Ranking)
}

class SelectRankViewController: UITableViewController {
    
    //MARK:- Veriable declaration
    var delegate:SelectRankViewControllerDelegate?
    var allRanks:[ResponseView.Ranking] = []

    //MARK:- UITableView delegate/data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.allRanks.count > 0){
            return self.allRanks.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rankCellId", for: indexPath)
        cell.textLabel?.text = self.allRanks[indexPath.row].ranking
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.selectedRank(rank:self.allRanks[indexPath.row])
        self.navigationController?.popViewController(animated: true)
    }
}
