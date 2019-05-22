
Shader "Sbin/vf8" {

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

				float4x4 mvp=UNITY_MATRIX_MVP;

				//float angle=length(v.vertex)*_SinTime.w;

				float angle=v.vertex.z*_Time.y;

				//float4x4 m={

				//	float4(cos(angle),0,sin(angle),0),

				//	float4(0,1,0,0),

				//	float4(-sin(angle),0,cos(angle),0),

				//	float4(0,0,0,1)
				//};

				//float x=cos(angle)*v.vertex.x+sin(angle)*v.vertex.z;
				//float z=cos(angle)*v.vertex.z-sin(angle)*v.vertex.x;

				//v.vertex.x=x;
				//v.vertex.z=z;

				float4x4 m={
					float4(sin(angle)/8+0.5,0,0,0),
					float4(0,1,0,0),
					float4(0,0,1,0),
					float4(0,0,0,1)
				};

				//m=mul(mvp,m);

				v.vertex=mul(m,v.vertex);

				v2f o;

				o.pos=mul(mvp,v.vertex);

				o.color=fixed4(0,1,1,1);

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
