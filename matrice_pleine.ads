generic 
    Capacite : Integer ; 
    Type Type_Element is digits <> ; 
Package Matrice_Pleine is 

	-- Définir un type T_Vecteur
	type T_Vecteur is array (1..Capacite) of Type_Element;

	--Definir le type des Matrice 
 	Type T_Matrice is array (1..Capacite) of T_Vecteur ;
 	
 	-- Initialiser un vecteur en affectant un C choisi a tout ses elements
 	procedure Initialiser (Vecteur: out T_Vecteur; C : in Type_Element) ;

 	-- Verifier si tout les elements d'un vecteur sont nuls
 	Function Est_nulle (Vecteur : T_Vecteur) return Boolean ;
        
        --fonction retourne la norme infinie de la difference entre deux vecteurs
        Function Distance_max (V : T_Vecteur ; W : T_Vecteur ) return Type_Element ;
        
        -- affecter la valeur de A à B et l'inverse
        procedure Permuter(A, B : in out Type_Element) ; 
        
        
        --trier les elements d'un vecteur par ordre decroissant 
        Procedure Trier_V(V : in out T_Vecteur) ;
         
        
	-- initialiser une matrice 
	Procedure Initialiser_M (M : out T_Matrice ) ;

        -- fonction qui calcule le produit d'un vecteur etune matrice 
        Function Multiplication_V_M (V : T_Vecteur ; M : T_Matrice) return T_Vecteur ; 
 
        
        --fonction qui calcule le produit d'une matrice par un scalaire  
        Function Multiplication_scalaire_M (scalaire : Type_Element ; M : T_Matrice) return T_Matrice ;  

        --foncton qui calcule la somme de deux matrices de meme taille (Capacite)
	Function Somme_Matrices(M : T_Matrice ; N : T_Matrice) return T_Matrice ;


	--fonction qui retourne une matrice dont tout les elements vaut 1 
	Function  Matrice_un return T_Matrice ;
        
        -- calculer la matrice H a l aide d'un reseau R (ne l'affecte que des 1 au espace convenable)	
	Function Matrice_H(R : String) return T_Matrice ;
	
	-- Fonction qui renvoie la marice S à partir de la matrice H et un element T 
	Function Matrice_S ( H: T_Matrice  ; T : Type_Element) return T_Matrice ;

end Matrice_Pleine ; 
	

	

