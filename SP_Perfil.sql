CREATE DEFINER=`` PROCEDURE `SP_Perfil`()
begin
DECLARE condicion int;

set condicion = (SELECT IF(EXISTS( select userSession from user_actual),1,0) );
	
		if condicion = 1 then
        select nombre, apellidos, correo,id_rol from usuarios where usuario=(select userSession from user_actual);
   
        else
        
        select '0' Respuesta, 'Algo salió mal.' Mensaje;
		end if;
end