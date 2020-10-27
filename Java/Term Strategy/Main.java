package main;

import static java.lang.Double.max;
import java.util.Scanner;

public class Main {

    public static long solve(int i, int h, int n, int m, int [][] memo, int [][] arr){
        if(h < 0)
            return -1073741824;
        if(i == n)
            return 0;
        if(memo[i][h] > 0)
            return memo[i][h];
        long maxv = -1073741824;
        for(int k = 0; k < m; k++)
            if(arr[i][k] >= 5)
                maxv = (long) max(maxv, arr[i][k] + solve(i+1, h-k-1, n, m, memo, arr));
        return memo[i][h] = (int) maxv;
    }
    
    public static void main(String[] args) {
        Scanner sr = new Scanner(System.in);
        int t, n, m;
        int [][] arr = new int[15][105];
        int [][] memo = new int[15][105];
        
        t = sr.nextInt();
        
        while(t != 0){
            n = sr.nextInt();
            m = sr.nextInt();
            
            for(int i = 0; i < n; i++)
                for(int j = 0; j < m; j++)
                    arr[i][j] = sr.nextInt();
            for(int i = 0; i <= n; i++)
                for(int j = 0; j <= m; j++)
                    memo[i][j] = 0;
            float maxv = solve(0, m, n, m, memo, arr);
            maxv = (int) (maxv/n * 100 + .5);
            if(maxv > 0){
                System.out.print("Maximal possible average mark - ");
                System.out.printf("%.2f.%n", (float) maxv/100);
            }
            
            else
                System.out.print("Peter, you shouldn't have played billiard that much.\n");
            t--;
        }
    }    
}
