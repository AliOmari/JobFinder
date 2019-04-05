//
//  APIClient.swift
//  JobFinder
//
//  Created by Ali Omari on 4/4/19.
//  Copyright © 2019 Ali Omari. All rights reserved.
//

import Foundation
import Alamofire

public enum SwiftBaseErrorCode: Int {
    case inputStreamReadFailed           = -6000
    case outputStreamWriteFailed         = -6001
    case contentTypeValidationFailed     = -6002
    case statusCodeValidationFailed      = -6003
    case dataSerializationFailed         = -6004
    case stringSerializationFailed       = -6005
    case jsonSerializationFailed         = -6006
    case propertyListSerializationFailed = -6007
}

public typealias SuccessCallback = (_ responseObject: Any, _ responseHeaders: [AnyHashable: Any]) -> Void
public typealias FailureCallback = (_ error: Error) -> Void

class APIClient {
    private static var acceptableStatusCode:[Int]{
        get{
            return Array(200..<300)
        }
    }
    
    //Recursively build multipart params to send along with media in upload requests.
    //If params includes the desired root key, call this method with an empty String for rootKey param.
    class func multipartFormData(_ multipartForm: MultipartFormData, params: Any, rootKey: String) {
        switch params.self {
        case let array as [Any]:
            for val in array {
                let forwardRootKey = rootKey.isEmpty ? "array[]" : rootKey + "[]"
                multipartFormData(multipartForm, params: val, rootKey: forwardRootKey)
            }
        case let dict as [String: Any]:
            for (k, v) in dict {
                let forwardRootKey = rootKey.isEmpty ? k : rootKey + "[\(k)]"
                multipartFormData(multipartForm, params: v, rootKey: forwardRootKey)
            }
        default:
            if let uploadData = "\(params)".data(using: String.Encoding.utf8, allowLossyConversion: false) {
                let forwardRootKey = rootKey.isEmpty ? "\(type(of: params))".lowercased() : rootKey
                multipartForm.append(uploadData, withName: forwardRootKey)
            }
        }
    }
    
    class func defaultEncoding(forMethod method: HTTPMethod) -> ParameterEncoding {
        switch method {
        case .post, .put:
            return JSONEncoding.default
        default:
            return URLEncoding.default
        }
    }
    
    class func request(_ method: HTTPMethod, url: String, params: [String: Any]? = nil, paramsEncoding: ParameterEncoding? = nil, success: @escaping SuccessCallback, failure: @escaping FailureCallback) {
        let encoding = paramsEncoding ?? defaultEncoding(forMethod: method)

        var requestUrl = url
        
        if method == .get{
            requestUrl.append("?")
            if let parameters = params{
                for param in parameters{
                    requestUrl.append(param.key)
                    requestUrl.append("=")
                    requestUrl.append("\(param.value)")
                    requestUrl.append("&")
                }
            }
        }

        requestUrl.removeLast()
        
        Alamofire.request(requestUrl, method: method, parameters: method == .get ? nil : params, encoding: encoding)
            .validate(statusCode :APIClient.acceptableStatusCode)
            .response { response in
                validateResult(ofResponse: response, success: success, failure: failure)
        }
    }
    
    fileprivate class func validateResult(ofResponse response: DataResponse<Any>,
                                          success: @escaping SuccessCallback,
                                          failure: @escaping FailureCallback) {
        
        switch response.result {
        case .success(let data):
            if let urlResponse = response.response {
                success(data , urlResponse.allHeaderFields)
            }
            return
        case .failure(let error):
            failure(error)
        }
    }
}

private let emptyDataStatusCodes: Set<Int> = [204, 205]
// MARK: - DataRequest
extension DataRequest {
    public static func response() -> DataResponseSerializer<Any> {
        return DataResponseSerializer { _, response, data, requestError in
            let emptyResponseAllowed = emptyDataStatusCodes.contains(response?.statusCode ?? 0)
            guard let data = data, !data.isEmpty else {
                return emptyResponseAllowed ? .success([:]) : .failure(AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength))
            }
            var dictionary: [String: Any]?
            var array: [Any]?
            var raw: String?
            
            var dicSerializationError: NSError?
            var arraySerializationError: NSError?

            do {
                dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
            } catch let exceptionError as NSError {
                dicSerializationError = exceptionError
            }
            
            if dicSerializationError != nil || dictionary == nil{
                do {
                    array = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [Any]
                } catch let exceptionError as NSError {
                    arraySerializationError = exceptionError
                }
                if arraySerializationError != nil || array == nil{
                    raw = String(data: data, encoding: .utf8)
                }
            }
            
            if dicSerializationError == nil && dictionary != nil{
                return .success(dictionary ?? [:])
            }else if arraySerializationError == nil && array != nil{
                return .success(array ?? [])
            }else if raw != nil{
                return .success(raw ?? "")
            }
            
            if dicSerializationError != nil {
                return .failure(dicSerializationError!)
            }else if arraySerializationError != nil{
                return .failure(arraySerializationError!)
            }else{
                return .failure(NSError(domain: "", code: 500, userInfo: nil))
            }
        }
    }
    
    @discardableResult
    func response(
        _ queue: DispatchQueue? = nil,
        completionHandler: @escaping (DataResponse<Any>) -> Void) -> Self {
        return response(
            queue: queue,
            responseSerializer: DataRequest.response(),
            completionHandler: completionHandler
        )
    }
}
