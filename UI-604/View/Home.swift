//
//  Home.swift
//  UI-604
//
//  Created by nyannyan0328 on 2022/07/04.
//

import SwiftUI

struct Home: View {
    @State var selectedPizza : Pizza = pizzas[0]
    
    @State var swipDelection : Alignment = .center
    
    @State var animatedPizza : Bool = false
    
    @State var pizzaSize : String = "MEDIUM"
    @Namespace var animation
    var body: some View {
        VStack{
            
            HStack{
                
                Button {
                    
                } label: {
                    Image("Menu")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50,height: 50)
                    
                    
                    
                }
                
                Spacer()
                
                Image("p1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50,height: 50)
                    .clipShape(Circle())
                    
                
                

            }
            .overlay {
                
                Text(attString)
                    .font(.largeTitle)
            }
            
            AnimatedSlider()
            
        }
        .padding(15)
        .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .top)
        .background{
         
            Rectangle()
                .fill(Color("BG"))
                .ignoresSafeArea()
           
        }
    }
    
    @ViewBuilder
    func AnimatedSlider()->some View{
        
        GeometryReader{proxy in
             let size = proxy.size
            
            LazyHStack(spacing:0){
                
                ForEach(pizzas){piza in
                    
                    let index = getIndex(pizza: piza)
                    let mainIndex = getIndex(pizza: selectedPizza)
                    
                    VStack{
                        
                        Text(piza.pizzaTitle)
                            .font(.largeTitle.bold())
                        
                        Text(piza.pizzaDescription)
                            .font(.callout)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                            .padding(.top,10)
                    }
                    .frame(width: size.width,height: size.height,alignment: .top)
                    .rotationEffect(.init(degrees: mainIndex == index ? 0 : (index > mainIndex ? 180 : -180)))
                    .offset(x:-CGFloat(mainIndex) * size.width,y:index == mainIndex ? 0 : 40)
                }
            }
            
            
            pizzaView()
                .padding(.top,150)
        }
        .padding(-15)
        .padding(.top,20)
        
        
    }
    @ViewBuilder
    func pizzaView()->some View{
        
        GeometryReader{proxy in
            
             let size = proxy.size
            
            ZStack(alignment:.top){
                
                Image(selectedPizza.pizzaImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:size.width,height: size.height)
                     .background{
                         
                         Image("Powder")
                             .resizable()
                             .aspectRatio(contentMode: .fit)
                             .frame(width:size.width)
                             .offset(y:-40)
                        
                    }
                     .scaleEffect(1.05,anchor: .top)
                
                
                ZStack(alignment:.top){
                    
                    if pizzas.first?.id != selectedPizza.id{
                        
                        
                        AricShape()
                            .trim(from: 0.05,to: 0.3)
                            .stroke(.gray,lineWidth: 1)
                            .offset(y:85)
                            
                        
                        Image(systemName: "chevron.left")
                            .rotationEffect(.init(degrees: -30))
                            .offset(x:-(size.width / 2) + 30,y:65)
                    }
                    
                    if pizzas.last?.id != selectedPizza.id{
                        
                        
                        AricShape()
                            .trim(from: 0.7,to: 0.96)
                            .stroke(.gray,lineWidth: 1)
                            .offset(y:85)
                        
                        
                        
                        Image(systemName: "chevron.right")
                            .rotationEffect(.init(degrees: 30))
                            .offset(x:(size.width / 2) - 30,y:65)
                        
                    }
                    
                    
                    Text(priceString(value:selectedPizza.pizzaPrice))
                        .font(.largeTitle.bold())
                }
                
                
                
            }
            .rotationEffect(.init(degrees: animatedPizza ? (swipDelection == .leading ? -360 : 360) : 0))
            .offset(y:size.height / 2)
            .gesture(
            
            DragGesture()
                .onEnded{value in
                    
                    let translation = value.translation.width
                    let index = getIndex(pizza: selectedPizza)
                    
                    if animatedPizza{return}
                    
        
                    
                    if translation < 0 && -translation > 50 && index != (pizzas.count - 1){
                        
                        swipDelection = .leading
                        handleSwipe()
                    }
                    
                    if translation > 0 && translation > 50 && index > 0{
                        swipDelection = .trailing
                        handleSwipe()
                    }
                
                    
                }
            )
            
            
            HStack{
                
                ForEach(["SMALL","MEDIUM","LARGE"],id: \.self){type in
                    
                    Text(type)
                        .font(.callout)
                        .frame(maxWidth: .infinity,alignment: .center)
                        .foregroundColor(pizzaSize == type ? .red : .white)
                        .overlay(alignment:.bottom){
                            
                            if pizzaSize == type{
                                Circle()
                                    .fill(.red)
                                    .frame(width:10,height:10)
                                    .offset(y:20)
                            }
                            
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            
                            withAnimation{
                                
                                pizzaSize = type
                            }
                        }
                }
            }
            .padding(.horizontal)
            .padding(.vertical)
            .background{
             
                
                ZStack(alignment:.top){
                    
                    Rectangle()
                        .trim(from: 0.25,to: 1)
                         .stroke(.gray,lineWidth: 1)
                     
                     Rectangle()
                        .trim(from: 0,to: 0.18)
                          .stroke(.gray,lineWidth: 1)
                     
                     Text("SIZE")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .offset(y:-8)
                }
            }
            
            .padding(.horizontal)
            .padding(.top,20)
            
            
        }
        
        
        
    }
    
    func handleSwipe(){
        
        let index = getIndex(pizza: selectedPizza)
        
        if swipDelection == .leading{
            
            withAnimation(.easeInOut(duration: 0.8)){
                
                selectedPizza = pizzas[index + 1]
                animatedPizza = true
            }
        }
        
        if swipDelection == .trailing{
            
            withAnimation(.easeInOut(duration: 0.8)){
                
                selectedPizza = pizzas[index - 1]
                animatedPizza = true
            }
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8){
            
            
            animatedPizza = false
            
        }
    }
    func  priceString(value : String) -> AttributedString{
        
        var str = AttributedString(stringLiteral: value)
        
        if let range = str.range(of: "$"){
            
            str[range].font = .system(.callout,weight: .semibold)
            
        }
        
        return str
    }
    
    var attString : AttributedString{
        
        var str = AttributedString(stringLiteral: "EATPIZZA")
        
        if let range = str.range(of: "PIZZA"){
            
            str[range].font = .largeTitle.weight(.semibold)
            str[range].foregroundColor = .gray
            
        
        }
        return str
    }
    
    func getIndex(pizza : Pizza)->Int{
        
        
        return pizzas.firstIndex { CAZA in
            
            CAZA.id == pizza.id
        } ?? 0
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
