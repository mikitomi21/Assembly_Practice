.686
.model flat
.XMM
public _podciag, _test2, _test, _funkcja, _spacje, _zamien_na_base12, _plus_jeden, _sortowanie, _szereg, _NWD, _obj_stozka_sc, _liczba_procesorow, _avg_wd, _pole_kola, _kwadrat, _szyfruj, _szukaj_elem_min, _komunikat, _kopia_tablicy, _dodaj_SSE, _pierwiastek_SSE,  _odwrotnosc_SSE, _int2float, _pm_jeden, _dodawanie_SSE, _wyznacz_min, _ciag_geo, _wieksze, _nowy_sinh, _objetosc_stozka, _roznica

extern _malloc: PROC
extern _GetSystemInfo@4: PROC

.data
	tab dword 1.0, 1.0, 1.0, 1.0

	ALIGN 16
	tabl_A dd 1.0, 2.0, 3.0, 4.0
	tabl_B dd 2.0, 3.0, 4.0, 5.0
	liczba db 1
	tabl_C dd 3.0, 4.0, 5.0, 6.0

	zero dd 0.0
	jeden dd 1.0
	trzy dd 3.0

	tablica xmmword ? 

	ktora dd 1

	wynik dd ?

	los dd 52525252h
	pomoc db ?

	cztery dd 4
	pom dd ?

	output dd ?

	ilosc dd ?
	l12 dq 1.2

	test2 dq 5
	jeden_dwa dd 0.5
.code

_jakDuzo PROC
	push ebp
	mov ebp, esp
	push esi
	push edi
	push ebx

	xor eax, eax
petlak:
	inc eax
	add edi, 4
	cmp dword PTR [edi], 0cccccccch
	je konieck
	add esi, 4
	cmp dword PTR [esi], 0cccccccch
	je konieck

	mov ebx, dword PTR [esi]
	cmp ebx, dword PTR [edi]
	je petlak:
konieck:

	pop ebx
	pop edi
	pop esi
	pop ebp
	ret
_jakDuzo ENDP

_podciag PROC
	push ebp
	mov ebp, esp
	push esi
	push edi
	push ebx

	xor eax, eax	;wynik
	xor edx, edx	;adres tablicy

	mov esi, [ebp+8]	;t1
	mov edi, [ebp+12]	;t2


petla1:
	cmp dword PTR [esi], 0cccccccch
	je koniec_pro
	mov ebx, dword PTR [esi]
petla2:
	cmp dword PTR [edi], 0cccccccch
	je koniec_srodka
	cmp ebx, dword PTR [edi]
	jne pomin2

	push eax
	call _jakDuzo
	mov edx, eax
	pop eax
	cmp edx, eax	;czy jest wiekszy niz byl
	jb pomin2
	mov eax, edx				;zapis ilsoci znakow
	mov edx, dword PTR [esi]	;zapisany adres pierwszego elementu
pomin2:

	add edi, 4
	jmp petla2:
koniec_srodka:
	mov edi, [ebp+12]	;t2
	add esi, 4
	jmp petla1:

koniec_pro:


	pop ebx
	pop edi
	pop esi
	pop ebp
	ret
_podciag ENDP

_test2 PROC
	push ebp
	mov ebp, esp

	fld dword PTR [ebp+8]
	fild dword PTR test2

	pop ebp
	ret
_test2 ENDP

_test PROC
	push ebp
	mov ebp, esp
	push ebx

	mov ebx, [ebp+8]

	shr ebx, 23
	and ebx, 0ffh
	sub ebx, 127	

	add ebx, 15	;wykladnik
	mov ax, bx
	mov ebx, [ebp+8]
	shl ebx, 9

	mov ecx, 10
petla:
	shl ebx, 1
	rcl ax, 1
	LOOP petla

	
	mov ebx, [ebp+8]
	bt ebx, 31
	jne pomin
	bts ax, 15
pomin:


	pop ebx
	pop ebp
	ret
_test ENDP

_funkcja PROC
	push ebp
	mov ebp, esp

	mov eax, [ebp+8]	;mniejsza czesc
	mov edx, [ebp+12]	;wieksza czesc
	
	cmp edx, 0
	jne pomin
	cmp eax, 1
	je koniec
	cmp eax, 2
	je koniec
