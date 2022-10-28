<?php
	
Class phpConn
{
	private $mysqli;
	private $databasehost = "root";
	private $databaseuser = "root";
	private $databasepass = "BringmetheOwsla2698";
	private $databasename = "musicstore";
	public function connectDB() 
	{
		$mysqli = new mysqli("localhost", $this->$databaseuser, $this->$databasepass, $this->$databasename,33065);
		if ($mysqli->connect_errno) 
		{
			echo "Problema con la conexion a la base de datos";
		}else echo "Connection Successful";
		return $mysqli;
	}
	
	function registro($nombres,$apellidos,$usuario,$correo,$contrasena,$sexo,$fecha,$idrol)
    {
		echo $nombres.",".$apellidos.",".$usuario.",".$correo.",".$contrasena.",".$sexo.",".$fecha.",".$idrol;
		$this->mysqli = new mysqli("localhost", $this->databaseuser, $this->databasepass, $this->databasename,33065);
		if ($this->mysqli->connect_errno) 
		{
			echo "Problema con la conexion a la base de datos";
		}else 
		{
			echo "Connection Successful";
			$sentencia = $this->mysqli->prepare("CALL SP_Registro(?,?,?,?,?,?,?,?)");
			$sentencia->bind_param('ssssssss', $nombres, $apellidos, $usuario, $correo, $contrasena, $sexo, $fecha, $idrol);
			$sentencia->execute();
			
			$sentencia->close();
			$this->mysqli->Close();

			//mysqli_close($sentencia);
			//mysqli_close($this->mysqli);

			header("Location:login.html");
			die();
		}
	}

	function VLogin($p_usuario, $p_contrasena, $p_rol)
	{
		$this->mysqli = new mysqli("localhost", $this->databaseuser, $this->databasepass, $this->databasename,33065);
		if ($this->mysqli->connect_errno) 
		{
			echo "Problema con la conexion a la base de datos";
		}else echo "Connection Successful, datos: ".$p_usuario." ".$p_contrasena." ".$p_rol;

		$sentencia = $this->mysqli->prepare("CALL SP_Login(?,?,?)");
		$sentencia->bind_param('sss', $p_usuario, $p_contrasena, $p_rol);
		$sentencia->execute();
		if($sentencia){
			$resultado = $sentencia->get_result();
					while( $r = $resultado->fetch_assoc()) {
					                $rows[] = $r;
					         }                   
							  
					$ValorRegresado = json_encode($rows,JSON_UNESCAPED_UNICODE);
					$array = (array)json_decode($ValorRegresado);
					if($array[0]->Respuesta == 1){		
						
						if($p_rol == "Usuario"){

							header("Location: index.php");
						}else{
							header("Location: index_vendedor.php");
						}
					}else{
						header("Location: login.html");
							
					}

				}else{
					echo "error en la llamada";
				}		
		
		$sentencia->close();
		$this->mysqli->Close();
	}

	function showUserData()
	{
		$this->mysqli = new mysqli("localhost", $this->databaseuser, $this->databasepass, $this->databasename,33065);
		if ($this->mysqli->connect_errno) 
		{
			echo "Problema con la conexion a la base de datos";
		}else echo "Connection Successful";

		$sentencia = $this->mysqli->prepare("CALL SP_Perfil()");
		$sentencia->execute();
		if($sentencia){
			$resultado = $sentencia->get_result();
					while( $r = $resultado->fetch_assoc()) {
					                $rows[] = $r;
					         }                   
							  
					$ValorRegresado = json_encode($rows,JSON_UNESCAPED_UNICODE);
					$array = (array)json_decode($ValorRegresado);

				}else{
					echo "error en la llamada";
				}		
		
		$sentencia->close();
		$this->mysqli->Close();
	}

	function updateUserData($p_nombre,$p_apellidos,$p_correo)
	{
		$this->mysqli = new mysqli("localhost", $this->databaseuser, $this->databasepass, $this->databasename,33065);
		if ($this->mysqli->connect_errno) 
		{
			echo "Problema con la conexion a la base de datos";
		}

		$sentencia = $this->mysqli->prepare("CALL SP_ModificaUser(?,?,?)");
		$sentencia->bind_param('sss', $p_nombre, $p_apellidos, $p_correo);
		$sentencia->execute();	
		
		if($sentencia){
			echo "nice";
		}else{echo "efe";}

		$sentencia->close();
		$this->mysqli->Close();
		header("Location: index.php");
	}
	function registroProductos($nombre,$precio,$categoria,$cantidad,$tipo,$descripcion)
	{
		echo $nombres.",".$apellidos.",".$usuario.",".$correo.",".$contrasena.",".$sexo.",".$fecha.",".$idrol;
		$this->mysqli = new mysqli("localhost", $this->databaseuser, $this->databasepass, $this->databasename,33065);
		if ($this->mysqli->connect_errno) 
		{
			echo "Problema con la conexion a la base de datos";
		}else 
		{
			echo "Connection Successful";
			$sentencia = $this->mysqli->prepare("CALL SP_RegistroProducto(?,?,?,?,?,?)");
			$sentencia->bind_param('ssssss', $nombre,$descripcion,$categoria,$tipo,$precio,$cantidad);
			$sentencia->execute();
			
			$sentencia->close();
			$this->mysqli->Close();
	
			//mysqli_close($sentencia);
			//mysqli_close($this->mysqli);
	
			header("Location:index_vendedor.php");
			die();
		}
	}
	function creaCategoria($categoria,$descripcion)
	{
		$this->mysqli = new mysqli("localhost", $this->databaseuser, $this->databasepass, $this->databasename,33065);
		if ($this->mysqli->connect_errno) 
		{
			echo "Problema con la conexion a la base de datos";
		}else 
		{
			echo "Connection Successful";
			$sentencia = $this->mysqli->prepare("CALL SP_CreaCategoria(?,?)");
			$sentencia->bind_param('ss', $categoria,$descripcion);
			$sentencia->execute();
			if($sentencia){
				$resultado = $sentencia->get_result();
						while( $r = $resultado->fetch_assoc()) {
										$rows[] = $r;
								 }                   
								  
						$ValorRegresado = json_encode($rows,JSON_UNESCAPED_UNICODE);
						$array = (array)json_decode($ValorRegresado);
						if($array[0]->Respuesta == 1){		
							echo '<script language="javascript">console.log("Categoría ya existe");</script>';
							$sentencia->close();
							$this->mysqli->Close();
					
							header("Location:categorias.php");
							die();
						}else{
							$sentencia->close();
							$this->mysqli->Close();
					
							header("Location:categorias.php");
							die();
						}
					}else{
						echo "error en la llamada";
					}	
			
			
		}
	}

}















//Esto es para mandar a ejecutar un query (villareatas no te deja hacer esto, de directo, todo es por SP)
	function getPuntosMedia(){
		$mysqli = connectDB();
		//$result = $mysqli->query("select * from usuarios");			
		$result = $mysqli->query("CALL SP_Usuario()");			
		//$result = $mysqli->query("CALL SP_Registro('".$nombres."','".$apellidos."','".$usuario."','".$correo."','".$contrasena."','".$sexo."','".$fecha."','".$rol."')");			
		if (!$result) {
			echo "Problema al hacer un query: " . $mysqli->error;								
		} else {
			$rows = array();
			while( $r = $result->fetch_assoc()) {
				$rows[] = $r;
				}			
			echo json_encode($rows);
			}
			mysqli_close($mysqli);
	}

	

	//registro();


?>