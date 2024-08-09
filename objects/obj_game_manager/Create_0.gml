enum STATES{
	LEVEL_START,
	ENEMY_GENERATE,
	PLAYER_ROUND_INITIAL,
	PLAYER_ROUND,
	ENEMY_ROUND,
	LEVEL_END,
}
enemies = ds_list_create();
attacking = ds_list_create();
attacked = ds_list_create();

state = STATES.LEVEL_START;

attack_timer = 0;