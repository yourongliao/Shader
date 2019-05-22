// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Sbin/Textures/vf23"{

	properties{

		_F("F",range(1,10))=4
		_MainTex("MainTex",2D)=""{}

	}

	SubShader{

		pass{

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "unitycg.cginc"

			sampler2D _MainTex;

			float _F;

			struct v2f{

			float4 pos:POSITION;

			float2 uv:TEXCOORD0;

			};

			v2f vert(appdata_base v)
			{
				v2f o;

				float4x4 mvp=UNITY_MATRIX_MVP;

				o.pos=mul(mvp,v.vertex);

				o.uv=v.texcoord.xy;

				return o;
			}

			fixed4 frag(v2f IN):COLOR
			{
				float2 uv=IN.uv;

				float offset_uv=0.05* sin(IN.uv*_F+ _Time.x*2);

				uv+=offset_uv;

				fixed4 color_1=tex2D(_MainTex,uv);

				//float2 uv=IN.uv+_Time.x;

				uv=IN.uv;

				uv-=offset_uv;

				fixed4 color_2=tex2D(_MainTex,uv);

				return (color_1 + color_2)/2;

			}

			ENDCG
		}

	}

}