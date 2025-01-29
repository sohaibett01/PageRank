with Ada.IO_Exceptions;
with Ada.Text_IO;			use Ada.Text_IO;
with Ada.Float_Text_IO;		use Ada.Float_Text_IO;
with Ada.Integer_Text_IO;	use Ada.Integer_Text_IO;
with Ada.Command_line;		use Ada.Command_line;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Matrice_Pleine ; 


package body gestion_fichier is 
  
           
           Function Get_Taille(R: String) return Integer is 
                 File : Ada.Text_IO.File_Type; -- descripteur de fichier texte (Ada.Text_IO)
                 N : Integer ;
           begin 
                 open (File, In_File, R); -- ouvrir le fichier donné par la ligne de commande
                 Get (File, N) ; 
                 close(File); 
                 return N ;
           end ;
           
        
          
	  -- Procedure Creer_Fichier_prw(R: String;prefixe:String;Poid: in T_Vecteur;Poid_Trie: in T_Vecteur) is
	     
end gestion_fichier ;	     
	     
	     
           
           
           
