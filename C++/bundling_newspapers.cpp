#include <bits/stdc++.h>
using namespace std;
int m;
string line;

void comb(vector<string> aux, int idx, string *array, int n, int K){
	if ((int)aux.size() == K) {
		cout << aux[0];
		for(int i = 1; i < (int) aux.size(); i++)
			cout << ", " << aux[i];
		cout << "\n";
		return;
	}
	for (int i = idx; i < n; i++){//n
		aux.push_back(array[i]);
		comb(aux, i + 1, array, n, K);
		aux.pop_back();
	}
}

void solve(string* array, int n, int K){
	vector<string> aux;
	for (int i = 0; i < n; i++){//n
		aux.push_back(array[i]);
		comb(aux, i + 1, array, n, K);
		aux.clear();
	}
}

int main(){
	cin.sync_with_stdio(false);
    cin.tie(0);
	cin >> m;
	cin.clear();
	cin.ignore(1024,'\n');
	int i;
	getline(cin, line);
	for (int h = 0; h < m; h++){
		getline(cin, line); // La  configuración
		stringstream sstr(line);
		string arr[2];
		arr[0] = arr[1] = "";
		string arrstr[12];
		for (i = 0; sstr >> arr[i]; i++);
		i = 0;
		while (getline(cin, line)){
			if (line.empty()) break;
			arrstr[i++] = line;
		}
		if (!arr[1].empty()){// Caso: a b
			for (int j = stoi(arr[0]); j <= stoi(arr[1]); j++){
				if (j!=stoi(arr[0])) cout << "\n";
				cout << "Size " << j << "\n";
				solve(arrstr, i, j);
			}
		}
		else if (arr[0] == "*"){// Caso: *
			for (int j = 1; j <= i; j++){
				if (j!=1) cout << "\n";
				cout << "Size " << j << "\n";
				solve(arrstr, i, j);
			}
		}else{// Caso: n
			cout << "Size " << arr[0] << "\n";
			solve(arrstr, i, stoi(arr[0]));
		}
		cout << "\n";
		if (h + 1 < m) cout << "\n";
	}
	return 0;
}
