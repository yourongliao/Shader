Shader "Sbin/vf27"{

	SubShader{

		tags{"queue"="transparent"}

		pass{

			blend srcalpha oneminussrcalpha

			zwrite off

			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag
			#include "unitycg.cginc"


			struct v2f{
				float4 pos:POSITION;
			};

			v2f vert(appdata_base v)
			{
				v2f o;
				float4x4 mvp=UNITY_MATRIX_MVP;
				o.pos=mul(mvp,v.vertex);

				return o;
			}

			fixed4 frag(v2f IN):COLOR
			{
				fixed4 color=fixed4(0,0,1,0.5);

				return color;
			}

			ENDCG
		}

	}

}