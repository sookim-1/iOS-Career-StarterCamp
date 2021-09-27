//
//  PatchUpdateArticle.swift
//  OpenMarket
//
//  Created by sookim on 2021/05/14.
//

import Foundation

class PatchUpdateArticle {
    
    private let manageMultipartForm: MultipartFormManagable
    private let urlProcess: URLProcessUsable
    
    init(manageMultipartForm: MultipartFormManagable, urlProcess: URLProcessUsable) {
        self.manageMultipartForm = manageMultipartForm
        self.urlProcess = urlProcess
    }
    
    func patchData(urlRequest: URLRequest?, requestBody: Data, completion: @escaping (Bool) -> Void) {
        guard let request = urlRequest else { return }
        
        URLSession.shared.uploadTask(with: request, from: requestBody) { (data, response, error) in
            if error != nil { return }
            if self.urlProcess.checkResponseCode(response: response) {
                print("patch성공")
                completion(true)
            }
            else {
                print("patch 실패")
                completion(false)
            }
        }.resume()
    }
    
    func updateRequestBody(formdat: UpdateArticle ,boundary: String, imageData: Data) -> Data {
        var httpBody = Data()
        
        httpBody.appendString(manageMultipartForm.convertFormField(name: "title", value: formdat.title!, boundary: boundary))
        httpBody.appendString(manageMultipartForm.convertFormField(name: "descriptions", value: formdat.descriptions!, boundary: boundary))
        httpBody.appendString(manageMultipartForm.convertFormField(name: "price", value: "\(formdat.price!)", boundary: boundary))
        httpBody.appendString(manageMultipartForm.convertFormField(name: "currency", value: formdat.currency!, boundary: boundary))
        httpBody.appendString(manageMultipartForm.convertFormField(name: "stock", value: "\(formdat.stock!)", boundary: boundary))
        httpBody.appendString(manageMultipartForm.convertFormField(name: "discounted_price", value: "\(formdat.discountedPrice!)", boundary: boundary))
        httpBody.append(manageMultipartForm.convertFileData(fieldName: "images[]", fileName: "github.png", mimeType: "image/png", fileData: imageData, boundary: boundary))
        httpBody.appendString(manageMultipartForm.convertFormField(name: "password", value: formdat.password, boundary: boundary))
        httpBody.appendString("--\(boundary)--")
        
        return httpBody
    }
    
}
