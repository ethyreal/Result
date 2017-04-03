//
//  Result.swift
//  Result
//
//  Created by George Webster on 4/2/17.
//  Copyright © 2017 George Webster. All rights reserved.
//

import Foundation

enum Result<T> {
    
    case success(T)
    case failure(Error)
    
}

// MARK:- Accessors

extension Result {
    
    var isSuccess:Bool {
        switch self {
        case .success: return true
        case .failure: return false
        }
    }
    
    var isFailure:Bool {
        switch self {
        case .success: return false
        case .failure: return true
        }
    }
    
    var error:Error? {
        switch self {
        case let .failure(error):
            return error
        case .success:
            return nil
        }
    }
    
    var value:T? {
        switch self {
        case .success( let value):
            return value
        case .failure:
            return nil
        }
    }

}

// MARK:- Monadic Transforms

extension Result {

    func map<U>(_ transform: (T) throws -> U) -> Result<U> {
        
        switch self {
        case let .failure(error):
            return .failure(error)
        case let .success(value):
            do {
                return .success( try transform(value) )
            }
            catch let error {
                return .failure(error)
            }
        }
    }

    func flatMap<U>(_ transform:(T) -> Result<U>) -> Result<U> {
        
        switch self {
        case let .failure(error):
            return .failure(error)
        case let .success(value):
            return transform(value)
        }
    }
    
}


extension Result: CustomDebugStringConvertible {
    
    var debugDescription: String {
        switch self {
        case let .success(value):
            return "Result.success( \(value) )"
        case let .failure(error):
            return "Result.failure( \(error) )"
        }
    }
}



