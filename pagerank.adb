with Ada.IO_Exceptions;
with Ada.Text_IO;			use Ada.Text_IO;
with Ada.Float_Text_IO;		use Ada.Float_Text_IO;
with Ada.Integer_Text_IO;	use Ada.Integer_Text_IO;
with Ada.Command_line;		use Ada.Command_line;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Matrice_Pleine;
with gestion_commande;  use gestion_commande ; 
with gestion_fichier;  use gestion_fichier;



Procedure PageRank is
	
	
	
	type T_Double is digits 6;
	
	A : Float:=0.85 ;-- Valeur de Alpha par defaut
	K : Integer:=150 ;-- nombre des iterations par defaut
	E : Float:=0.0 ;-- Valeur de la precision par defaut
	Mode : Boolean:=True; -- MÈthode matrice Pleine ( Matrice Creuse plus tard ) 
	R : Unbounded_String:=To_Unbounded_String(Argument(Argument_Count));-- Le nom du fichier source 
	prefixe: Unbounded_String:= To_Unbounded_String("Output");-- Prefixe des fichiers resultats par defaut

	
	N : Integer:= Get_Taille(To_String(R)) ; -- La valeur de la Capacite donnÈ par le fichier source ( 1Èr liggne )
	

	package Mat is new matrice_pleine(Capacite=>N,Type_Element=>T_Double); -- Instansciation du module Matrice_Pleine
	use Mat;
	Poid : T_Vecteur ; -- Le poid ‡ la derniere itÈration
        G: T_Matrice;
        Poid_Trie : T_Vecteur ; -- Le poid ‡ la derniere itÈration triÈ
	File : Ada.Text_IO.File_Type; -- descripteur de fichier texte (Ada.Text_IO)
	
	
   
        -- Function qui Calcule la Somme des elemnts d'un vecteur
        Function Somme_V(V : T_Vecteur) return Integer is 
        ct : Integer := 0 ; 
        begin
        	for i in 1..N loop  
               	if V(i) /= 0.0 then 
                   		ct := ct + 1 ; 
               	else
               		null;
               	end if ; 
           	end loop ; 
        	return ct ; 
   	end ;  
         
        -- Procedure qui Normalise un vecteur donnÈ
        Procedure Normaliser_V(V :in out T_Vecteur) is
        Norme : T_Double ; 
        begin 
      		Norme := T_Double(Somme_V(V)) ; 
      		if Est_nulle(V) then 
           		null ; 
      		else 
           		for i in 1..N loop 
                		V(i) := V(i)/Norme ;
           		end loop ; 
      		end if ;     
    	end Normaliser_V ;
      
      
	-- Fonction qui renvoit la matrice de Google √† partir du fichier R
	function Matrice_de_Google (R: in String) return T_Matrice is
		H : T_Matrice ; 
	        S : T_Matrice;
	        G : T_Matrice ; 
	        Inv_N : T_Double ;
                terme_1 : T_Matrice;
                terme_2 : T_Matrice;
		begin
         		Inv_N := 1.0/T_Double(N) ; 
        	 	H := Matrice_H(R) ; 
         		for i in 1..N loop    
             			Normaliser_V(H(i)) ;
         		end loop ; 
	     		S := Matrice_S(H,Inv_N) ;
        		terme_1 := Multiplication_scalaire_M(T_Double(A),S) ; 
       		terme_2 := Multiplication_scalaire_M((1.0-T_Double(A))*Inv_N,Matrice_un) ;
        		G := Somme_Matrices(terme_1,terme_2);
	     		return G;
	     
		end ;
	
	
	-- Creer le vecteur poid et le vecteur poid_Trie ‡ partir du fichier source R
	 Procedure Creer_Poids(Poid : out T_Vecteur ;Poid_Trie: out T_Vecteur; R : in String) is 
	     	Inv_N : T_Double ;
	     	G : T_Matrice ; 
         	counter : Integer:=1; 
		begin 
            		Inv_N := 1.0/T_Double(N) ;
	     		Initialiser(Poid,Inv_N) ;
			G := Matrice_de_Google(R) ; 
         
	       	while Distance_max(Multiplication_V_M(Poid,G),Poid) >= T_Double(E) and counter < K loop 
            
           			Poid:= Multiplication_V_M(Poid,G);
           			counter := counter + 1 ; 
      			end loop ; 
         		Poid:= Multiplication_V_M(Poid,G);
       		Poid_Trie := Poid;
	     		Trier_V(Poid_Trie);
	        end Creer_Poids ;
	     

	     
   	 -- Creer le fichier <prefixe>.pr
	 Procedure Creer_Fichier_pr(prefixe:in out Unbounded_String ;Poid: in T_Vecteur;Poid_Trie: in T_Vecteur) is
           	File : Ada.Text_IO.File_Type;
           	prefixe_aux : Unbounded_String; -- Pour ne pas modifier <prefixe>
		begin
			prefixe_aux := prefixe;	
			Append (prefixe_aux, ".pr");
			Create (File, Out_File,To_String(prefixe_aux));
	     		Close(File);
	     		Open (File, Append_File,To_String(prefixe_aux));
	     		for i in 1..N loop
				for j in 1..N loop
					if Poid(j) = Poid_Trie(i) then
						Put(File,j);
						New_Line(File);
					else
						null;
					end if ;
				end loop ;
	     		end loop ;
         		close(File);
         		
 			exception
 			
			when No_Argument_Error =>
				Put_Line ("Pas de fichier.");
				New_Line;
				Put_Line ("Usage : " & Command_Name & " <fichier>");

			when Ada.IO_Exceptions.Name_Error =>
				Put_Line ("Fichier inexisant " );

			when Data_Error =>
				Put_Line ("Mauvais format du fichier : devrait Ítre entier, reel, entier*");
	     
	   	end Creer_Fichier_pr;

	
   	-- Creer Fichier.prw
   	procedure Creer_Fichier_prw( prefixe : in out Unbounded_String; Poid_Trie : in T_Vecteur) is
      		File : Ada.Text_IO.File_Type;
        	Begin
     			Append (prefixe, ".prw");
         		Create (File, Out_File, To_String(prefixe));
	     		Close(File);
	     		Open (File, Append_File, To_String(prefixe));
	     		Put(File,N);
	     		Put(File," ");
	     		Put(File,A,Exp => 0);
	     		Put(File," ");
	     		Put(File,K);
	     		New_Line(File);
	     		for i in 1..N loop
	     			Put(File,Float(Poid_Trie(i)),Fore=>11,Exp => 0);
	     			New_Line(File);
	     		end loop;
           		Close(File);
 			
 			exception
	
			when No_Argument_Error =>
				Put_Line ("Pas de fichier.");
				New_Line;
				Put_Line ("Usage : " & Command_Name & " <fichier>");

			when Ada.IO_Exceptions.Name_Error =>
				Put_Line ("Fichier inexisant " );

			when Data_Error =>
				Put_Line ("Mauvais format du fichier : devrait Ítre entier, reel, entier*");
      
    		end Creer_Fichier_prw;
	     
	
	-- DÈbut du programme principal
	Begin 
    		Gestion_De_Commande (A , K, Mode, E ,prefixe);--Modifier les valeurs des prametres donn√©s par la ligne de commande
    		G:= Matrice_de_Google(To_String(R));-- Creation de la matrice de Google
    		Creer_Poids(Poid ,Poid_Trie, To_String(R) );-- Creer les vecteurs Poids et Pois_Trie
		Creer_Fichier_pr(prefixe,Poid,Poid_Trie); -- Creer <prefixe>.pr
    		Creer_Fichier_prw(prefixe, Poid_Trie) ; -- Creer <prefixe>.prw
	     
	        
		
end PageRank;
	





