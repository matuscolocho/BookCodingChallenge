//
//  HttpHelper.swift
//  EBooks
//
//  Created by JoshuaMatus on 17/12/21.
//

import Foundation

class HttpHelper:NSObject{
    class func urlForEnvironmnet()->String{
        
        if (Bundle.main.object(forInfoDictionaryKey: "isDebug") as? NSNumber)?.boolValue ?? false {
            return baseUrl.qa
        } else {
            return baseUrl.production
        }
        
    }
    
    
    class func fetchBooks(completion: @escaping (_ books:[Book]) -> ()){
 
        let urlRequest = "\(urlForEnvironmnet())/\(boosksApi.books)"
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: URL(string: urlRequest)!),
                                              completionHandler: { data, response, error in
            guard error == nil else {return}
            guard let data = data else { return }
            do {
                let results = try JSONDecoder().decode([Book].self, from: data)
                
                DispatchQueue.main.async {
                    completion(results )
                }
               
            } catch let err {
                debugPrint(err)
                completion([])
                
            }
        })

        task.resume()
       
    }
}
