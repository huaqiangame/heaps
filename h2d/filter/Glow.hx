package h2d.filter;

class Glow extends Blur {

	public var color : Int;
	public var alpha : Float;

	public function new( color : Int = 0xFFFFFF, alpha = 1., quality = 1, passes = 1, sigma = 1. ) {
		super(quality, passes, sigma);
		this.color = color;
		this.alpha = alpha;
		pass.shader.hasFixedColor = true;
	}

	override function draw( ctx : RenderContext, t : h2d.Tile ) {
		pass.shader.fixedColor.setColor(color);
		pass.shader.fixedColor.w = alpha;
		var save = ctx.textures.allocTarget("glowSave", ctx, t.width, t.height, false);
		h3d.pass.Copy.run(t.getTexture(), save, None);
		pass.apply(t.getTexture(), ctx.textures.allocTarget("glowTmp", ctx, t.width, t.height, false));
		h3d.pass.Copy.run(save, t.getTexture(), Alpha);
		return t;
	}

}