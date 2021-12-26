//MARK: made by Jack

import Alamofire
import Foundation

struct MypageInfinityService
{
    var userId = UserDefaults.standard.string(forKey: "userId") ?? "ios@gmail.com"
    
    static let MyPageInfinityData = MypageInfinityService()
    func getRecommendInfo(addURL: String, likeOrNew: String, completion : @escaping (NetworkResult<Any>) -> Void)
    {
        // completion 클로저를 @escaping closure로 정의합니다.
        var URL = Constants.myPageURL + likeOrNew + userId + addURL;
        let header : HTTPHeaders = ["Content-Type": "application/json"]
        let dataRequest = AF.request(URL,
                                     method: .get,
                                     encoding: JSONEncoding.default,
                                     headers: header)

        dataRequest.responseData { dataResponse in
//            dump(dataResponse)
            switch dataResponse.result {
            
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else {return}
                guard let value = dataResponse.value else {return}
                let networkResult = self.judgeStatus(by: statusCode, value)
                completion(networkResult)

            
            case .failure: completion(.pathErr)
                print("실패 사유")

                
            }
        }
                                            
    }
    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode {
        case 200: return isValidData(data: data)
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }
    
    private func isValidData(data : Data) -> NetworkResult<Any> {
        
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(MypageInpinityModel.self, from: data)
        else {return .pathErr}
        // 우선 PersonDataModel 형태로 decode(해독)을 한번 거칩니다. 실패하면 pathErr
        // 해독에 성공하면 Person data를 success에 넣어줍니다.        
        
        
        return .success(decodedData)

    }
    
}
