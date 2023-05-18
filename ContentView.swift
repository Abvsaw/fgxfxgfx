import SwiftUI

struct ContentView: View {
    @State var isOn = false
    var body: some View {
        VStack {
            Circle()
                .frame(maxHeight: 200)                .foregroundColor(/*#-code-walkthrough(conditionalCircle.ternary)*/ isOn ? .primary : .secondary /*#-code-walkthrough(conditionalCircle.ternary)*/)        .shadow(color: isOn ? .red : .orange, radius:20)
            /*#-code-walkthrough(conditionalCircle.foregroundColor)*/
                .scaleEffect(isOn ? 1:0.75)
                .animation(.easeIn, value: isOn)
            if isOn{
                Text("on")
            }
            else{
                Text("of")
            }
            
            Button("Press Me") {
                isOn.toggle()
            }
        }
    }       
    
}
