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
}


enum Sections: String, CaseIterable {
    case pending = "List To Be Done"
    case completed = "Completed Activity"
}


struct ContentView: View {
    
    @State private var textToAdd = ""
    @State private var activityList = [storing(name: "sdfs", checkBox: false)]
    @State var emptyAlert = false
    // @State var isCompletedBox = false
    @State var selectedIndex = 0
    @State var index = 0
   // @Binding var storingCheck: storing
    
    var pendingTasks: [Binding<storing>] {
        $activityList.filter { !$0.checkBox.wrappedValue }
    }
    
    var completedTasks: [Binding<storing>] {
        $activityList.filter { $0.checkBox.wrappedValue }
    }
    
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
                    ForEach(Sections.allCases, id: \.self) { section in
                        Section {
                            let filteredTasks = section == .pending ? pendingTasks: completedTasks
                            if filteredTasks.isEmpty {
                                Text("No tasks available.")
                            }
                            Section{
                                ForEach(filteredTasks) { $task in
                                    HStack{
                                        Image(systemName: task.checkBox ?  "checkmark.square" : "square")
                                            .onTapGesture {
                                                task.checkBox.toggle()
                                            }
                                            .foregroundColor(Color.blue).imageScale(.large)
                                        Text(task.name)
                                    }
                                }
                                .onDelete(perform: removeRows)
                                .onMove(perform: move)
                            }
                        }header: {
                            Text(section.rawValue)
                        }
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
            activityList.append(storing(name: textToAdd, checkBox: false))
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
