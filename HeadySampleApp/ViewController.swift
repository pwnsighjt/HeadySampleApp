//
//  ViewController.swift
//  HeadySampleApp
//
//  Created by mac on 19/05/18.
//  Copyright © 2018 Heady. All rights reserved.
//

import UIKit

class ViewController: UITableViewController,SelectRankViewControllerDelegate {
    
    //MARK:- Veriable declaration
    var prodcuts:[ResponseView.CategoryProduct] = []
    var ranks:[ResponseView.Ranking] = []

    //MARK:- View life cycle delegate
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.prepareLayout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK:- User custom method
    func prepareLayout(){
        //get the product info
        let authJob = AuthJob(authSuccess: { (response) -> Void in
            let productList:ResponseView.ProductList = ResponseView.ProductList().getObjectFromString(jsonResponse: response as AnyObject)
            //get products of all category
            for category in (productList.categories)!{
                for product in category.products!{
                    self.prodcuts.append(product)
                }
            }
            //get all rank and related products
            for rank in (productList.rankings)!{
                self.ranks.append(rank)
            }
            //update UI
            if(self.prodcuts.count > 0){
                self.tableView.reloadData()
            }
        }) { (error) -> Void in
            print(error)
        }
        BaseApp.sharedInstance.jobManager?.addOperation(authJob)
    }
    
    //MARK:- Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.destination is SelectRankViewController{
            let vc = segue.destination as? SelectRankViewController
            vc?.allRanks = self.ranks
            vc?.delegate = self
        }
    }
    
    //MARK:- SelectRankView Delegate
    func selectedRank(rank:ResponseView.Ranking) {
        var temp:[ResponseView.CategoryProduct] = []
        for product in rank.products!{
            for pro in prodcuts{
                if(pro.id == product.id){
                    temp.append(pro)
                }
            }
        }
        self.prodcuts = temp
        self.tableView.reloadData()
    }
    
    //MARK:- UITableView delegate/data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.prodcuts.count > 0){
            return self.prodcuts.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.textLabel?.text = self.prodcuts[indexPath.row].name
        cell.detailTextLabel?.text = String(format: "available variants-> %d",(self.prodcuts[indexPath.row].variants?.count)!)
        return cell
    }    

}

