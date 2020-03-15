shader_type canvas_item;

uniform float width : hint_range(0.0, 30.0);
uniform vec4 outline_color : hint_color; 

void fragment()
{
	vec4 sprite_color = texture(TEXTURE, UV);
	float alpha = -4.0 * sprite_color.a;
	alpha += texture(TEXTURE, UV + vec2(0.1, 0.0)).a;
	alpha += texture(TEXTURE, UV + vec2(-0.1, 0.0)).a;
	alpha += texture(TEXTURE, UV + vec2(0.0, 0.1)).a;
	alpha += texture(TEXTURE, UV + vec2(0.0, -0.1)).a;

	COLOR = vec4(outline_color.rgb, alpha);
}