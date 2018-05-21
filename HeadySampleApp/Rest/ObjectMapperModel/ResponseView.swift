//
//  HeadySampleApp
//
//  Created by mac on 19/05/18.
//  Copyright © 2018 Heady. All rights reserved.
//

import Foundation
import ObjectMapper

class ResponseView {
    
    
    class ProductList:Mappable {
        var categories: [Category]?
        var rankings: [Ranking]?

        init(){
            
        }
        
        // Convert Json string to class object
        func getObjectFromString(jsonResponse: AnyObject)->ProductList{
            var productList:ProductList?
            if jsonResponse is NSDictionary{
                let tempDic:NSDictionary? = (jsonResponse as! NSDictionary)
                if tempDic != nil{
                    let mapper = Mapper<ProductList>()
                    //if let testObject = mapper.map(tempDic){
                    if let testObject = mapper.map(JSON: tempDic as! [String : Any]){
                        productList = testObject
                    }
                }
            }
            return productList!
        }
        
        required init?(map: Map){
        }
        
        func mapping(map: Map){
            categories     <- map["categories"]
            rankings       <- map["rankings"]
        }
   
    }
    
    //NEW
    class Tax:Mappable {
        var name: String?
        var value: Double?
        
        
        init(){
            
        }
        
        // Convert Json string to class object
        func getObjectFromString(jsonResponse: AnyObject)->Tax{
            var tax:Tax?
            if jsonResponse is NSDictionary{
                let tempDic:NSDictionary? = (jsonResponse as! NSDictionary)
                if tempDic != nil{
                    let mapper = Mapper<Tax>()
                    //if let testObject = mapper.map(tempDic){
                    if let testObject = mapper.map(JSON: tempDic as! [String : Any]){
                        tax = testObject
                    }
                }
            }
            return tax!
        }
        
        required init?(map: Map){
        }
        
        func mapping(map: Map){
            name                   <- map["name"]
            value               <- map["value"]
        }
    }
    class Name:Mappable {
        var vat: String?
        var vat4: Double?
        
        
        init(){
            
        }
        
        // Convert Json string to class object
        func getObjectFromString(jsonResponse: AnyObject)->Name{
            var name:Name?
            if jsonResponse is NSDictionary{
                let tempDic:NSDictionary? = (jsonResponse as! NSDictionary)
                if tempDic != nil{
                    let mapper = Mapper<Name>()
                    //if let testObject = mapper.map(tempDic){
                    if let testObject = mapper.map(JSON: tempDic as! [String : Any]){
                        name = testObject
                    }
                }
            }
            return name!
        }
        
        required init?(map: Map){
        }
        
        func mapping(map: Map){
            vat                   <- map["vat"]
            vat4               <- map["vat4"]
        }
    }
    class Variant:Mappable {
        var id: Int?
        var color:String?
        var size: Int?
        var price: Int?
        
        
        init(){
            
        }
        
        // Convert Json string to class object
        func getObjectFromString(jsonResponse: AnyObject)->Variant{
            var variant:Variant?
            if jsonResponse is NSDictionary{
                let tempDic:NSDictionary? = (jsonResponse as! NSDictionary)
                if tempDic != nil{
                    let mapper = Mapper<Variant>()
                    //if let testObject = mapper.map(tempDic){
                    if let testObject = mapper.map(JSON: tempDic as! [String : Any]){
                        variant = testObject
                    }
                }
            }
            return variant!
        }
        
        required init?(map: Map){
        }
        
        func mapping(map: Map){
            id                   <- map["id"]
            color               <- map["color"]
            size               <- map["size"]
            price               <- map["price"]
        }
    }
    class Ranking:Mappable {
        var ranking: String?
        var products: [RankingProduct]?
        init(){
            
        }
        
        // Convert Json string to class object
        func getObjectFromString(jsonResponse: AnyObject)->Ranking{
            var ranking:Ranking?
            if jsonResponse is NSDictionary{
                let tempDic:NSDictionary? = (jsonResponse as! NSDictionary)
                if tempDic != nil{
                    let mapper = Mapper<Ranking>()
                    //if let testObject = mapper.map(tempDic){
                    if let testObject = mapper.map(JSON: tempDic as! [String : Any]){
                        ranking = testObject
                    }
                }
            }
            return ranking!
        }
        
        required init?(map: Map){
        }
        
        func mapping(map: Map){
            ranking                   <- map["ranking"]
            products               <- map["products"]
        }
    }
    
    class CategoryProduct:Mappable {
        var id: Int?
        var name, dateAdded: String?
        var variants: [Variant]?
        var tax: Tax?
        
        init(){
            
        }
        
        // Convert Json string to class object
        func getObjectFromString(jsonResponse: AnyObject)->CategoryProduct{
            var categoryProduct:CategoryProduct?
            if jsonResponse is NSDictionary{
                let tempDic:NSDictionary? = (jsonResponse as! NSDictionary)
                if tempDic != nil{
                    let mapper = Mapper<CategoryProduct>()
                    //if let testObject = mapper.map(tempDic){
                    if let testObject = mapper.map(JSON: tempDic as! [String : Any]){
                        categoryProduct = testObject
                    }
                }
            }
            return categoryProduct!
        }
        
        required init?(map: Map){
        }
        
        func mapping(map: Map){
            id                     <- map["id"]
            name                   <- map["name"]
            dateAdded                   <- map["dateAdded"]
            variants               <- map["variants"]
            tax        <- map["tax"]
        }
    }
class Category:Mappable {
    var id: Int?
    var name: String?
    var products: [CategoryProduct]?
    var childCategories: [Int]?
    
    init(){
        
    }
    
    // Convert Json string to class object
    func getObjectFromString(jsonResponse: AnyObject)->Category{
        var category:Category?
        if jsonResponse is NSDictionary{
            let tempDic:NSDictionary? = (jsonResponse as! NSDictionary)
            if tempDic != nil{
                let mapper = Mapper<Category>()
                //if let testObject = mapper.map(tempDic){
                if let testObject = mapper.map(JSON: tempDic as! [String : Any]){
                    category = testObject
                }
            }
        }
        return category!
    }
    
    required init?(map: Map){
    }
    
    func mapping(map: Map){
        id                     <- map["id"]
        name                   <- map["name"]
        products               <- map["products"]
        childCategories        <- map["childCategories"]
    }
}

    class RankingProduct:Mappable {
        var id: Int?
        var viewCount, orderCount, shares: Int?
        init(){
            
        }
        
        // Convert Json string to class object
        func getObjectFromString(jsonResponse: AnyObject)->RankingProduct{
            var rankingProduct:RankingProduct?
            if jsonResponse is NSDictionary{
                let tempDic:NSDictionary? = (jsonResponse as! NSDictionary)
                if tempDic != nil{
                    let mapper = Mapper<RankingProduct>()
                    //if let testObject = mapper.map(tempDic){
                    if let testObject = mapper.map(JSON: tempDic as! [String : Any]){
                        rankingProduct = testObject
                    }
                }
            }
            return rankingProduct!
        }
        
        required init?(map: Map){
        }
        
        func mapping(map: Map){
            id                   <- map["id"]
            viewCount                   <- map["viewCount"]
            orderCount                   <- map["orderCount"]
            shares                   <- map["shares"]
            
        }
    }
}
