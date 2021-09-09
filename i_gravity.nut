/*--------------------------------------
 |                                     |
 |   Individual Gravity system v0.2    |
 |       by razorn7 (Razor#1735)       |
 |                                     |
 ---------------------------------------*/

/* ---- Register a global variable to store the gravity values of the players ---- */

g_arr <- array(GetMaxPlayers(), null);


/* ---- Register CPlayer() functions to work with 'player' entity ---- */

/* player.SetGravity(number value) */
function CPlayer::SetGravity(value) {
    if (typeof value == "integer" || typeof value == "float") {
	   ::g_arr[ID].value = value;
    } else throw "parameter 1 has an invalid type '" + typeof value + "'; expected: 'integer|float'";
}

/* player.GetGravity(void) */
function CPlayer::GetGravity() {
	return ::g_arr[ID].value != null ? ::g_arr[ID].value : 0;
}

/* ---- Register CGravity() class, here is where our code starts working ---- */

class CGravity {
	value = 0;
	def_value = 0;
	g_value = 0.008;
	
	newZ = 0;
	lastZ = 0;
	
	function join(/*instance*/ entity) {
		::g_arr[entity.ID] = this();
	}
	
	/* ---- The magic is made here ---- */
	function processMove(/*instance*/ entity) {
		if (entity.GetGravity() != 0) {
			::g_arr[entity.ID].lastZ = ::g_arr[entity.ID].newZ;
			::g_arr[entity.ID].newZ = entity.Speed.z;

			if (::g_arr[entity.ID].lastZ == ::g_arr[entity.ID].newZ) {
				return;
			}
			else if (::g_arr[entity.ID].lastZ > ::g_arr[entity.ID].newZ) {
				entity.Speed.z += (g_value * entity.GetGravity());
			}
		}
	}
}
