#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "hashtable.h"

// struct thing{
// 	char name[64];
// 	float temp;
// };
char name[64];
float temp;

struct val{
	float total;
	int count;
	float min;
	float max;
};

char list[1024][64];
struct val vlist[1024]; 

void parse(FILE* fptr, char* str){
		int i=0;
		char number[8];

		memset(number, 0, 8);
		while(str[i] != ';'){
			name[i] = str[i];
			++i;	
		}
		++i;

		int a = 0;
		while(str[i] != '\n'){
			number[a] = str[i];
			++i;	
			++a;
		}
		temp = atof(number);
}

int cmp(const void* a, const void* b){
	return strcmp((char*)a, (char*)b);
}

int main(){
	FILE* fptr = fopen("measurements.txt", "r");
	char str[64];

	HashTable table;
	ht_setup(&table, sizeof(struct val*), 64, 1024);
	int index = 0;

	float min, max;
	float tmpmin, tmpmax;
	while(fgets(str, 64, fptr)){
		
		parse(fptr, str);
		if(ht_contains(&table, name)){

			void* thing = (ht_lookup(&table, name));

			((struct val*)thing)->total += temp;
			((struct val*)thing)->count++;

			
			if(((struct val*)thing)->max < temp){
				((struct val*)thing)->max = temp;
			} else if(((struct val*)thing)->min > temp)
				((struct val*)thing)->min = temp;
			
		} else {
			vlist[index] = (struct val){temp, 1, temp, temp};
			ht_insert(&table, &name, &vlist[index]);
			memcpy(list[index], name, 64);
			index++;
		}

		memset(name, 0, 64);
	}
	printf("done\n");
	qsort(list, index, 64, cmp);

	struct val* v;
	for(int i=0; i<index; i++){
		v = (struct val*)ht_lookup(&table, list[i]);
		printf("%s avg: %.2f min: %.2f max: %.2f \n", list[i], (v->total)/(v->count), v->min, v->max);
	}

	printf("%d\n", index);

}
