//
//  CostMatrix.swift
//  LowCost
//
//  Created by SIRAJ V K on 07/02/18.
//  Copyright © 2018 SIRAJ V K. All rights reserved.
//

import Foundation
class CostMatrix{
    var matrix: [[Int]]!
    
    init(matrix:[[Int]]){
        self.matrix = matrix
    }
    var rows: Int {
        return matrix.count
    }
    
    var columns: Int {
        return matrix[0].count
    }
    func getCostAt(XY: (Int, Int)) -> Int! {
        let (r, c) = XY
        if r <= 0 || r > matrix.count || c <= 0 || c > matrix[0].count {
            return nil
        }
        return matrix[r - 1][c - 1]
    }
    func rightXYFrom(XY: (Int, Int)) -> (Int, Int)! {
        let (r, c) = XY
        if c >= matrix[0].count {
            return nil
        }
        return (r, c + 1)
    }
    
    func topXYFrom(XY: (Int, Int)) -> (Int, Int)! {
        let (r, c) = XY
        if c >= matrix[0].count {
            return nil
        }
        return (r == 1 ? matrix.count : r - 1, c + 1)
    }
    func bottomXYFrom(XY: (Int, Int)) -> (Int, Int)! {
        let (r, c) = XY
        if c >= matrix[0].count {
            return nil
        }
        return (r == matrix.count ? 1 : r + 1, c + 1)
    }
}
