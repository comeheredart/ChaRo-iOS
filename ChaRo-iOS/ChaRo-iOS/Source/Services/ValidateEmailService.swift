//
//  ValidateEmailService.swift
//  ChaRo-iOS
//
//  Created by JEN Lee on 2021/10/06.
//

import Foundation
import Alamofire

struct ValidateEmailService {
    
    static let shared = ValidateEmailService()
    
    private func makeParameter(email : String) -> Parameters
    {
        return ["userEmail" : email]
    }
    
    func postValidationNumber(email: String, completion : @escaping (NetworkResult<Any>) -> Void)
    {
        
        let URL = Constants.validateEmailURL
        let header : HTTPHeaders = ["Content-Type": "application/json"]
        
        let dataRequest = AF.request(URL,
                                     method: .post,
                                     parameters: makeParameter(email: email),
                                     encoding: JSONEncoding.default,
                                     headers: header)
        
        
        dataRequest.responseData { dataResponse in
            
            
            switch dataResponse.result {
            case .success:
                
                print("이메일 인증----- 데이터 요청 성공")
                guard let statusCode = dataResponse.response?.statusCode else {return}
                guard let value = dataResponse.value else {return}
                let networkResult = self.judgeStatus(by: statusCode, value)
                completion(networkResult)
                
            case .failure: completion(.pathErr)
                
            }
        }
        
    }
    
    
    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        
        let decoder = JSONDecoder()
        
        guard let decodedData = try? decoder.decode(ValidationEmailModel.self, from: data)
        else {
            print("패쓰에러")
            return .pathErr
        }
        
        switch statusCode {
        case 200:
            print("이메일 인증 --- 데이터 받기 성공")
            return .success(decodedData)
        case 400: return .requestErr(decodedData.msg)
        case 500: return .serverErr
        default: return .networkFail
        }
        
    }
}
