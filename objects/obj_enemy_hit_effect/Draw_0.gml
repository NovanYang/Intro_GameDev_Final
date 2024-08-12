effect_timer++

if(effect_timer < effect_duration){
	draw_self();
}
else{
	instance_destroy(id);
}