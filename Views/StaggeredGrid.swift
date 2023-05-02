//
//  StaggeredGrid.swift
//  ModelPicker-test-2
//
//  Created by Tavi Diaconu on 01.05.2023.
//

import SwiftUI

    //T-> is to hold the identifiable collection of data...
struct StaggeredGrid<Content: View,T: Identifiable>: View where T: Hashable{
    
    //It will return each object from collection to build View...
    var content: (T) -> Content
    
    var list: [T]
    
    //Columns...
    var columns: Int
    
    var showsIndicatos: Bool
    var spacing: CGFloat
    
    init(columns: Int, showsIndicatos: Bool = false, spacing: CGFloat = 10, list: [T], @ViewBuilder content: @escaping(T)->Content){
        self.content = content
        self.list = list
        self.spacing = spacing
        self.showsIndicatos = showsIndicatos
        self.columns = columns
    }
 
    //Staggered Grid function
    func setUpList()->[[T]]{
        //Creating empty sub-arrays of columns count...
        var gridArray: [[T]] = Array(repeating: [], count: columns)
        
        //Spilling array for VStack oriented view...
        var currentIndex: Int = 0
        
        for object in list{
            gridArray[currentIndex].append(object)
            
            //increasing index count and resetting if it overbounds the columns count...
            if currentIndex == (columns - 1){
                currentIndex = 0
            }
            else{
                currentIndex += 1
            }
        }
        
        return gridArray
    }
    
    var body: some View {
            
        HStack(alignment: .top, spacing: 20){
                
                ForEach(setUpList(),id: \.self){ columnsData in
                    //LazyStack for optimization...
                    LazyVStack(spacing: spacing){
                        
                        ForEach(columnsData){ object in
                            content(object)
                        }
                    }
                    .padding(.top, getIndex(values: columnsData) == 1 ? 80 : 0)
                }
            }
            //Only vertical padding...
            .padding(.vertical)
        }
    
    //Moving the second row a little lower...
    func getIndex(values:[T])-> Int{
        
        let index = setUpList().firstIndex { t in
            
            return t == values
        } ?? 0
        
        return index
    }
    }

struct StaggeredGrid_Previews: PreviewProvider {
    static var previews: some View {
        MoreProductsView()
    }
}
