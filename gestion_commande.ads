with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
Package gestion_commande is 
     
     No_Argument_Error : Exception;
   
   Procedure Gestion_De_Commande ( A : in out float; K: in out Integer ; Mode : in out Boolean ; Epsilon : in out float;prefixe:in out Unbounded_String) with 
   Pre => (A >= 0.0 and A <= 1.0) and (Epsilon >=0.0) and (K >=1 and K<= 150)  ;
     


end gestion_commande;
