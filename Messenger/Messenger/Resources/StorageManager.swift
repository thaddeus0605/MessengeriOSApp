//
//  StorageManager.swift
//  Messenger
//
//  Created by Thaddeus Dronski on 9/10/23.
//

import Foundation
import FirebaseStorage

final class StorageManager {
    
    static let shared = StorageManager()
    
    private let storage = Storage.storage().reference()
    
    /*
     /images/useremail-gmail-com_profile_picture.png
     */
    
    public typealias UploadPictureCompletion = (Result<String, Error> ) -> Void
    
    //upload picture to firevase storage completion with url string to download

       public func uploadProfilePicture(with data: Data, fileName: String, completion: @escaping UploadPictureCompletion) {
           storage.child("images/\(fileName)").putData(data, metadata: nil, completion: { [weak self] metadata, error in
               guard let strongSelf = self else {
                   return
               }

               guard error == nil else {
                   // failed
                   print("failed to upload data to firebase for picture")
                   completion(.failure(StorageErrors.failedToUpload))
                   return
               }

               strongSelf.storage.child("images/\(fileName)").downloadURL(completion: { url, error in
                   guard let url = url else {
                       print("Failed to get download url")
                       completion(.failure(StorageErrors.failedToGetDownloadUrl))
                       return
                   }

                   let urlString = url.absoluteString
                   print("download url returned: \(urlString)")
                   completion(.success(urlString))
               })
           })
       }
    
    
    public enum StorageErrors: Error {
        case failedToUpload
        case failedToGetDownloadUrl
    }
    
    public func downloadUrl(for path: String,  completion: @escaping (Result<URL, Error>) -> Void) {
        let reference = storage.child("\(path)")
        print(reference)
        reference.downloadURL(completion: { url, error in
            guard let url = url, error == nil else {
                completion(.failure(StorageErrors.failedToGetDownloadUrl))
                return
            }
            completion(.success(url))
        })
    }
}
