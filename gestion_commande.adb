with Ada.IO_Exceptions;
with Ada.Text_IO;			use Ada.Text_IO;
with Ada.Float_Text_IO;		use Ada.Float_Text_IO;
with Ada.Integer_Text_IO;	use Ada.Integer_Text_IO;
with Ada.Command_line;		use Ada.Command_line;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;


Package body gestion_commande is 

	Procedure Gestion_De_Commande ( A : in out float; K: in out Integer ; Mode : in out Boolean ; Epsilon : in out float;Prefixe: in out Unbounded_String) is 
	
	indice: Integer:= 1;
	Choix: Unbounded_String;
   Begin
   
       if Argument_Count < 1 then
		    raise No_Argument_Error;
	    end if;
	
		while indice < Argument_Count loop
			Choix:= To_Unbounded_String(Argument(indice));
			if Choix = "-K" then
				-- Choix du nombre des itérations
				K:= Integer'Value(Argument(indice+1));
				indice := indice + 2;
			elsif Choix = "-A" then
				-- Choix de la vleur de Alpha
				A := Float'Value(Argument(indice+1));
				indice := indice + 2;
			elsif Choix = "-E" then
				-- Choix de la précision
				Epsilon := Float'Value(Argument(indice+1));
				indice := indice +2;
			elsif Choix="-P" then
				-- Choix du mode de travail( Sois Pleine Ou Creuse ) 
				Mode := True;
				indice := indice + 1;
			elsif Choix = "-R" then
				-- Choix du prefixe
				prefixe := To_Unbounded_String(Argument(indice+1));
				indice := indice +2;
			else
				New_Line;
				Put("Les options possibles sont");
				New_Line;
				Put("-K pour choisir le nombre des iterations");
				Put_Line("-A pour choisir la valeur de Alpha");
				Put_Line("-P pour choisir le mode matrice pleine");
              			Put_Line("-E pour choisir la précision");
              			Put_Line("-R pour ecrire un prefixe pour les fichiers sortis");
              			exit;
			end if;
		end loop;
	end Gestion_De_Commande;


end gestion_commande;	
				
			
			
			
			
			
				
				
				
				
				
				
				
