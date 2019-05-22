Shader "Sbin/vf4" {

properties{
	_MainColor("Main Color",color)=(1,1,1,1)
}

SubShader{
	 	pass{
	 		CGPROGRAM
	 		#pragma vertex vert
	 		#pragma fragment frag

	 		#include "sbin/sbin.cginc"

	 		float4 _MainColor;

	 		uniform float4 _SecondColor;

	 		struct v2f{
	 			float4 pos:POSITION;
	 			float2 objPos:TEXCOORD0;
	 			float4 col:COLOR;
	 		};

	 		v2f vert(appdata_base v)
			{
				v2f o;
				o.pos=float4(v.pos,0,1);
				o.objPos=float2(1,0);
				//o.col=float4(1,1,0,1);

				o.col=v.col;

				return o;

			}

			fixed4 frag(v2f IN):COLOR
			{
				//return IN.col;

				//return _MainColor*0.5 + _SecondColor*0.5;

				return lerp(_MainColor,_SecondColor,0.7);

			}

			ENDCG
	 	}
	 }
}
