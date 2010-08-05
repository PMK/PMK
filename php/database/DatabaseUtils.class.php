<?php
class DatabaseUtils {
	
	public static function generateDsnString($engine, $host, $dbname, $user, $pass) {
		
		$dsnString = '';
		switch(strtolower($engine)) {
			case 'sqlite':
			case 'sqlite2':
			case 'sqlite3':
				$dsnString = $engine . ':' . $dbname;
				break;
			
			case 'mysql':
			case 'mysqli':
				$dsnString = $engine . ':dbname=' . $dbname . ";host=" . $host;
				break;
				
			case 'postgresql':
			case 'psql':
			case 'pgsql':
			case 'postgres':
				$dsnString = $engine . ':dbname=' . $dbname . ";host=" . $host;
				break;
				
			default:
				break;
		}
		return $dsnString;
		
	}
	
}
?>