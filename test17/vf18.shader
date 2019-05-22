Shader "Sbin/Textures/vf18"{

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

			//float tilling_x;

			//float tilling_y;

			//float offset_x;

			//float offset_y;

			struct v2f{

			float4 pos:POSITION;

			float2 uv:TEXCOORD0;

			};

			v2f vert(appdata_base v)
			{
				v2f o;

				float4x4 mvp=UNITY_MATRIX_MVP;

				o.pos=mul(mvp,v.vertex);

				//o.uv=v.texcoord.xy* _MainTex_ST.xy + _MainTex_ST.zw;

				o.uv=TRANSFORM_TEX(v.texcoord,_MainTex)

				//o.uv=v.texcoord.xy;

				//o.uv.x*=tilling_x;

				//o.uv.y*=tilling_y;

				//o.uv.x+=offset_x;

				//o.uv.y+=offset_y;

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