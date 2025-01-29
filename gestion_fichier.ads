
package gestion_fichier is 
      
      --fonction qui retourn la capacite des matrices a partir du fichier 
      Function Get_Taille(R: String) return Integer with 
      Post => Get_Taille'Result > 0 ;
end gestion_fichier;
           
