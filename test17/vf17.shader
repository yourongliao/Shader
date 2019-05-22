Shader "Sbin/Textures/vf17"{

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
				//return fixed4(1,1,1,1);

				//fixed4 color=tex2D(_MainTex,float2(0.5,0.7));

				//fixed4 color=tex2D(_MainTex,float2(1,1));

				//fixed4 color=tex2D(_MainTex,float2(1,1));

				//fixed4 color=tex2D(_MainTex,float2(_U,0.1));

				fixed4 color=tex2D(_MainTex,IN.uv);

				return color;
			}

			ENDCG
		}

	}

}