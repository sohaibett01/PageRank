with Ada.IO_Exceptions;
with Ada.Text_IO;			use Ada.Text_IO;
with Ada.Float_Text_IO;		use Ada.Float_Text_IO;
with Ada.Integer_Text_IO;	use Ada.Integer_Text_IO;
with Ada.Command_line;		use Ada.Command_line;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package body Matrice_Pleine is 

        procedure Initialiser (Vecteur: out T_Vecteur; C :  in Type_Element) is
        begin
             for i in 1..Capacite loop 
		      Vecteur(i) := C ;
     	      end loop ;
 	end;

	Function Est_nulle (Vecteur : T_Vecteur) return Boolean is
		it : Integer := 0 ; 
        begin 
		 for i in 1..Capacite loop 
			 if Vecteur(i) = 0.0 then 
				it := it + 1 ; 
			 else 
			        null ; 
		         end if ;
	         end loop ; 
                 return  it = Capacite ; 
         
        end ; 	
        
        Function Distance_max (V : T_Vecteur ; W : T_Vecteur ) return Type_Element is
            max : Type_Element ;
        begin 
            max := abs(V(1)-W(1)) ; 
            
            for i in 2..Capacite loop 
                 if abs(V(i)-W(i))>= max then 
                       max := abs(V(i)-W(i)) ; 
                 else 
                       null ; 
                 end if ; 
            end loop ; 
            
            return max ; 
        
        end ; 	

        
        
        procedure Permuter(A, B : in out Type_Element) is
            intermidiare : Type_Element; 
        begin
            intermidiare := A;
            A := B;
            B := intermidiare;
        end Permuter;
   
    
        procedure Trier_V(V: in out T_vecteur) is
 
            indice_max : Integer;
        begin
            for i in 1..capacite- 1 loop
               indice_max := i;
               for j in i + 1 .. capacite loop
                   if V(j) > V(indice_max) then
                      Indice_max := j;
                   end if;
               end loop;
               Permuter(V(i), V(indice_max));
            end loop;

        end Trier_V;


	Procedure Initialiser_M(M : out T_Matrice) is 
	begin 
	
		for i in 1..Capacite loop 
			Initialiser(M(i),0.0) ;
		end loop ;
	
	end Initialiser_M ;


	Function  Multiplication_V_M (V : T_Vecteur ; M : T_Matrice) return T_Vecteur is
	    Produit : T_Vecteur ; 
	begin 
		
	    Initialiser(Produit,0.0) ;
		for i in 1..Capacite loop 
			for j in 1..Capacite loop 
                             Produit(i) := Produit(i) + V(j)*M(j)(i) ; 
			end loop ;  
                end loop ;
                
		return Produit ;
	end ; 


        Function Multiplication_scalaire_M (scalaire : Type_Element ; M : T_Matrice) return T_Matrice is
		Produit : T_Matrice ;  
	begin 

		for i in 1..Capacite loop 
			for j in 1..Capacite loop 
				Produit(i)(j) := scalaire*M(i)(j) ;  
                        end loop ;
		end loop ; 
	
		return Produit ;
	end ; 


	Function Somme_Matrices(M : T_Matrice ; N : T_Matrice) return T_Matrice is
                S : T_Matrice ; 
                
	begin 
		Initialiser_M (S) ;

		for i in 1..Capacite loop 
			for j in 1..Capacite loop 
				S(i)(j) := M(i)(j) + N(i)(j) ; 
			end loop ; 
		end loop ; 

		return S ; 
	end ; 



	function Matrice_un return T_Matrice is
	     Ones : T_Matrice ;
	begin 
		Initialiser_M(Ones) ; 
		
		for i in 1..Capacite loop 
		     Initialiser(Ones(i),1.0) ;
		end loop ; 
		 
		return Ones ;    

	end Matrice_un ;
	
	
	Function Matrice_H(R : String) return T_Matrice is
	     H : T_Matrice ; 
	     i : Integer ;
	     j : Integer ; 
	     File : Ada.Text_IO.File_Type;
	begin
	    Initialiser_M(H) ; 
        open (File, In_File, R);-- ouvrir le fichier donnÃ© par la ligne de commande
        Skip_Line(File) ;
        begin
	    while not End_Of_File (File) loop 
	    	Get(File,i) ;
	    	Get(File,j) ;
	    	H(i+1)(j+1) := 1.0 ; 
        end loop ;
        exception
		when End_Error =>
			null;
			Put_Line ("[fin du fichier détectée sur exception]");
	end;
	    close(File);

	    
	    return H ; 
	end ; 
	
	
	
	Function Matrice_S ( H: T_Matrice ; T : Type_Element) return T_Matrice is 
	     S : T_Matrice ;
	begin 
	     S := H ; 
	     
	     for i in 1..Capacite loop 
	         if Est_nulle(H(i)) then 
	              Initialiser(S(i),T) ;
	         else 
	              null ;
	         end if ;
	     end loop ;
	
	     return S ; 
	end ;

end Matrice_Pleine ; 	
				        	


		



