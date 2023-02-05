#include <stdio.h>
#include <xmmintrin.h>

void dodaj_SSE(char*, char*, char*);
void pierwiastek_SSE(float*, float*);
void odwrotnosc_SSE(float*, float*);
void int2float(int* calkowite, float* zmienno_przec);
void pm_jeden(float* tabl);
void dodawanie_SSE(float* a);
void wyznacz_min(float* tab1, float* tab2);
float ciag_geo(float* tab, float a1, float q);
double* wieksze(__m128* tablica, unsigned int n, int prog);
float nowy_sinh(float x);
float objetosc_stozka(unsigned int big_r, unsigned int small_r, float h);

//Podprogramy na drugie kolokwium
int roznica(int* odjemna, int** odjemnik);
int* kopia_tablicy(int tab[], unsigned int n);	//dziala ale na koniec maina wywala jakis blad
char* komunikat(char* tekst);
int* szukaj_elem_min(int tablica[], int n);
void szyfruj(char* tekst);
unsigned int kwadrat(unsigned int a);
void pole_kola(float* pr);
float avg_wd(int n, void* tablica, void* wagi);
unsigned int liczba_procesorow();
float obj_stozka_sc(float r, float R, float h);
unsigned int NWD(unsigned int a, unsigned int b);
float szereg(unsigned int n);
unsigned __int64 sortowanie(unsigned __int64* tabl, unsigned int n);
double plus_jeden(double x); //Tego nie zrobi³em
wchar_t * zamien_na_base12(unsigned int liczba);
char* spacje(char znak);
float funkcja(long long n);
void test(float a);		//zadanie z half
void test2(float a, int b, char c);

int* podciag(int* t1, int* t2);

#define n 6

int main()
{
	int t1[5] = { 1,2,3,4,5 };
	int t2[3] = { 2,4,5 };
	int* tab = podciag(t1, t2);

	return 0;
}
