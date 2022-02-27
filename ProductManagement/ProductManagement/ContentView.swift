
import SwiftUI
import Foundation

class DownloadDataModel: ObservableObject{
    
    @Published var ProductArray = [WelcomeElement]()
    
    init() {
        
        getFriends()
        
    }
    
    func getFriends(){
        
        var request = URLRequest(url: URL(string: "https://assessment-edvora.herokuapp.com")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                
                return
            }
            // print(String(data: data, encoding: .utf8)!)
            
            if let jsonResponse = try? JSONDecoder().decode([WelcomeElement].self, from: data) {
                DispatchQueue.main.async {
                    self.ProductArray = jsonResponse
                    print(jsonResponse)
                }
                
            }
        }
        
        task.resume()
        
    }
    
}

struct ContentView: View {
    
    @StateObject var vm = DownloadDataModel()
    
    @State var show = false
    
    var body: some View {
        
        
        ZStack {
            
            Color("CustomColor2")
                .edgesIgnoringSafeArea(.all)
            VStack{
                
                VStack{
                    
                    HStack(spacing: 50){
                        Text("Product Details")
                            .font(.system(size: 32 , weight: .bold))
                            .foregroundColor(.white)
                            .padding([.bottom, .trailing], 10)
                        Spacer()
                    }
                    
                    HStack {
                        
                        
                        HStack {
                            
                            Text("Filters").font(.system(size: 22)).padding()
                                .foregroundColor(Color.white)
                            
                            Spacer()
                            
                            Button {
                                withAnimation(.spring()){
                                    self.show.toggle()
                                }
                            } label: {
                                
                                Image(systemName: "arrowtriangle.down.fill").padding().foregroundColor(Color.white)
                            }
                        }.frame(width:150, height: 50).background(Color("CustomColor3"))
                            .shadow(radius: 10).cornerRadius(4)
                        
                        Spacer()
                        HStack {
                            
                            Text("clear Filter").foregroundColor(Color.white)
                            
                            
                        }.frame(width: 100, height: 35).background(Color("CustomColor3"))
                            .shadow(radius: 10).cornerRadius(4)
                        
                    }
                    
                    
                }.frame(width: 400, height: 100)
                
                if self.show{
                    POpOver()
                }
                
                ScrollView {
                    if vm.ProductArray.count>0{
                        ForEach(vm.ProductArray.indices) { Index in   LazyVStack{
                            Spacer().frame(minHeight: 20, maxHeight: 20)
                            Text("\(vm.ProductArray[0].product_name)").frame(alignment: .leading)
                                .font(.system(size: 20 , weight: .bold)).position(x: 80, y: 10).foregroundColor(Color.white)
                            
                            Divider().frame(height: 1).background(Color("CustomColor1")).padding(10)
                            
                            Spacer().frame(minHeight: 10, maxHeight: 10)
                            ForEach(vm.ProductArray.indices) { Index in
                                ScrollView(.horizontal,showsIndicators: false, content: {
                                    HStack{
                                        ForEach(vm.ProductArray.indices) { Index in
                                            VStack {
                                                HStack {
                                                    Spacer()
                                                    VStack{
                                                        Spacer()
                                                        AsyncImage(url: URL(string: "\(vm.ProductArray[0].image)"))
                                                            .frame(width: 90, height: 90)
                                                            .aspectRatio(contentMode: .fit)
                                                            .cornerRadius(0)
                                                        
                                                        Text("\(vm.ProductArray[0].address.city )").font(.system(size: 13))
                                                            .fontWeight(.none).foregroundColor(Color.white)
                                                        
                                                        Spacer()
                                                        Text("\(vm.ProductArray[0].discription )").font(.system(size: 8))
                                                            .fontWeight(.none).foregroundColor(Color.white)
                                                        Spacer()
                                                        Spacer()
                                                    }
                                                    VStack {
                                                        Spacer().frame(minHeight: 10, maxHeight: 30)
                                                        HStack  {
                                                            Text("\(vm.ProductArray[0].product_name )").foregroundColor(Color.white)
                                                                .font(.system(size: 13.9))
                                                            Spacer()
                                                        }
                                                        Spacer()
                                                        HStack{
                                                            Text("\(vm.ProductArray[0].brand_name )").font(.system(size: 13)).foregroundColor(Color.white)
                                                            Spacer()
                                                        }
                                                        Spacer()
                                                        HStack{
                                                            Text("$").font(.system(size: 16)).foregroundColor(Color.white)
                                                                .fontWeight(.semibold)
                                                            Text("\(vm.ProductArray[0].price)").font(.system(size: 13))
                                                                .fontWeight(.none).foregroundColor(Color.white)
                                                            Spacer()
                                                        }
                                                        Spacer()
                                                        HStack{
                                                            Text("Date").font(.system(size: 13)).foregroundColor(Color.white)
                                                                .fontWeight(.none)
                                                            Text("\(vm.ProductArray[0].date)").font(.system(size: 6))
                                                                .fontWeight(.none).foregroundColor(Color.white)
                                                            Spacer()
                                                        }
                                                        
                                                        Spacer()
                                                        Spacer().frame(minHeight: 10, maxHeight: 60)
                                                    }
                                                    Spacer()
                                                }
                                                .frame(width: 250, height: 185)
                                                .background(Color.secondary)
                                                .cornerRadius(10)
                                                
                                            }
                                        }
                                    }
                                })
                            }
                        }
                        }
                    }
                    
                }.padding()
                
            }
            
        }
        
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct POpOver : View {
    var body: some View{
        VStack(alignment: .center){
            VStack{
                Text("Filters").font(.system(size: 22)).padding()
            }
            Divider().frame(height: 1).background(Color("CustomColor1")).padding()
            
            Button(action: {
                
            }) {
                HStack(spacing : 15){
                    Text("Product")
                    Spacer()
                    Image(systemName: "arrowtriangle.down.fill")
                        .renderingMode(.original)
                }
            }
            .frame(width:150, height: 40).background(Color("CustomColor2")).cornerRadius(8)
            Button(action: {
                
            }) {
                HStack(spacing : 15){
                    Text("State")
                    Spacer()
                    Image(systemName: "arrowtriangle.down.fill")
                        .renderingMode(.original)
                }
            }
            .frame(width:155, height: 40).background(Color("CustomColor2")).cornerRadius(8)
            
            Button(action: {
                
            }) {
                HStack(spacing : 15){
                    Text("City")
                    Spacer()
                    Image(systemName: "arrowtriangle.down.fill")
                        .renderingMode(.original)
                }
                
            }
            
            .frame(width:155, height: 40).background(Color("CustomColor2")).cornerRadius(8)
            
        }
        .foregroundColor(Color.white)
        .frame(width: 165)
        .padding()
        .background(Color.black)
        .cornerRadius(12)
        
    }
}
