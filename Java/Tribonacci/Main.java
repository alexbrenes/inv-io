package Main;

import java.util.ArrayList;
import java.util.Scanner;


public class Main {
    final static long MOD = 1000000009;
    final static int SZ = 3;

    
    public static ArrayList<ArrayList<Long>> mult(ArrayList<ArrayList<Long>> a, ArrayList<ArrayList<Long>> b){
        ArrayList<ArrayList<Long>> c = new ArrayList<ArrayList<Long>>();
        
        for(int i = 0; i < SZ; i++)
            c.add(new ArrayList<Long>(SZ));
        for(int i = 0; i < SZ; i++)
            for(int j = 0; j < SZ; j++)
                c.get(i).add(Long.valueOf(0));
        for (int i = 0; i < SZ; i++)
            for (int j = 0; j < SZ; j++)
		for (int k = 0; k < SZ; k++){
                    c.get(i).set(k, (c.get(i).get(k) + ((a.get(i).get(j) % MOD) * (b.get(j).get(k) % MOD))));
                    c.get(i).set(k, (c.get(i).get(k) % MOD));
                }
        return c;
    }
    
    public static ArrayList<ArrayList<Long>> explgmodR(ArrayList<ArrayList<Long>> a, long x ){
        ArrayList<ArrayList<Long>> I = new ArrayList<ArrayList<Long>>(3);
        
        if(x == 0){
            for (int i = 0; i < 3; i++)
                I.add(new ArrayList<Long>(3));
            for (int i = 0; i < SZ; i++)
                for (int j = 0; j < SZ; j++)
                    I.get(i).add(i == j ? Long.valueOf(1) : Long.valueOf(0));
            return I;
        }
        
        ArrayList<ArrayList<Long>> p = explgmodR(a, x/2);
        p = mult(p, p);
        if((x % 2) != 0)
            return mult(a, p);
        return p;
    }
    
    
    public static void main(String[] args) {
        Scanner sr = new Scanner(System.in);
        long n = 0;

        ArrayList<ArrayList<Long>> tribonacci = new ArrayList<>(3);
        for (int i = 0; i < 3; i++)
            tribonacci.add(new ArrayList<Long>(3));
        tribonacci.get(0).add(Long.valueOf(0));
        tribonacci.get(0).add(Long.valueOf(1));
        tribonacci.get(0).add(Long.valueOf(0));
        tribonacci.get(1).add(Long.valueOf(0));
        tribonacci.get(1).add(Long.valueOf(0));
        tribonacci.get(1).add(Long.valueOf(1));
        tribonacci.get(2).add(Long.valueOf(1));
        tribonacci.get(2).add(Long.valueOf(1));
        tribonacci.get(2).add(Long.valueOf(1));
        
        while (true){
            n = sr.nextLong();
            if(n == 0)
                return;
            if(n < 4){
                System.out.println(n - 1);
                continue;
            }
            ArrayList<ArrayList<Long>> a = explgmodR(tribonacci, n - 1);
            System.out.println((a.get(0).get(1) % MOD + ((a.get(0).get(2) % MOD) * 2) % MOD) % MOD);
        }
    }
}
