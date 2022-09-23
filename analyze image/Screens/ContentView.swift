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
    @State private var isDrawerOpen: Bool = false
    
    let pages: [Page] = pagesData
    @State private var pageIndex: Int = 1
    
    // MARK: - Função
    func resetImageState() {
        return withAnimation(.spring()) {
            imageScale = 1
            imageOffset = .zero
        }
    }
    
    func currentPage() -> String {
        return pages[pageIndex - 1].imageName
    }
    
    
    // MARK: - Conteudo
    var body: some View {
        NavigationView {
            ZStack {
                Color.clear
                
                // MARK: - PAGE IMAGE
                Image(currentPage())
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
                    // MARK: - APLICAÇÃO
                    .gesture(
                        MagnificationGesture()
                            .onChanged { value in
                                withAnimation(.linear(duration: 1)) {
                                    if imageScale >= 1 && imageScale <= 5 {
                                        imageScale = value
                                    } else if imageScale > 5 {
                                        imageScale = 5
                                    }
                                }
                            }
                            .onEnded { _ in
                                if imageScale > 5 {
                                    imageScale = 5
                                } else if imageScale <= 1 {
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
                            resetImageState()
                        }) {
                            ControlImageView(icon: "arrow.up.left.and.down.right.magnifyingglass")
                        }
                        
                        Button(action: {
                            withAnimation(.spring()) {
                                if imageScale < 5 {
                                    imageScale += 1
                                    
                                    if imageScale > 5 {
                                        imageScale = 5
                                    }
                                }
                            }
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
            // MARK: - GAVETA
            .overlay(
                HStack(spacing: 12) {
                    //: IMAGE DA GAVETA
                    Image(systemName: isDrawerOpen ? "chevron.compact.right" : "chevron.compact.left")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40)
                        .padding(8)
                        .foregroundStyle(.secondary)
                        .onTapGesture(perform: {
                            withAnimation(.easeOut) {
                                isDrawerOpen.toggle()
                            }
                        })
                    //: MARK: - THUMBNAILS
                    ForEach(pages) { item in
                        Image(item.thumbnailName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80)
                            .cornerRadius(8)
                            .shadow(radius: 4)
                            .opacity(isDrawerOpen ? 1 : 0)
                            .animation(.easeOut(duration: 0.5), value: isDrawerOpen)
                            .onTapGesture(perform: {
                                isAnimating = true
                                pageIndex = item.id
                            })
                    }
                    Spacer()
                }//: HSTACK
                .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
                .background(.ultraThinMaterial)
                .cornerRadius(8)
                .frame(width: 260)
                .padding(.top, UIScreen.main.bounds.height / 12)
                .offset(x: isDrawerOpen ? 20 : 215)
                , alignment: .topTrailing
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
