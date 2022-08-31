//
//  NetworkClient.swift
//  TestApp
//
//  Created by Владимир on 30.07.2022.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

protocol NetworkServiceDelegate: AnyObject {
    func fetchTracks(results: [Results])
}

class NetworkService {
    private weak var delegate: NetworkServiceDelegate?
    
    func setViewDelegate(networkDelegate: NetworkServiceDelegate) {
        self.delegate = networkDelegate
    }
    
    
    func getTracks(limit: Int) {
        fetchTracks(limit: limit, completion: { [weak self] results in
            guard let self = self else { return }
            self.delegate?.fetchTracks(results: results)
        })
    }
    
    
    private func fetchTracks(limit: Int, completion: @escaping ([Results]) -> Void)  {
        let url = "https://itunes.apple.com/search"
        let parameters = ["term":"Never",
                          "limit":"\(limit)",
                          "media":"music"]
        
        Alamofire.AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData { (dataResponse) in
            if let error = dataResponse.error {
                self.alert(message: error.localizedDescription)
                return
            }
            guard let data = dataResponse.data else { return }
            completion(self.parseJSON(data))
        }
    }
    
    private func parseJSON(_ data: Data) -> [Results] {
        var results = [Results]()
        
        if let json = try? JSON(data: data) {
            for item in json["results"].arrayValue {
                results.append(Results.init(json: item))
            }
        }
        return results
    }
    
    private func alert(message: String) {
        let ac = UIAlertController(title: "Error", message: message , preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else {return}
        
        
        ac.addAction(okAction)
        ac.addAction(cancelAction)
        
        rootViewController.present(ac, animated: true, completion: nil)
    }
}
