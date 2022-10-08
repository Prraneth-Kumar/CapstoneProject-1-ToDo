//
//  ContentView.swift
//  CapstoneProject
//
//  Created by Prraneth Kumar A R on 08/10/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var textToAdd = ""
    @State private var activityList = [String]()
    @State var emptyAlert = false
    
    
    var body: some View {
        
        NavigationView {
            ZStack{
                List {
                    HStack{
                        TextField("Enter Activity To Add", text: $textToAdd).onSubmit {
                            addText()
                        }
                        if textToAdd != "" {
                            Button(){
                                addText()
                            }label:{
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(Color.green).imageScale(.large)
                            }
                        }
                    }
                    Section{
                        if activityList.isEmpty {
                            Text("No Activity Is To Be Done")
                        }
                        ForEach(activityList, id: \.self) {
                            Text($0)
                        }//.onDelete(perform: )
                        .onDelete(perform: removeRows)
                        .onMove(perform: move)
                     //   .strikethrough(emptyAlert, color: .black)


                    }header:{
                        Text("List To Be Done")
                    }
                }.toolbar(){
                    EditButton()
                }//.listStyle(GroupedListStyle())
                .listStyle(.grouped)

                Button(){
                    addText()
                }label:{
                    Text("Add")
                        .padding()
                        .frame(width: .infinity, height: 50)
                        .background(.green)
                        .cornerRadius(20)
                        .foregroundColor(.white)
                        .font(Font.title.weight(.semibold))
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
                .navigationTitle("TodoList")
                .navigationBarTitleDisplayMode(.inline)
                
            }.alert(isPresented: $emptyAlert){
                Alert(title: Text("Enter Activity"),
                      message: Text("The TextField is Empty"),
                      primaryButton: .cancel(Text("Cancel")),
                      secondaryButton: .destructive(Text("Close"))
                )
            }
            
        }
    }
    func removeRows(at offsets: IndexSet) {
        activityList.remove(atOffsets: offsets)
    }
    
    func move(from source: IndexSet, to destination: Int) {
        activityList.move(fromOffsets: source, toOffset: destination)
    }
    
    func addText(){
        guard textToAdd.isEmpty else{
            activityList.append(textToAdd)
            textToAdd = ""
            return
        }
        emptyAlert.toggle()
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
