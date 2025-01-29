with Ada.IO_Exceptions;
with Ada.Text_IO;			use Ada.Text_IO;
with Ada.Float_Text_IO;		use Ada.Float_Text_IO;
with Ada.Integer_Text_IO;	use Ada.Integer_Text_IO;
with Ada.Command_line;		use Ada.Command_line;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with matrice_pleine;
procedure test_matrice is

    
    	package Matt is new matrice_pleine(Capacite=> 6 ,Type_Element=>Float);
    	use Matt;
	
	P: T_Matrice;
	N: T_Matrice;
	V:T_Vecteur;
	M: T_Matrice;
	G : T_Matrice;
	
	-- Function qui Calcule la Somme des elemnts d'un vecteur
        Function Somme_V(V : T_Vecteur) return Integer is 
        ct : Integer := 0 ; 
        begin
        	for i in 1..6 loop  
               	if V(i) /= 0.0 then 
                   		ct := ct + 1 ; 
               	else
               		null;
               	end if ; 
           	end loop ; 
        	return ct ; 
	end;
	
	--Procedure qui Normalise un vecteur donné
        Procedure Normaliser_V(V :in out T_Vecteur) is
        Norme : Float ; 
        begin 
      		Norme := Float(Somme_V(V)) ; 
      		if Est_nulle(V) then 
           		null ; 
      		else 
           		for i in 1..6 loop 
                		V(i) := V(i)/Norme ;
           		end loop ; 
      		end if ;     
    	end Normaliser_V ;
    	-- Fonction qui renvoit la matrice de Google Ã  partir du fichier R
	function Matrice_de_Google (R: in String) return T_Matrice is
		H : T_Matrice ; 
	        S : T_Matrice;
	        G : T_Matrice ; 
	        Inv_N : Float ;
                terme_1 : T_Matrice;
                terme_2 : T_Matrice;
                A : float:= 0.85;
		begin
         		Inv_N := 1.0/6.0 ; 
        	 	H := Matrice_H(R) ; 
         		for i in 1..6 loop    
             			Normaliser_V(H(i)) ;
         		end loop ; 
	     		S := Matrice_S(H,Inv_N) ;
        		terme_1 := Multiplication_scalaire_M(Float(A),S) ; 
       			terme_2 := Multiplication_scalaire_M((1.0-Float(A))*Inv_N,Matrice_un) ;
        		G := Somme_Matrices(terme_1,terme_2);
	     		return G;
	     
	end ;
	
	-- Afficher vecteur
	
	Procedure Afficher_V( V: in T_Vecteur) is 
	
	Begin
		for i in 1..6 loop
			Put(V(i),exp=>0);
			Put(" ");
		end loop;
	end Afficher_V;
	
	-- Affichier Matrice
	
	Procedure Afficher_M(M: in T_Matrice ) is

	Begin
	for i in 1..6 loop
		Afficher_V((M(i)));
		New_Line;
	end loop;
	end Afficher_M;	 
	 
begin
	
	M := Matrice_H("sujet.net");
        for i in 1..6 loop
        	Normaliser_V(M(i));
        end loop;
        P :=Matrice_S(M,1.0/6.0);
	Put("La matrice H correspond au sujet.net est ");
	New_line(2);
	Afficher_M(M);
	Put("La matrice S correspond au sujet.net est ");
	New_line(2);
	Afficher_M(P);
	G:= Matrice_de_Google("sujet.net");
	Put("La matrice G correspond au sujet.net est ");
	New_line(2);
	Afficher_M(G);
	Put_Line("Fin test");
	
	
end test_matrice;
