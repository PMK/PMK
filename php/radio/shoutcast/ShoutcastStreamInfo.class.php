<?php
/**
 * Get info of a Shoutcast stream
 * 
 * @author Patrick Klaassen
 * @copyright (c)2009 Patrick Klaassen
 * @since 28-03-2009
 * @version 1.0
 * @license MIT-license
 */
class ShoutcastStreamInfo {
	
	/**
	 * Adres to connect
	 * (must be an IP)
	 * 
	 * @var string
	 */
	private $adres = "127.0.0.1";
	
	/**
	 * Port to connect
	 * 
	 * @var int
	 */
	private $port = 8000;
	
	/**
	 * Contains Shoutcast stream information
	 * 
	 * @var array
	 */
	protected static $info = array();
	
	
	/**
	 * Construct for 'Shoutcast stream info'- class
	 * 
	 * @param string $adres
	 * @param int $port
	 * @return bool
	 */
	public function __construct($adres, $port) {
		
		$this->adres = $adres;
		$this->port  = $port;
		
		if ($fp = @fsockopen($this->adres, $this->port, &$errno, &$errstr, 3)) {
			
			fputs($fp, "GET /7.html HTTP/1.0\r\nUser-Agent: XML Getter (Mozilla Compatible)\r\n\r\n");
			
			while (!feof($fp)) {
				$rawResult = fgets($fp, 1000);
			}
			
			fclose($fp);
			
			self::$info = $this->parseRawShoutcastResult($rawResult);
			return true;
			
		}
	}
	
	
	/**
	 * Parse the raw result to an array with the stream info
	 * 
	 * @param string $rawShoutcastResult
	 * @return array
	 */
	private function parseRawShoutcastResult($rawShoutcastResult) {
		
		try {
			$rawShoutcastResult = ereg_replace(".*<body>", "", $rawShoutcastResult);
			$rawShoutcastResult = ereg_replace("</body>.*", ",", $rawShoutcastResult);
			
			$parsedShoutcastInfo = explode(",", $rawShoutcastResult);
			
			return $parsedShoutcastInfo;
			
		} catch (Exception $e) {
			throw new Exception($e);
		}
		
	}
	
	
	/**
	 * Returns amout of listeners
	 * 
	 * @return string
	 */
	public function getAmountListeners() {
		return self::$info[0] !== null ? self::$info[0] : 0;
	}
	
	
	/**
	 * Returns connection status
	 * 
	 * @return string
	 */
	public function getConnectionStatus() {
		return self::$info[1];
	}
	
	
	/**
	 * Returns listeners peak
	 * 
	 * @return string
	 */
	public function getListenersPeak() {
		return self::$info[2];
	}
	
	
	/**
	 * Returns max listeners
	 * 
	 * @return string
	 */
	public function getMaxListeners() {
		return self::$info[3] !== null ? self::$info[3] : 1000;
	}
	
	
	/**
	 * Returns unique listeners
	 * 
	 * @return string
	 */
	public function getUniqueListeners() {
		return self::$info[4];
	}
	
	
	/**
	 * Returns the bitrate of the stream
	 * 
	 * @return string
	 */
	public function getBitrate() {
		return self::$info[5];
	}
	
	
	/**
	 * Returns current song
	 * 
	 * @return string
	 */
	public function getCurrentSong() {
		return self::$info[6];
	}
	
}
?>
