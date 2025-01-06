switch (state)
{
	case tv_states.normal:
		sprite_index = spr_tv_idle
		if (obj_player.state == states.mach3)
			tv_expression(spr_tv_mach3)
		break;
	case tv_states.transition:
		if t_index + 0.35 < sprite_get_number(spr_tv_trans)
			t_index += 0.35
		else
		{
			state = state_togo
			sprite_index = expr_sprite
		}
		break;
	case tv_states.expr:
		if (obj_player.state != states.mach3)
			tv_expression(spr_tv_idle)
		break;
}

switch (combo.state)
{
	case -1:
		combo.vsp = 0
		combo.y = approach(combo.y, -500, 4)
		if global.combo.timer > 0
			combo.state++
		break;
	case 0:
		combo.vsp += 0.5
		combo.y += combo.vsp
		if (combo.y >= 20)
			combo.state++
		break;
	case 1:
		combo.y = lerp(combo.y, 0, 0.05)
		if (combo.y < 1)
		{
			combo.y = 0
			combo.vsp = 0
			combo.state++
		}
		break;
	case 2:
		var resetpoint = 0
		if (global.combo.timer >= 30)
			resetpoint = 0
		else if (global.combo.timer >= 15)
			resetpoint = 3
		else
			resetpoint = 7
		combo.vsp += 0.25
		combo.y += combo.vsp
		if (combo.y > 0)
		{
			combo.y = -resetpoint
			combo.vsp = 0
		}
		break;
}

combo.x = wave(-10, 10, 2, 20)
combo.ghost.x = lerp(combo.ghost.x, combo.x - 75 + ((global.combo.timer / 60) * 150), 0.5)
combo.ghost.y = combo.y
combo.ghost.image_index += 0.35
combo.ghost.image_index = wrap(sprite_get_number(spr_tv_c_ghost), combo.ghost.image_index)

if global.combo.timer <= 0
	combo.state = -1

var y_goto = ystart
if (obj_player.x > room_width - 250 && obj_player.y < 175)
	y_goto = -500
	
y = approach(y, y_goto, 25)
