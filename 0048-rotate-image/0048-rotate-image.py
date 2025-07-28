class Solution:
    def rotate(self, matrix: List[List[int]]) -> None:
        """
        Do not return anything, modify matrix in-place instead.
        """
        #Draw by hand and thats it 
        N = len(matrix[0])
        for i in range(N):
            for j in range(i):
                matrix[i][j] , matrix[j][i] = matrix[j][i] , matrix[i][j]

        for i in range(N):
            matrix[i].reverse()