pomin:
	cmp eax, 0
	jne pomin2
	dec edx
pomin2:
	dec eax

	push edx
	push eax
	call _funkcja
	pop eax
	pop edx
	
	cmp eax, 2
	ja pomin3
	push eax
	fild dword PTR [esp]
	pop eax
pomin3:
	fld l12
	fsub st(0), st(1)
	fild qword PTR [ebp+8]	;n
	fdiv
	jmp koniec2

koniec:
	push eax
	fild dword PTR [esp]
	pop eax

koniec2:
	pop ebp
	ret
_funkcja ENDP

_spacje PROC
	push ebp
	mov ebp, esp

	push dword PTR 129
	call _malloc
	pop ecx
	push eax

	mov edx, [ebp+8]	;znak

	dec ecx
petla:
	mov byte PTR [eax], dl
	inc eax
	LOOP petla
	mov byte PTR [eax], 0
	pop eax


	pop ebp
	ret
_spacje ENDP

_zamien_na_base12 PROC
	push ebp
	mov ebp, esp
	push ebx
	push esi

	mov eax, [ebp+8]	;liczba
	mov ebx, 12
	mov esi, 0			;wielkosc tablicy

dzielenie:
	cmp eax, 0
	je koniec

	mov edx, 0
	div ebx
	push edx
	inc esi	
	jmp dzielenie

koniec:
	push esi
	call _malloc
	pop esi
	mov ecx, esi
	mov ebx, eax	;adres tablicy -> ebx
	mov esi, ebx	;kopia adresu

zapisz:
	pop eax			;wczytanie liczby
	cmp al, 10
	jb dodaj30h
	cmp al, 10
	jne to11
	mov ax, 218ah
	jmp wpisz
to11:
	mov ax, 218bh
	jmp wpisz
dodaj30h:
	add ax, 30h

wpisz:
	mov word PTR [ebx], ax
	add ebx, 2
	loop zapisz
	mov eax, esi

	pop esi
	pop ebx
	pop ebp
	ret
_zamien_na_base12 ENDP


_plus_jeden PROC
	push ebp
	mov ebp, esp
	push esi
	push edi

	mov eax, [ebp+8]	;mlodsza czesc
	mov edx, [ebp+12]	;starsza czesc

	shr edx, 20
	and edx, 011111111111b
	sub edx, 1023	

	mov esi, edx	;wykladnik=na ktorej pozycji w mantysie dodac jeden
	mov edx, [ebp+12]	;starsza czesc

	add esi, 12
	mov edi, 32		;tutajz mienic
	sub edi, esi	;miejsce gdzie dodaj jeden

petla:
	bt edx, edi
	jnc koniec
	btr edx, edi
	jmp petla

koniec:
	bts edx, edi


	pop edi
	pop esi
	pop ebp
	ret
_plus_jeden ENDP

_sortowanie PROC
	push ebp
	mov ebp, esp
	push ebx
	push esi

	mov ebx, [ebp+8]	;adres tablicy
	mov ecx, [ebp+12]	;n

petla_i:
	
	push ebx
	push ecx
	dec ecx
	cmp ecx, 0
	je koniec
petla_j:
	add ebx, 8
	mov eax,[ebx-8]
	mov edx,[ebx-4]
	cmp edx, [ebx+4]
	jb zostaw
	cmp eax, [ebx]
	jbe zostaw

	;zamiana miejsc
	push dword PTR [ebx+4]
	push dword PTR [ebx]
	mov [ebx+4], edx
	mov [ebx], eax

	pop eax
	pop edx
	mov [ebx-8], eax
	mov [ebx-4], edx
zostaw:

	loop petla_j
koniec:
	pop ecx
	pop ebx

	loop petla_i

	pop esi
	pop ebx
	pop ebp
	ret
_sortowanie ENDP

_szereg PROC
	push ebp
	mov ebp, esp

	mov eax, [ebp+8]

	cmp eax, 1
	je koniec
	dec eax
	push eax
	call _szereg
	pop eax
	add eax, 2
	
	fld1
	push eax
	fild dword PTR [esp]
	pop eax
	fdiv
	fadd
	jmp koniec2
	


