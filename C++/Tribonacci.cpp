#include <bits/stdc++.h>
using namespace std;
#define ll unsigned long long int
#define matrix vector<vector<ll>>
#define pb(a) push_back(a)
#define SZ 3
#define MOD 1000000009
ll n;

matrix mult(matrix a, matrix b){
	matrix c;
	for (int i = 0; i < SZ; i++)
		c.pb(vector<ll>(SZ));
	for (int i = 0; i < SZ; i++)
		for (int j = 0; j < SZ; j++) c[i][j] = 0;
	for (int i = 0; i < SZ; i++)
		for (int j = 0; j < SZ; j++)
			for (int k = 0; k < SZ; k++){
				c[i][k] += ((a[i][j] % MOD) * (b[j][k] % MOD));
				c[i][k] %= MOD;
			}
	return c;
}
// Recursivo
matrix explgmodR(matrix a, ll x){
	matrix I;
	if (!x){ 
		for (int i = 0; i < 3; i++)
			I.pb(vector<ll>(3));
		for (int i = 0; i < SZ; i++)
			for (int j = 0; j < SZ; j++) I[i][j] = (i == j ? 1 : 0);
		return I;
	}
	matrix p = explgmodR(a, x/2);
	p = mult(p, p);
	if (x&1) return mult(a, p);
	return p;
}
// Iterativo
matrix explgmodI(matrix a, ll x) {
	matrix p;
	for (int i = 0; i < 3; i++)
		p.pb(vector<ll>(3));
	for (int i = 0; i < SZ; i++)
		for (int j = 0; j < SZ; j++) p[i][j] = (i == j ? 1 : 0);
	while(x > 0) {
		if(x % 2)
			p = mult(p, a);
		a = mult(a, a);
		x /= 2;
	}
	return p;
}

int main(){
	cin.sync_with_stdio(false);
    cin.tie(0);
	matrix tribonacci(3);
	for (int i = 0; i < 3; i++)
		tribonacci.pb(vector<ll>(3));
	tribonacci[0].pb(0);
	tribonacci[0].pb(1);
	tribonacci[0].pb(0);
	tribonacci[1].pb(0);
	tribonacci[1].pb(0);
	tribonacci[1].pb(1);
	tribonacci[2].pb(1);
	tribonacci[2].pb(1);
	tribonacci[2].pb(1);
	while (cin >> n){
		if (!n) return 0;
		if (n < 4){
			cout << n - 1 << "\n";
			continue;
		}
		matrix a = explgmodI(tribonacci, n - 1);
		cout << (a[0][1] % MOD + ((a[0][2] % MOD) * 2) % MOD) % MOD << "\n";
	}
}
