//
//  PostResultService.swift
//  ChaRo-iOS
//
//  Created by 장혜령 on 2021/07/14.
//

import Foundation
import Alamofire

struct PostResultService {
    
    static let shared = PostResultService()
    let header : HTTPHeaders = ["Content-Type" : "application/json"]
    
    
    //userId, region, theme, warning
    private func makeParameter(region: String, theme: String, warning: String ) -> Parameters {
        return  ["region" : region, "theme": theme, "warning" : warning , "userEmail" : Constants.userEmail]
    }
    
    func postSearchKeywords(region: String,
                            theme: String,
                            warning: String,
                            type: String,
                            completion: @escaping (NetworkResult<Any>) -> Void){
        print("보낼 URL = \(Constants.searchPostURL+type)")
        let parameter = makeParameter(region: region,
                                      theme: theme,
                                      warning: warning)
        print("request body : \(parameter)")
        let dataRequest = AF.request(Constants.searchPostURL+type,
                                     method: .post,
                                     parameters: makeParameter(region: region,
                                                               theme: theme,
                                                               warning: warning),
                                     encoding: JSONEncoding.default,
                                     headers: header)
        
        dataRequest.responseData{ dataResponse in
            switch dataResponse.result{
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else { return}
                guard let value = dataResponse.value  else {return}
                let networkResult = self.judgeStatus(by: statusCode, value)
                completion(networkResult)
                
            case .failure(_): completion(.pathErr)
            }
        }
    }
    
    func getPostDetail(postId : Int,
                        completion: @escaping (NetworkResult<Any>) -> Void){
       
        
        
        let dataRequeat = AF.download(Constants.detailPostURL+"\(postId)",
                                      method: .get,
                                      encoding: JSONEncoding.default,
                                      headers: header)
        
        dataRequeat.responseData{ dataResponse in
            switch dataResponse.result{
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else { return}
                guard let value = dataResponse.value  else {return}
                let networkResult = self.judgeStatusPostDetail(by: statusCode, value)
                completion(networkResult)
                
            case .failure(_): completion(.pathErr)
            }
        }
        
    }
    
    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        print("status code = \(statusCode)")
        guard let decodeData = try? decoder.decode(GenericResponse<Drive>.self, from: data) else {
            print("여기서 문제?")
            return .pathErr
        }
        
        switch statusCode {
        case 200: return .success(decodeData.data)
        case 400: return .requestErr(decodeData)
        case 500: return .serverErr
        default:
            return .networkFail
        }
    }
    
    private func judgeStatusPostDetail(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        guard let decodeData = try? JSONDecoder().decode(GenericResponse<PostDetailData>.self, from: data) else {
            print("-----------여기서 걸리는 건가?")
            return .pathErr
        }
        
        switch statusCode {
        case 200: return .success(decodeData.data)
        case 400: return .requestErr(decodeData.data)
        case 500: return .serverErr
        default:
            return .networkFail
        }
    }
}
