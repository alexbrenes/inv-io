package main;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.PriorityQueue;
import java.util.Scanner;

public class Main {
    
    public static void main(String[] args) throws Exception {
        Scanner sr = new Scanner(System.in);

        int T = sr.nextInt();
        for (int t = 1; t <= T; t++) {

            int n = sr.nextInt();
            int m = sr.nextInt();
            int start = sr.nextInt();
            int end = sr.nextInt();
            List<Edge>[] edges = new ArrayList[n];
            for (int i = 0; i < m; i++) {
                int a = sr.nextInt();
                int b = sr.nextInt();
                int c = sr.nextInt();
                if (edges[a] == null) {
                    edges[a] = new ArrayList<Edge>();
                }
                if (edges[b] == null) {
                    edges[b] = new ArrayList<Edge>();
                }
                edges[a].add(new Edge(b, c));
                edges[b].add(new Edge(a, c));
            }

            int[] dist = new int[n];
            Arrays.fill(dist, Integer.MAX_VALUE);
            dist[start] = 0;
            PriorityQueue<Node> pq = new PriorityQueue<Node>();
            pq.offer(new Node(start, 0));
            boolean flag = false;
            while (!pq.isEmpty()) {
                Node c = pq.poll();
                if (c.ident == end) {
                    flag = true;
                    System.out.println("Case #" + t + ": " + c.cost);
                    break;
                }
                if (edges[c.ident] != null) {
                    for (Edge e : edges[c.ident]) {
                        if (dist[e.cur] > c.cost + e.w) {
                            dist[e.cur] = c.cost + e.w;
                            pq.offer(new Node(e.cur, dist[e.cur]));
                        }
                    }
                }
            }

            if (!flag) {
                System.out.println("Case #" + t + ": unreachable");
            }
        }
    }
}

class Node implements Comparable<Node> {
    int ident, cost;
    
    public Node(int i, int cost) {
        this.ident = i;
        this.cost = cost;
    }

    public int compareTo(Node n) {
        return cost - n.cost;
    }
}

class Edge {
    int cur, w;

    public Edge(int a, int w) {
        this.cur = a;
        this.w = w;
    }
}