koniec:
	fld jeden_dwa

koniec2:
	pop ebp
	ret
_szereg ENDP

_NWD PROC
	push ebp
	mov ebp, esp

	mov eax, [ebp+8]	;a
	mov edx, [ebp+12]	;b

	cmp eax, edx
	je koniec
	jb a_mniejsze
	sub eax, edx
	jmp wykonaj
a_mniejsze:
	sub edx, eax
wykonaj:
	push edx
	push eax
	call _NWD
	pop edx
	pop edx

koniec:
	pop ebp
	ret
_NWD ENDP

_obj_stozka_sc PROC
	push ebp
	mov ebp, esp

	fld dword PTR [ebp+12]
	fld dword PTR [ebp+12]
	fmul
	fld dword PTR [ebp+12]
	fld dword PTR [ebp+8]
	fmul
	fadd
	fld dword PTR [ebp+8]
	fld dword PTR [ebp+8]
	fmul
	fadd
	fld dword PTR [ebp+16]
	fmul
	fldpi
	fmul
	fld trzy
	fdiv



	pop ebp
	ret
_obj_stozka_sc ENDP

_liczba_procesorow PROC
	push ebp
	mov ebp, esp

	push offset output
	call _GetSystemInfo@4

	pop ebp
	ret
_liczba_procesorow ENDP

_avg_wd PROC
	push ebp
	mov ebp, esp
	push esi
	push edi

	mov ecx, [ebp+8]	;n
	mov esi, [ebp+12]	;tab
	mov edi, [ebp+16]	;wagi

	fldz	;suma wag
	fldz	;pierwszy iloczyn
petla:
	fld dword PTR [esi]
	fld dword PTR [edi]
	fadd st(3), st(0)
	fmul
	fadd
	add esi, 4
	add edi, 4
	LOOP petla

	fdiv st(0), st(1)
	fxch
	fstp st(0)

	pop edi
	pop esi
	pop ebp
	ret
_avg_wd ENDP

_pole_kola PROC
	push ebp
	mov ebp, esp
	push ebx

	mov ebx, [ebp+8]

	fld dword ptr [ebx]
	fst st(1)
	fldpi
	fmul
	fmul
	fstp dword PTR [ebx]


	pop ebx
	pop ebp
	ret
_pole_kola ENDP

_kwadrat PROC
	push ebp
	mov ebp, esp
	push ebx

	mov eax, [ebp+8]

	cmp eax, 1
	je koniec
	cmp eax, 0
	je koniec

	mov pom, eax	;nasze a

	sub eax, 2
	push eax				;zapisanie a na stosie
	call _kwadrat
	pop edx					;czysczenie stosu byle gdzie

	mov ebx, eax			;(a-2)^2

	mov eax, pom			;a->eax
	mul dword PTR cztery	;4a
	add eax, ebx			;(a-2)^2 + 4a
	sub eax, 4				;(a-2)^2 + 4a -4

	add pom, 2				;wracamy do wczesniejszego a -> (a+=2)


koniec:
	pop ebx
	pop ebp
	ret
_kwadrat ENDP

_szyfruj PROC
	push ebp
	mov ebp, esp
	push ebx

	mov ebx, [ebp+8]

szyfruj:

	mov al, byte PTR [ebx]
	cmp al, 0cch
	je koniec_szy
	xor al, byte PTR los
	mov byte PTR [ebx], al
	mov pomoc, 0
	bt los, 30
	jne p1
	inc byte PTR pomoc
p1:
	bt los, 31
	jne p2
	inc byte PTR pomoc
p2:
	mov dl, pomoc
	bt edx, 0
	rcl dword PTR los, 1

	inc ebx

	jmp szyfruj

koniec_szy:
	pop ebx
	pop ebp
	ret
_szyfruj ENDP


_szukaj_elem_min PROC
	push ebp
	mov ebp, esp
	push ebx
	push esi

	mov ebx, [ebp+8]	;address of array
	mov ecx, [ebp+12]	;size of array

	mov eax, [ebx]
	mov esi, 0
szukaj_min:
	cmp eax, [ebx+esi]
	jl pomin
	mov eax ,[ebx+esi]
pomin:
	add esi, 4
	LOOP szukaj_min

	xor esi, esi
