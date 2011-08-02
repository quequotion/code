/***
  BEGIN LICENSE
	
  Copyright (C) 2011 Giulio Collura <random.cpp@gmail.com>
  This program is free software: you can redistribute it and/or modify it	
  under the terms of the GNU Lesser General Public License version 3, as published	
  by the Free Software Foundation.
	
  This program is distributed in the hope that it will be useful, but	
  WITHOUT ANY WARRANTY; without even the implied warranties of	
  MERCHANTABILITY, SATISFACTORY QUALITY, or FITNESS FOR A PARTICULAR	
  PURPOSE.  See the GNU General Public License for more details.
	
  You should have received a copy of the GNU General Public License along	
  with this program.  If not, see <http://www.gnu.org/licenses/>	
  
  END LICENSE	
***/

using Soup;
 
namespace Scratch.Services {
 
    public class PasteBin : GLib.Object {

		public const string NEVER = "N";
		public const string TEN_MINUTES = "10M";
		public const string HOUR = "1H";
		public const string DAY = "1D";
		public const string MONTH = "1M";

		public const string PRIVATE = "1";
		public const string PUBLIC = "0";

	
		public static string submit (string paste_code, string paste_name, 
                                     string paste_private, string paste_expire_date, 
                                     string paste_format) {

			string api_url = "http://pastebin.com/api_public.php";
	
			var session = new SessionSync ();
			var message = new Message ("POST", api_url);
            
			string request = Form.encode (
				"option", "paste",
				"paste_code", paste_code,
				"paste_name", paste_name,
				"paste_private", paste_private,
				"paste_expire_date", paste_expire_date,
				"paste_format", paste_format);
            
			message.set_request ("application/x-www-form-urlencoded", MemoryUse.COPY, request.data);
			message.set_flags (MessageFlags.NO_REDIRECT);
            
			session.send_message (message);

			var output = message.response_body.data;

			return (string) output;

		}
			 
    }
}
