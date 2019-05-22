Shader "Sbin/Textures/vf20"{

	properties{
		_MainTex("MainTex",2D)=""{}
	}

	SubShader{

		pass{

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "unitycg.cginc"

			sampler2D _MainTex;

			float4 _MainTex_ST;

			struct v2f{

			float4 pos:POSITION;

			float2 uv:TEXCOORD0;

			};

			v2f vert(appdata_base v)
			{
				v2f o;

				float4x4 mvp=UNITY_MATRIX_MVP;

				o.pos=mul(mvp,v.vertex);


				o.uv=TRANSFORM_TEX(v.texcoord,_MainTex)


				return o;
			}

			fixed4 frag(v2f IN):COLOR
			{
				
				fixed4 color=tex2D(_MainTex,IN.uv);

				return color;
			}

			ENDCG
		}

	}

}