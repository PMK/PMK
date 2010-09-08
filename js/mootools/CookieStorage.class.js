/**
 * Cookie storage class for Mootools 1.2.x
 * 
 * @author Patrick Klaassen
 * @copyright (c)2009 Patrick Klaassen
 * @since 22-07-2010
 * @version 1.0
 * @license MIT-license
 * 
 * @example:
 * var cookie = new CookieStorage();
 * cookie.writeData('keyname', 'value');
 * alert(cookie.readData('keyname'));
 * cookie.erase();
 */
CookieStorage = new Class({

	Implements: [Options],

	/**
	 * @type {Object}
	 */
	options: {
		storageName: 'here_a_nice_cookie_name',
		path: '/',
		//0: session, 1: 1 day etc
		duration: 30,
		secure: false
	},

	/**
	 * @type {Hash.Cookie}
	 */
	storageData: null,

	/**
	 * @param {Object} options
	 */
	initialize: function(options) {

		this.setOptions(this.options, options);

		this.storageData = new Hash.Cookie(
			this.options.storageName,
			{
				path: this.options.path,
				duration: this.options.duration,
				secure: this.options.secure
			}
		);
	},

	/**
	 * Write data to the storage.
	 * Data is stored as a key value pair
	 *
	 * @param {String} key
	 * @param {Mixed} value
	 * @return {Mixed} The passed value
	 */
	writeData: function(key, value) {
		this.storageData.set(key, value);
		return value;
	},

	/**
	 * Read data from the storage
	 * If the key was not stored will return null
	 *
	 * @param {String} key
	 * @return {Mixed}
	 */
	readData: function(key) {
		if(this.containsKey(key)) {
			return this.storageData.get(key);
		} else {
			return null;
		}
	},

	/**
	 * Returns true if passed key was set in storage
	 *
	 * @param {String} key
	 * @return {Boolean}
	 */
	containsKey: function(key) {
		return this.storageData.has(key);
	},

	/**
	 * Remove all data from the Storage (remove cookie)
	 */
	erase: function() {
		this.storageData.dispose();
	}

});
