//
//  Servise.swift
//  qChat
//
//  Created by Highest on 18.10.2024.
//
import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore



class Servise{
    static let shared = Servise()
    
    init() {}
    
    
    
    
    func createNewUser(_ data: LoginField, comletion: @escaping (ResponseCode)->()){
        Auth.auth().createUser(withEmail: data.email, password: data.password) { [weak self] result, err in
            if err == nil {
                if result != nil {
                    let userId = result?.user.uid
                    let email = data.email
                    let data: [String: Any] = ["email":email]
                    
                    Firestore.firestore().collection("users").document(userId!).setData(data)
                    
                    comletion(ResponseCode(code: 1))
                }
            }else{
                comletion(ResponseCode(code: 0))
            }
        }
    }
    func confimEmail(){
        
        Auth.auth().currentUser?.sendEmailVerification(completion: { err in
            if err != nil{
                print(err!.localizedDescription)
            }
        })
    }
    func authInApp(_ data:LoginField, comletion: @escaping(AuthResponse)-> ()){
        Auth.auth().signIn(withEmail: data.email, password: data.password) { result, err in
            if err != nil {
                comletion (.error)
            } else {
                if let result = result {
                    if result.user.isEmailVerified{
                        comletion (.succes)
                    } else {
                        self.confimEmail()
                        comletion (.noVerify)
                        
                    }
                    
                    
                }
            }
            
        }
    }
    func getAllUsers(comletion: @escaping([CurentUser]) ->()) {
        guard let email = Auth.auth().currentUser?.email else { return }
        var curentUsers = [CurentUser]()
        Firestore.firestore().collection("users")
            .whereField("email", isNotEqualTo: email)
            .getDocuments { shap, err in
                if err == nil {
                    if let docs = shap?.documents {
                        for doc in docs {
                            let data = doc.data()
                            let userId = doc.documentID
                            let email = data["email"] as! String
                            curentUsers.append(CurentUser(id: userId, email: email))
                        }
                    }
                    comletion(curentUsers)
                }
            }
    }
    
    //MARK: -- Messeger
    func sendMessege(otherId: String?, convoId: String?, text: String, completion: @escaping(String)->()) {
        
        let ref =  Firestore.firestore()
        if let uid = Auth.auth().currentUser?.uid{
            if convoId == nil {
                let convoId = UUID().uuidString
                
                let selfData: [String: Any] = [
                    "date": Date(),
                    "otherId": otherId!
                ]
                
                let otherData: [String: Any] = [
                    "date": Date(),
                    "otherId": uid
                ]
                
                ref.collection("users")
                    .document(uid)
                    .collection("conversations")
                    .document(convoId)
                    .setData(selfData)
                
                ref.collection("users")
                    .document(otherId!)
                    .collection("conversations")
                    .document(convoId)
                    .setData(otherData)
                
                let msg: [String: Any] = [
                    "date": Date(),
                    "sender": uid,
                    "text": text
                ]
                let covnoInfo: [String: Any] = [
                    "date": Date(),
                    "selfSender": uid,
                    "otherSender": otherId!
                ]
                
                ref.collection("conversations")
                    .document(convoId)
                    .setData(covnoInfo) { err in
                        if let err = err{
                            print (err.localizedDescription)
                            return
                        }
                        ref.collection("conversations")
                            .document(convoId)
                            .collection("messages")
                            .addDocument(data: msg) { err in
                                if err == nil {
                                    completion(convoId)
                                }
                                
                            }
                    }
                
            } else {
                let msg: [String: Any] = [
                    "date": Date(),
                    "sender": uid,
                    "text": text
                ]
                ref.collection("conversations").document(convoId!)
                    .collection("messages").addDocument(data: msg) { err in
                        if err == nil {
                            completion(convoId!)
                        }
                    }
            }
            
            
        }
        
        
        
    }
    
    func updateConvo() {
        
    }
    
    func getConvoId(otherId: String, completion: @escaping(String)->()){
        if let uid = Auth.auth().currentUser?.uid{
            let ref = Firestore.firestore()
            
            ref.collection("users")
                .document(uid)
                .collection("conversations")
                .whereField("otherId", isEqualTo: otherId)
                .getDocuments { snap, err in
                    if err != nil {
                        return
                    }
                    if let snap = snap, !snap.documents.isEmpty{
                        let doc = snap.documents.first
                        if let convold = doc?.documentID{
                            completion(convold)
                        }
                    }
                }
        }
    }
    
    func getAllMessage(chatId: String, completion: @escaping ([Message]) ->()) {
        if let uid = Auth.auth().currentUser?.uid{
            let ref = Firestore.firestore()
            ref.collection("conversations")
                .document(chatId)
                .collection("messages")
                .limit(to: 50)
                .order(by: "date", descending: false)
                .addSnapshotListener { snap, err in
                    if err != nil {
                        return
                    }
                    if let snap = snap, !snap.documents.isEmpty {
                        var msgs = [Message]()

                        var sender = Sender(senderId: uid, displayName: "")
                        for doc in snap.documents {
                            let data = doc.data()
                            let userId = data["sender"] as! String
                            let messageId = doc.documentID
                            
                            let date = data["date"] as! Timestamp
                            let sentDate = date.dateValue()
                            let text = data["text"] as! String
                            
                            if userId == uid {
                                sender = Sender(senderId: "1", displayName: "")
                            } else {
                                sender = Sender(senderId: "2", displayName: "")
                            }
                            
                          
                            msgs.append(Message(sender: sender, messageId: messageId, sentDate: sentDate, kind: .text(text)))
                        }
                        completion(msgs)
                    }
                }
        }
    }
    
    func getOneMessage() {
        
    }

}
