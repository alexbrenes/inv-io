#include <bits/stdc++.h>
using namespace std;
#define ll long long
#define oo (1<<30)
int t, n, m;
int arr[15][105];
int memo[15][105];
ll solve(int i, int h){
	if (h < 0) return -oo;
	if (i == n) return 0;
	if (memo[i][h] > 0) return memo[i][h];
	ll maxv = -oo;
	for (int k = 0; k < m; k++)
		if (arr[i][k] >= 5)
			maxv =  max(maxv, arr[i][k] + solve(i + 1, h - k - 1));
	return memo[i][h] = maxv;
}
int main(){
	scanf("%i", &t);
	while (t--){
		scanf("%i%i",&n,&m);
		for (int i = 0; i < n; i++)
			for (int j = 0; j < m; j++)
				scanf("%i", &arr[i][j]);
		for (int i = 0; i <= n; i++)
			for (int j = 0; j <= m; j++)
				memo[i][j] = 0;
		float maxv = solve(0, m);
		maxv = (int)(maxv/n * 100 + .5);
		if (maxv > 0){
			printf("Maximal possible average mark - %.2f.\n", (float)maxv/100);
		}
		else printf("Peter, you shouldn't have played billiard that much.\n");
	}
    return 0;
}
