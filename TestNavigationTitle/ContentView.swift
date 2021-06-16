//
//  ContentView.swift
//  TestNavigationTitle
//
//  Created by Fabio Silva on 11/06/21.
//

import SwiftUI
import Combine

let colors: [Color] = [.blue, .gray, .green, .orange, .pink, .purple, .red, .yellow, .blue, .gray, .green, .orange, .pink, .purple, .red, .yellow]

struct ContentView: View {
    
    @State var isInEditMode: Bool = false
    @State var tab: Tab = .detail

    var titleDisplayMode: NavigationBarItem.TitleDisplayMode {
        isInEditMode ? .inline : .large
    }

    var body: some View {
        NavigationView(content: {
            
            VStack {
                
                Text("Some Texts")
                    .font(.largeTitle)

                Divider()

                Text("""
                    Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
                    """)
                
                Divider()
                
                Text("""
                    Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
                    """)

            }
            .padding()
            
            VStack {
                Spacer()
//                    .frame(height: isInEditMode ? 30 : .zero)

                if !isInEditMode {
                    tabsView
                }

                colorsView(isInEdit: $isInEditMode)
                    .navigationTitle(self.isInEditMode ? "Edit" : "Colors")
                    .navigationBarTitleDisplayMode(titleDisplayMode)
                    .navigationBarItems(
                        leading: Button("Cancel", action: {
                            withAnimation {
                                    self.isInEditMode = false
                            }
                        })
                            .disabled(!self.isInEditMode),
                        trailing: Button("Edit", action: { self.isInEditMode = true })
                            .disabled(self.isInEditMode))
            }
        })
    }
    
    var tabsView: some View {
        Picker(selection: $tab, label: Text("Tab")) {
            ForEach(Tab.allCases, id: \.self) { Text($0.rawValue).tag($0) }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(5)
    }

}

enum Tab: String, CaseIterable {
    case detail = "Detail"
    case activity = "Activity"
    case files = "Files"
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct colorsView: View {
    @Binding var isInEdit: Bool
    
    var body: some View {
        VStack {
            if isInEdit {
                colorsReadView()
            } else {
                colorsEditView()
            }
        }
    }
}

struct colorsReadView: View {
    @State var data: [Color] = colors

    var body: some View {
        ScrollView {
            ForEach(data, id: \.self) { color in
                Rectangle()
                    .frame(height: 150)
                    .foregroundColor(color)
            }
        }
        .padding()
    }
}

struct colorsEditView: View {
    @State var data: [Color] = colors

    var body: some View {
        ScrollView {
            ForEach(data, id: \.self) { color in
                Rectangle()
                    .frame(height: 150)
                    .foregroundColor(color)
            }
        }
        .padding()
    }
}
