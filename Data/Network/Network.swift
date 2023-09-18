//
//  Network.swift
//  Data
//
//  Created by Ashkan Ghaderi on 2022-02-03.
//

import Domain
import Alamofire
import RxSwift


public class Network {
    
    private let endPoint: String
    private let scheduler: ConcurrentDispatchQueueScheduler
    private var tokenString: String {
        return "fsq3kq/UF9KQ4qn2UIGjSpLP92ZNp2g64WJWFCQoGd98jFE="
    }
    private var sharedHeaders: HTTPHeaders{
        return ["Accept": "application/json","Authorization":tokenString]
    }
    
    let disposeBag = DisposeBag()
    init(_ endPoint: String) {
        self.endPoint = endPoint
        self.scheduler = ConcurrentDispatchQueueScheduler(qos: DispatchQoS(qosClass: DispatchQoS.QoSClass.background, relativePriority: 1))
    }
    
    func getItems<T: Codable>(_ path: String, itemId: String = "") -> Observable<[T]> {
        let absolutePath = itemId == "" ? endPoint + path : endPoint + "\(path)?\(itemId)"
        
        print(">>> Service : " ,absolutePath )
        return Observable<[T]>.create { observer in
            AF.request(absolutePath,
                                                     method: .get,
                                                     headers: self.sharedHeaders)
                .validate()
                .responseJSON { (response) in
                    let decoder = JSONDecoder()
                    switch response.result {
                    case .success:
                        if let data = response.data {
                            
                            if let value = try? decoder.decode([T].self, from: data) {
                                
                                observer.onNext(value)
                                observer.onCompleted()
                                print("success",value)
                            }
                            
                        }
                    case .failure(let error):
                        
                        if let data = response.data {
                            
                            if let value = try? decoder.decode(CustomError.self, from: data) {
                                
                                observer.onError(BaladError.failure(message: value.message))
                                
                                print("failure",value)
                            }
                            
                        }
                        observer.onError(BaladError.failure(message: error.localizedDescription))
                        print("failure",error)
                    }
                }
            return Disposables.create()
        }
        
        
    }
    
    func getItem<T: Codable>(_ path: String, itemId: String = "") -> Observable<T> {
        let absolutePath = itemId == "" ? endPoint + path : endPoint + "\(path)?\(itemId)"
        
        print(">>> Service : " ,absolutePath )
        return Observable<T>.create { observer in
            AF.request(absolutePath,
                                                     method: .get,
                                                     headers: self.sharedHeaders)
                .validate()
                .responseJSON { (response) in
                    let decoder = JSONDecoder()
                    switch response.result {
                    case .success:
                        if let data = response.data {
                            
                            if let value = try? decoder.decode(T.self, from: data) {
                                
                                observer.onNext(value)
                                observer.onCompleted()
                                print("success",value)
                            }
                            
                        }
                    case .failure(let error):
                        
                        if let data = response.data {
                            
                            if let value = try? decoder.decode(CustomError.self, from: data) {
                                
                                observer.onError(BaladError.failure(message: value.message))
                                
                                print("failure",value)
                            }
                            
                        }
                        observer.onError(BaladError.failure(message: error.localizedDescription))
                    }
                }
            return Disposables.create()
        }
        
    }
    
    func deleteItem<T: Codable>(_ path: String, itemId: String = "") -> Observable<T> {
        let absolutePath = itemId == "" ? endPoint + path : endPoint + "\(path)?\(itemId)"
        
        print(">>> Service : " ,absolutePath )
        return Observable<T>.create { observer in
            AF.request(absolutePath,
                                                     method: .delete,
                                                     headers: self.sharedHeaders)
                .validate()
                .responseJSON { (response) in
                    let decoder = JSONDecoder()
                    switch response.result {
                    case .success:
                        if let data = response.data {
                            
                            if let value = try? decoder.decode(T.self, from: data) {
                                
                                observer.onNext(value)
                                observer.onCompleted()
                                print("success",value)
                            }
                            
                        }
                    case .failure(let error):
                        
                        if let data = response.data {
                            
                            if let value = try? decoder.decode(CustomError.self, from: data) {
                                
                                observer.onError(BaladError.failure(message: value.message))
                                
                                print("failure",value)
                            }
                            
                        }
                        observer.onError(BaladError.failure(message: error.localizedDescription))
                    }
                }
            return Disposables.create()
        }
        
    }
    
