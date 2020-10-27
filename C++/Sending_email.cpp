#include <bits/stdc++.h>
using namespace std;

#define ll long long
#define ii pair<int,int>
#define adjlist vector<vector<ii> > 
#define oo (1<<30)
int n;
ll dijkstra(adjlist G, int s, int t){
    priority_queue<ii, vector<ii>, greater<ii> > Q;
    vector<ll> dist(20005, oo);
    vector<int> dad(20005, -1);
    Q.push(make_pair(0, s)); 
    dist[s] = 0;
    while(Q.size()){
        ii p = Q.top();
        Q.pop();
        if(p.second == t) break;
        for(auto it = G[p.second].begin(); it != G[p.second].end(); ++it)
			if(dist[p.second]+it->first < dist[it->second]){
                dist[it->second] = dist[p.second] + it->first;
                Q.push(make_pair(dist[it->second], it->second));
            }
    }
    return dist[t];
}

int main(){
    cin.sync_with_stdio(false);
    cin.tie(0);
    int N, m, s, t, x, y, w, c;
    cin >> N;
    c = 1;
    while(c <= N){
        cin >> n >> m >> s >> t;
        adjlist G;
        for (int i = 0; i < n; i++)
            G.push_back(vector<ii>());
        for (int i = 0; i < m; i++){
            cin >> x >> y >> w;
            G[x].push_back(make_pair(w, y));
            G[y].push_back(make_pair(w, x));
        }
        int i = dijkstra(G, s, t);
        cout << "Case #" << c++ << ": ";
        cout << (i < oo ? to_string(i) + "\n" : "unreachable\n");
    }
}
