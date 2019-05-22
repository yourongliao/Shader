// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'



Shader "Sbin/vf7" {

properties{
	_R("R",range(0,5))=1
	_OX("OX",range(-5,5))=0
}

SubShader{
	 	pass{
	 		CGPROGRAM
	 		#pragma vertex vert
	 		#pragma fragment frag

	 		#include "unitycg.cginc"

	 		float dis;

	 		float r;

	 		float _R;

	 		float _OX;

	 

	 		struct v2f{
	 			float4 pos:POSITION;

	 			fixed4 color:COLOR;
	 		
	 		};

	 		v2f vert(appdata_base v)
			{

				float4 wpos=mul(unity_ObjectToWorld,v.vertex);

				float2 xy=wpos.xz;
				//float d=_R-length(xy);

				float d=_R-length(xy-float2(_OX,_OX));

				d=d<0?0:d;

				float height=1;
				float4 uppos=float4(v.vertex.x,height*d,v.vertex.z,v.vertex.w);

				v2f o;

				float4x4 mvp2=UNITY_MATRIX_MVP;

				o.pos=mul(mvp2,uppos);

				o.color=fixed4(uppos.y,uppos.y,uppos.y,1);

				return o;
			}

			fixed4 frag(v2f IN):COLOR
			{

				return IN.color;
			}

			ENDCG
	 	}
	 }
}
