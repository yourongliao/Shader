// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Sbin/Textures/vf24"{

	properties{

		_F("F",range(1,10))=4
		_MainTex("MainTex",2D)=""{}
		_SecondTex("SecondTex",2D)=""{}

	}

	SubShader{

		pass{

			colormask b

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "unitycg.cginc"

			sampler2D _MainTex;

			sampler2D _SecondTex;

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

				fixed4 mainColor=tex2D(_MainTex,IN.uv);

				float2 offset_uv= 0.05* sin(IN.uv*_F+ _Time.x*2);

				float2 uv= IN.uv+offset_uv;

				uv.y+=0.3;

				fixed4 color_1= tex2D(_SecondTex,uv);

				mainColor.rgb*= color_1.b;

				mainColor.rgb*=1.5;

				uv= IN.uv-offset_uv;

				fixed4 color_2= tex2D(_SecondTex,uv);

				uv.y+=0.3;

				mainColor.rgb*= color_2.b;

				mainColor.rgb*=1.5;


				return mainColor;

			}

			ENDCG
		}

	}

}