    func postItem<T: Decodable>(url: String,
                                param: Parameters? = nil,
                                method: HTTPMethod = .post,
                                encoding: ParameterEncoding = JSONEncoding.default) -> Observable<T> {
        
        
        let absolutePath = endPoint + url
        print(">>> Service : " ,absolutePath , ":::" ,param as Any)
        return Observable<T>.create { observer in
            AF.request(absolutePath,
                                                     method: .post,
                                                     parameters: param,
                                                     encoding: encoding,
                                                     headers: self.sharedHeaders)
                .validate()
                .responseJSON { (response) in
                    let decoder = JSONDecoder()
                    switch response.result {
                    case .success:
                        if let data = response.data {
                            
                            if let value = try? decoder.decode(T.self, from: data) {
                                
                                observer.onNext(value)
                                observer.onCompleted()
                                print("success",value)
                            }
                            
                        }
                    case .failure(let error):
                        
                        if let data = response.data {
                            
                            if let value = try? decoder.decode(CustomError.self, from: data) {
                                
                                observer.onError(BaladError.failure(message: value.message))
                                
                                print("failure",value)
                            }
                            
                        }
                        observer.onError(BaladError.failure(message: error.localizedDescription))
                        print("failure",error)
                    }  
                }
            return Disposables.create()
        }
    }
    
    
    func putItem<T: Codable>(_ path: String, param: [String: Any],
                             encoding: ParameterEncoding = JSONEncoding.default) -> Observable<T> {
        let absolutePath = endPoint + path
        print("PUT: \non: \(absolutePath)\nparameters: \(param)")
        
        print(">>> Service : " ,absolutePath , ":::" ,param as Any)
        return Observable<T>.create { observer in
            AF.request(absolutePath,
                                                     method: .put,
                                                     parameters: param,
                                                     encoding: encoding,
                                                     headers: self.sharedHeaders)
                .validate()
                .responseJSON { (response) in
                    let decoder = JSONDecoder()
                    switch response.result {
                    case .success:
                        if let data = response.data {
                            
                            if let value = try? decoder.decode(T.self, from: data) {
                                
                                observer.onNext(value)
                                observer.onCompleted()
                                print("success",value)
                            }
                            
                        }
                    case .failure(let error):
                        
                        if let data = response.data {
                            
                            if let value = try? decoder.decode(CustomError.self, from: data) {
                                
                                observer.onError(BaladError.failure(message: value.message))
                                
                                print("failure",value)
                            }
                            
                        }
                        observer.onError(BaladError.failure(message: error.localizedDescription))
                        print("failure",error)
                    }
                }
            return Disposables.create()
        }
    }
    
    func postItems<T: Codable>(_ path: String, param: [String: Any],
                               encoding: ParameterEncoding = JSONEncoding.default) -> Observable<[T]> {
        
        let absolutePath = endPoint + path
        print(">>> Service : " ,absolutePath , ":::" ,param as Any)
        return Observable<[T]>.create { observer in
            AF.request(absolutePath,
                                                     method: .post,
                                                     parameters: param,
                                                     encoding: encoding,
                                                     headers: self.sharedHeaders)
                .validate()
                .responseJSON { (response) in
                    let decoder = JSONDecoder()
                    switch response.result {
                    case .success:
                        if let data = response.data {
                            
                            if let value = try? decoder.decode([T].self, from: data) {
                                
                                observer.onNext(value)
                                observer.onCompleted()
                                print("success",value)
                            }
                            
                        }
                    case .failure(let error):
                        
                        if let data = response.data {
                            
                            if let value = try? decoder.decode(CustomError.self, from: data) {
                                
                                observer.onError(BaladError.failure(message: value.message))
                                
                                print("failure",value)
                            }
                            
                        }
                        observer.onError(BaladError.failure(message: error.localizedDescription))
                        print("failure",error)
                    }
                }
            return Disposables.create()
        }
    }
}
