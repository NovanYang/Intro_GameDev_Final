//gam state machine
enum STATES{
	LEVEL_START,
	ENEMY_GENERATE,
	PLAYER_ROUND_INITIAL,
	PLAYER_ROUND,
	ENEMY_ROUND,
	LEVEL_END,
}

//three different list for enemies in different state, might change that for better OOP
enemies = ds_list_create();
attacking = ds_list_create();
attacked = ds_list_create();

state = STATES.LEVEL_START;

attack_timer = 0;