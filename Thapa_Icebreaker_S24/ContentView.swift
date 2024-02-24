//
//  ContentView.swift
//  Thapa_Icebreaker_S24
//
//  Created by Sudip Thapa on 2/6/24.
//

import SwiftUI
import FirebaseFirestore

struct ContentView: View {
    let db = Firestore.firestore()
    
    @State var txtFirstName: String = ""
    @State var txtLastName: String = ""
    @State var txtPrefName: String = ""
    @State var txtAnswer: String = ""
    @State var txtQuestion: String = ""
    
    @State var questions = [Question]()
    
    var body: some View {
        
        VStack {
            Text("Icebreaker App")
                .font(.system(size: 40))
                .bold()
            Text("Built with SwiftUI")
            
            TextField("First Name", text: $txtFirstName)
                .textFieldStyle(.roundedBorder)
                .border(.secondary)
                .font(.system(size: 18))
            
            
            TextField("Last Name", text: $txtLastName)
                .textFieldStyle(.roundedBorder)
                .border(.secondary)
                .font(.system(size: 18))
            
            
            
            TextField("Preferred Name", text: $txtPrefName)
                .textFieldStyle(.roundedBorder)
                .border(.secondary)
                .font(.system(size: 18))
            
            
            
            Button(action: { setRandomQuestion()
            }){
                Text("Get a new random question")
                    .font(.system(size: 24))
            }
            if(txtQuestion != ""){
                Text(txtQuestion)
                    .font(.system(size: 20)).padding()
            }

            
            TextField("Answer", text: $txtAnswer)
                .textFieldStyle(.roundedBorder)
                .border(.secondary)
                .font(.system(size: 18))
            
            
            Button(action: {
                if(txtAnswer != "") {
                    writeStudentToFirebase()
                }
                resetTextFields()
                
            })
            {
                Text("Submit")
                    .font(.system(size: 24)).padding(10)
            }
        }
        .font(.largeTitle)
        .autocorrectionDisabled(true)
        .padding()
        .onAppear(){
            getQuestionsFromFirebase()
        }
    }
    
    func setRandomQuestion(){
        print("Set random question pressed")
        let newQuestion = questions.randomElement()?.text
        if(newQuestion != nil){
            self.txtQuestion = newQuestion!
        }
    }
    
    func getQuestionsFromFirebase(){
        db.collection("questions")
            .getDocuments() {  (querySnapshot,err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        if let question = Question(id: document.documentID, data: document.data()){
                            self.questions.append(question)
                        }
                    }
                }
                
            }
    }
    
    func resetTextFields(){
        txtFirstName = ""
        txtLastName = ""
        txtPrefName = ""
        txtAnswer = ""
        txtQuestion = ""
    }
    
    func writeStudentToFirebase(){
        let data = ["first_name" : txtFirstName,
                    "last_name" : txtLastName,
                    "pref_name" : txtPrefName,
                    "question"  : txtQuestion,
                    "answer"    : txtAnswer,
                    "class"     : "ios-spring2024"] as [String : Any]
        
        var ref: DocumentReference? = nil
        ref = db.collection("students")
            .addDocument(data: data) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                }
            }
    }
}

#Preview {
    ContentView()
}
