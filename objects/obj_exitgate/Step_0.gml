if global.panic
	exit;

with instance_place(x, y, obj_player)
{
	if (anim_ended() && sprite_index == spr_player_exitdoor)
	{
		shake_camera()
		reset_anim(spr_player_timesup)
		other.image_index++
		scr_sound_3d(sfx_groundpound, x, y)
		global.doorshut = true
	}
}