szukaj_adres:
	cmp eax, [ebx+esi]
	jne dalej_spr
	mov eax, ebx
	add eax, esi
	jmp koniec
dalej_spr:
	add esi, 4
	jmp szukaj_adres

koniec:
	pop esi
	pop ebx
	pop ebp
	ret
_szukaj_elem_min ENDP
_komunikat PROC
	push ebp
	mov ebp, esp
	push ebx
	push esi

	mov ebx, [ebp+8]
	mov esi, 0

	xor eax, eax
ile:
	mov al, [ebx+esi]
	cmp al, 0cch
	jz koniec
	inc esi
	jmp ile

koniec:
	mov ecx, esi
	add ecx, 5	;dlugosc nowej tablicy

	push ecx
	call _malloc
	pop ecx

	sub ecx, 5
	xor esi, esi
zapisz:
	mov dl, [ebx+esi]
	mov [eax+esi], dl
	inc esi
	LOOP zapisz

	mov [eax+esi], byte PTR 'B'
	mov [eax+esi+1], byte PTR '³'
	mov [eax+esi+2], byte PTR '¹'
	mov [eax+esi+3], byte PTR 'd'
	mov [eax+esi+4], byte PTR '.'

	pop esi
	pop ebx
	pop ebp
	ret
_komunikat ENDP

_kopia_tablicy PROC
	push ebp
	mov ebp, esp
	push ebx
	push esi
	push edx

	mov ebx, [ebp+8]	;adres tablicy
	mov ecx, [ebp+12]

	push ecx
	push ecx
	call _malloc	;eax, adres nowej tablicy
	pop ecx
	pop ecx

	cmp eax, 0
	je koniec
	mov esi,0

petla:
	mov [eax+esi], dword PTR 0
	mov edx, [ebx]
	bt edx, 0
	jc pomin
	mov [eax+esi], edx
pomin:
	add ebx, 4
	add esi, 4
	loop petla



koniec:

	pop edx
	pop esi
	pop ebx
	pop ebp
	ret
_kopia_tablicy ENDP

_roznica PROC
	push ebp
	mov ebp, esp
	push ebx

	mov ebx, [ebp + 8]
	mov eax, [ebx]	;odjemna

	mov edx, [ebp + 12]	;adres wskaznik
	mov ebx, [edx]	;adres na jaki wskazuje wskaznik
	mov edx, [ebx]	;odjemnik

	sub eax, edx

	pop ebx
	pop ebp
	ret
_roznica ENDP
_dodaj_SSE PROC 
	push ebp
	mov ebp, esp
	push ebx
	push esi
	push edi

	mov esi, [ebp+8]	;adres pierwsze tablicy
	mov edi, [ebp+12]	;adres drugiej tablicy
	mov ebx, [ebp+16]	;adres wynikowej tablicy

	movups xmm5, [esi]
	movups xmm6, [edi]
	
	paddsb xmm5, xmm6
	movups [ebx], xmm5

	pop edi
	pop esi
	pop ebx
	pop ebp
	ret
_dodaj_SSE ENDP

_pierwiastek_SSE PROC
	push ebp
	mov ebp, esp
	push ebx
	push esi

	mov esi, [ebp+8]
	mov ebx, [ebp+12]

	movups xmm5, [esi]
	sqrtps xmm6, xmm5
	movups [ebx], xmm6

	pop esi
	pop ebx
	pop ebp
	ret
_pierwiastek_SSE ENDP

_odwrotnosc_SSE PROC
	push ebp
	mov ebp, esp
	push ebx
	push esi

	mov esi, [ebp+8]
	mov ebx, [ebp+12]

	movups xmm5, [esi]
	rcpps xmm6, xmm5
	movups [ebx], xmm6


	pop esi
	pop ebx
	pop ebp
	ret
 _odwrotnosc_SSE ENDP

_int2float PROC
	push ebp
	mov ebp, esp
	push ebx
	push esi

	mov esi, [ebp+8]
	mov ebx, [ebp+12]

	cvtpi2ps xmm5, qword PTR [esi]
	movups [ebx], xmm5

	pop esi
	pop ebx
	pop ebp
	ret
_int2float ENDP

