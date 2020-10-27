import java.util.*;

class Main {

    public static void main(String[] args) throws java.lang.Exception {
        Scanner sr = new Scanner(System.in);
        int m = sr.nextInt();
        sr.nextLine();
        sr.nextLine();
        int i = 0;

        for (int h = 0; h < m; h++) {
            i = 0;
            String x = sr.nextLine();
            String[] caso = x.split(" ");

            String[] arrstr = new String[12];
            while (i < 12) {
                String nextLine = sr.nextLine();
                arrstr[i] = nextLine;
                if (nextLine.equals("")) {
                    break;
                }
                i++;
            }
            
            if(i == 12){
                sr.nextLine();
            }
            
            if (caso[0].equals("*")) {
                combinationEvery(arrstr, i);
            } else if (caso.length > 1) {
                combinationAB(arrstr, Integer.parseInt(caso[0]), Integer.parseInt(caso[1]), i);
            } else {
                combinationA(arrstr, Integer.parseInt(caso[0]), i);
            }
            
            if(h + 1 < m){
                System.out.println();
            }
        }
    }

    static void combinationA(String arr[], int a, int i) {
        System.out.println("Size " + Integer.toString(a));
        printCombination(arr, i, a);
        System.out.println();
    }

    static void combinationUtil(String arr[], String data[], int start, int end, int index, int r) {
        if (index == r) {
            System.out.print(data[0]);
            for (int j = 1; j < r; j++) {
                System.out.print(", " + data[j]);
            }
            System.out.println();
            return;
        }

        for (int i = start; i <= end && end - i + 1 >= r - index; i++) {
            data[index] = arr[i];
            combinationUtil(arr, data, i + 1, end, index + 1, r);
        }
    }

    static void printCombination(String arr[], int n, int r) {
        String data[] = new String[r];
        combinationUtil(arr, data, 0, n - 1, 0, r);
    }

    static void combinationEvery(String arr[], int i) {
        for (int j = 1; j <= i; j++) {
            combinationA(arr, j, i);
        }
    }

    static void combinationAB(String arr[], int a, int b, int i) {
        for (; a <= b; a++) {
            combinationA(arr, a, i);
        }
    }
}
