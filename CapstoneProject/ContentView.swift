//
//  ContentView.swift
//  CapstoneProject
//
//  Created by Prraneth Kumar A R on 08/10/22.
//

import SwiftUI

struct storing: Identifiable{
    var id = UUID()
    var name: String
    var checkBox: Bool
    var strikeThrough: Bool
}




struct ContentView: View {
    
    @State private var textToAdd = ""
    @State private var activityList = [storing(name: "sdfs", checkBox: false, strikeThrough: false)]
    @State var emptyAlert = false
    @State var selectedIndex = 0
    @State var index = 0
    
   
    
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
                        ForEach($activityList) { $task in
                            
                            if !task.checkBox {
                                HStack{
                                    Image(systemName: task.checkBox ?  "checkmark.square" : "square")
                                        .onTapGesture {
                                            task.checkBox.toggle()
                                            task.strikeThrough.toggle()
                                        }
                                        .foregroundColor(Color.blue).imageScale(.large)
                                    Text(task.name)
                                        .strikethrough(task.strikeThrough, pattern: .dashDot  , color: .red )
                                }
                            }
                        }
                        .onDelete(perform: removeRows)
                        .onMove(perform: move)
                    } header: {
                        Text("LIST TO BE DONE")
                    }
                    Section{
                        ForEach($activityList) { $task in
                            
                            if task.checkBox {
                                HStack{
                                    Image(systemName: task.checkBox ?  "checkmark.square" : "square")
                                        .onTapGesture {
                                            task.checkBox.toggle()
                                            task.strikeThrough.toggle()
                                        }
                                        .foregroundColor(Color.blue).imageScale(.large)
                                    Text(task.name)
                                        .strikethrough(task.strikeThrough, pattern: .dashDot  , color: .red )
                                }
                            }
                        }
                        .onDelete(perform: removeRows)
                        .onMove(perform: move)
                    }header: {
                        Text("COMPLETED LIST")
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
            activityList.append(storing(name: textToAdd, checkBox: false,strikeThrough: false))
            textToAdd = ""
            return
        }
        emptyAlert.toggle()
        
    }
    
    func gestureTapp(value: storing){
        //value.checkBox = true
        print(value.checkBox)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