_pm_jeden PROC
	push ebp
	mov ebp, esp
	push esi

	mov esi, [ebp+8]

	movups xmm4, [esi]
	movups xmm5, xmmword PTR tab

	addsubps xmm4, xmm5
	movups [esi], xmm4


	pop esi
	pop ebp
	ret
_pm_jeden ENDP

_dodawanie_SSE PROC
	push ebp
	mov ebp, esp

	mov eax, [ebp+8]

	movaps xmm2, tabl_A
	movaps xmm3, tabl_B
	movups xmm4, tabl_C

	addps xmm2, xmm3
	addps xmm2, xmm4

	movups [eax], xmm2

	pop ebp
	ret
_dodawanie_SSE ENDP

_wyznacz_min PROC
	push ebp
	mov ebp, esp
	push ebx
	push esi

	mov esi, [ebp+8]	;pierwsza tablic
	mov ebx, [ebp+12]	;druga tablic

	movups xmm4, [esi]
	movups xmm5, [ebx]

	minps xmm4, xmm5
	movups [esi], xmm4

	pop esi
	pop ebx
	pop ebp
	ret
_wyznacz_min ENDP

_ciag_geo PROC
	push ebp
	mov ebp, esp
	push esi

	mov esi, [ebp+8]	;adres tablicy

	fld dword PTR [ebp+12]	
	fld dword PTR [ebp+12]	;a1

	fst dword PTR [esi]
	add esi, 4

	fld dword PTR [ebp+16]	;q

	fst st(7)
	fld dword PTR [ebp+16]

	mov ecx, 9
petla:
	fld st(1)
	fld st(1)
	fmul
	fst dword PTR [esi]
	add esi, 4
	faddp st(3), st(0)
	fld dword PTR [ebp+16]
	fmul

	LOOP petla

	fstp st(0)
	fstp st(0)

	pop esi
	pop ebp
	ret
_ciag_geo ENDP

_wieksze PROC
	push ebp
	mov ebp, esp
	push esi
	push ebx

	push dword PTR 96
	call _malloc
	add esp, 4

	mov esi, [ebp+8]	;adres tablicy
	mov ecx, [ebp+12]	;ilosc tablic
	mov ebx, [ebp+16]	;prog
	push eax
petla:
	
	push ecx
	mov ecx, 4
jedna_tablica:
	fld dword PTR [esi]
	fld st(0)
	fmul st(1), st(0)
	fmul st(1), st(0)
	fxch st(1)

	fistp dword PTR [wynik]

	cmp dword PTR [wynik], ebx
	jb pomin

	fstp dword PTR [wynik]
	mov edx, dword PTR [wynik]
	mov dword PTR [eax], edx

	add eax, 4

pomin:
	add esi, 4
	finit
	LOOP jedna_tablica

	pop ecx
	LOOP petla
	
	pop eax

	pop ebx
	pop esi
	pop ebp
	ret
_wieksze ENDP

_nowy_sinh PROC
	push ebp
	mov ebp, esp

	;mov eax, [ebp+8]	;x
	mov ecx, 2

	fld dword PTR [ebp+8]	;suma
	fld dword PTR [ebp+8]	;x
	fld jeden	;mianownik
petla:
	fld dword PTR [ebp+8]
	fmul st(2), st(0)
	fmulp st(2), st(0)
	fld st(1)	;x^(2n-1)

	fld st(1)
	inc ktora
	fild ktora
	fmul
	inc ktora
	fild ktora
	fmul	;mianownik
	fst st(2)

	fdiv
	faddp st(3), st(0)

	loop petla

	fstp st(0)
	fstp st(0)

	pop ebp
	ret
_nowy_sinh ENDP

_objetosc_stozka PROC
	push ebp
	mov ebp, esp

	fild dword PTR [ebp+8]
	fild dword PTR [ebp+8]
	fmul
	fild dword PTR [ebp+8]
	fild dword PTR [ebp+12]
	fmul
	fild dword PTR [ebp+12]
	fild dword PTR [ebp+12]
	fmul
	fadd
	fadd


	fldpi
	fld dword PTR [ebp+16]
	fmul
	fmul
	fld trzy
	fdiv

	pop ebp
	ret
_objetosc_stozka ENDP
END