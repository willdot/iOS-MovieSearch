//
//  HttpHandler.swift
//  favourite-movies-app
//
//  Created by Will Andrews on 11/07/2018.
//  Copyright © 2018 Will Andrews. All rights reserved.
//

import Foundation

class HTTPHandler {
    static func getJson(urlString: String, completionHandler: @escaping (Data?) -> (Void)) {
        let urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        let url = URL(string: urlString!)
        
        print("Url being using is \(url!)")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, response, error in
            if let data = data {
                let httpResponse = response as! HTTPURLResponse
                let statusCode = httpResponse.statusCode
                print("request completed with code: \(statusCode)")
                
                if (statusCode == 200) {
                    print("return to completion handler with the data")
                    completionHandler(data as Data)
                }
            } else if let error = error {
                print("***There was an error making the http request***")
                print(error.localizedDescription)
                completionHandler(nil)
            }
        }
        task.resume()
    }
}
