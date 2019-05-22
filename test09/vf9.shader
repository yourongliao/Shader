
Shader "Sbin/vf9" {

SubShader{
	 	pass{
	 		CGPROGRAM
	 		#pragma vertex vert
	 		#pragma fragment frag

	 		#include "unitycg.cginc"

	 

	 		struct v2f{
	 			float4 pos:POSITION;

	 			fixed4 color:COLOR;
	 		
	 		};

	 		v2f vert(appdata_base v)
			{
				//v.vertex.y+= 0.2*sin(v.vertex.z*2+_Time.y);

				//v.vertex.y+= 0.2*sin(-length(v.vertex.xz)*2+_Time.y);

				v.vertex.y+= 0.2*sin((v.vertex.x+v.vertex.z) +_Time.y);
				v.vertex.y+= 0.3*sin((v.vertex.x-v.vertex.z) +_Time.w);

				float4x4 mvp=UNITY_MATRIX_MVP;

				v2f o;

				o.pos=mul(mvp,v.vertex);

				//o.color=fixed4(0,1,1,1);

				o.color=fixed4(v.vertex.y,v.vertex.y,v.vertex.y,1);

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
