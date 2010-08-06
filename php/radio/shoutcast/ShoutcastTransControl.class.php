<?php
/**
 * Control Shoutcast sc_trans
 * 
 * @author Patrick Klaassen
 * @copyright (c)2009 Patrick Klaassen
 * @since 28-03-2009
 * @version 1.0
 * @license MIT-license
 */
class ShoutcastTransControl {
	
	
	/**
	 * Play next track
	 * 
	 * @return void
	 */
	public static function nextTrack() {
		shell_exec('kill -WINCH ' . ShoutcastTransControl::getPID());
	}
	
	
	/**
	 * Flush the log file
	 * 
	 * @return void
	 */
	public static function flushLogFile() {
		shell_exec('kill -HUP ' . ShoutcastTransControl::getPID());
	}
	
	
	/**
	 * Reload playlist (.lst)
	 * 
	 * @return void
	 */
	public static function reloadPlaylist() {
		shell_exec('kill -USR1 ' . ShoutcastTransControl::getPID());
	}
	
	
	/**
	 * Toggle shuffle on/off
	 * 
	 * @return void
	 */
	public static function toggleShuffle() {
		shell_exec('kill -USR2 ' . ShoutcastTransControl::getPID());
	}
	
	
	/**
	 * Returns all sc_trans PID's
	 * 
	 * @return string
	 */
	private static function getPID() {
		return shell_exec('ps faux | grep sc_trans | awk \' { print $2 } \'  | xargs');
	}
	
}
?>
