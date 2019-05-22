// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'



Shader "Sbin/vf5" {



SubShader{
	 	pass{
	 		CGPROGRAM
	 		#pragma vertex vert
	 		#pragma fragment frag

	 		//#include "sbin/sbin.cginc"

	 		#include "unitycg.cginc"

	 		float4x4 mvp;

	 		float4x4 rm;

	 		float4x4 sm;
	 

	 		struct v2f{
	 			float4 pos:POSITION;

	 			fixed4 color:COLOR;
	 		
	 		};

	 		v2f vert(appdata_base v)
			{
				v2f o;

				float4x4 mvp2=UNITY_MATRIX_MVP;

				float4x4 obj=unity_ObjectToWorld;

				//float4x4 m=mul(mvp2,rm);

				float4x4 m=mul(mvp2,sm);

				o.pos=mul(m,v.vertex);

				//o.color=fixed4(1,0,0,1);

				//if(v.vertex.x>0)
					//o.color=fixed4(1,0,0,1);
				//else
					//o.color=fixed4(0,0,1,1);

				if(v.vertex.x==0.5 && v.vertex.y==0.5 && v.vertex.z==-0.5)
					//o.color=fixed4(1,0,0,1);
					o.color=fixed4(_SinTime.w/2+0.5,_CosTime.w/2+0.5,_SinTime.y/2+0.5,1);
				else
					o.color=fixed4(0,0,1,1);

				//float4 wpos=mul(obj,v.vertex);

				//if(wpos.x>0)
					//o.color=fixed4(1,0,0,1);
				//else
					//o.color=fixed4(0,0,1,1);

				return o;
			}

			fixed4 frag(v2f IN):COLOR
			{
				//return fixed4(1,1,1,1);

				return IN.color;
			}

			ENDCG
	 	}
	 }
}
