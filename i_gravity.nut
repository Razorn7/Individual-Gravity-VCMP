/*--------------------------------------
 |                                     |
 |   Individual Gravity system v0.2    |
 |       by razorn7 (Razor#8139)       |
 |                                     |
 ---------------------------------------*/

/* ---- Register a global variable to store the gravity values of the players ---- */

g_arr <- array(GetMaxPlayers(), null);


/* ---- Register CPlayer() functions to work with 'player' entity ---- */

/* player.SetGravity(int) */
function CPlayer::SetGravity(gravity) {
    if (typeof gravity == "integer" || typeof gravity == "float") {
       ::g_arr[ID].value = gravity;
    } else throw "parameter 1 has an invalid type '" + typeof gravity + "'; expected: 'integer|float'";
}

/* player.GetGravity(void) */
function CPlayer::GetGravity() {
	return ::g_arr[ID].value;
}


/* ---- Register CGravity() class, here is where our code starts working ---- */

class CGravity
{
	newZ = 0;
	lastZ = 0;
	def_value = 0;
	value = 0;
	gravityValue = 0.008;
	
	function join(/*instance*/ entity) {
		::g_arr[entity.ID] = this();
	}
	
	/* ---- The magic is made here ---- */
	
	function processMove(/*instance*/ entity) {
		if (::g_arr[entity.ID].value != this.def_value) {
			::g_arr[entity.ID].lastZ = ::g_arr[entity.ID].newZ;
			::g_arr[entity.ID].newZ = entity.Speed.z;
			
			if (::g_arr[entity.ID].lastZ == ::g_arr[entity.ID].newZ) {
				return;
			}
			else if (::g_arr[entity.ID].lastZ > ::g_arr[entity.ID].newZ) {
				entity.Speed.z += (gravityValue * entity.GetGravity());
			}
		}
	}
}
