//
//  ContentView.swift
//  analyze image
//  www.silvaneimartins.com.br
//  Created by Silvanei  Martins on 22/09/22.
//  silvaneimartins_rcc@hotmail.com

import SwiftUI

struct ContentView: View {
    // MARK: - Proriedade
    
    @State private var isAnimating: Bool = false
    @State private var imageScale: CGFloat = 1
    @State private var imageOffset: CGSize = .zero
    
    // MARK: - Função
    func resetImageState() {
        return withAnimation(.spring()) {
            imageScale = 1
            imageOffset = .zero
        }
    }
    
    
    // MARK: - Conteudo
    var body: some View {
        NavigationView {
            ZStack {
                Color.clear
                
                // MARK: - PAGE IMAGE
                Image("magazine-front-cover")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
                    .opacity(isAnimating ? 1 : 0).animation(.linear(duration: 1), value: isAnimating)
                    .offset(x: imageOffset.width, y: imageOffset.height)
                    .scaleEffect(imageScale)
                    // MARK: - 1. GESTO DE TOCAR
                    .onTapGesture(count: 2, perform: {
                        if imageScale == 1 {
                            withAnimation(.spring()) {
                                imageScale = 5
                            }
                        } else {
                            resetImageState()
                        }
                    })
                    // MARK: - GESTO DE ARRASTAR
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                withAnimation(.linear(duration: 1)) {
                                    imageOffset = value.translation
                                }
                            }
                            .onEnded { _ in
                                if imageScale <= 1 {
                                    resetImageState()
                                }
                            }
                    )
            }//: ZSTACK
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                withAnimation(.linear(duration: 1)) {
                    isAnimating = true
                }
            })
            // MARK: - PANEL DE INFORMAÇÃO
            .overlay(
                InfoPanelView(scale: imageScale, offset: imageOffset)
                    .padding(.top, 20)
                , alignment: .top
            )
            // MARK: - CONTROLES
            .overlay(
                Group {
                    HStack {
                        Button(action: {
                            withAnimation(.spring()) {
                                if imageScale > 1 {
                                    imageScale -= 1
                                    
                                    if imageScale <= 1 {
                                        resetImageState()
                                    }
                                }
                            }
                        }) {
                            ControlImageView(icon: "minus.magnifyingglass")
                        }
                        
                        Button(action: {
                            
                        }) {
                            ControlImageView(icon: "arrow.up.left.and.down.right.magnifyingglass")
                        }
                        
                        Button(action: {
                            
                        }) {
                            ControlImageView(icon: "plus.magnifyingglass")
                        }
                    }//: HSTACK
                    .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                    .background(.ultraThinMaterial)
                    .opacity(isAnimating ? 1 : 0)
                    .cornerRadius(8)
                }
                  .padding(.bottom, 15)
                , alignment: .bottom
            )
        }//: Navigation
        .navigationViewStyle(.stack)
    }
}

// MARK: - Visualização
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
