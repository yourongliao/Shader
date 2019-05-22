// Upgrade NOTE: commented out 'float4 unity_LightmapST', a built-in variable

// Upgrade NOTE: commented out 'float4 unity_LightmapST', a built-in variable
// Upgrade NOTE: commented out 'sampler2D unity_Lightmap', a built-in variable
// Upgrade NOTE: replaced tex2D unity_Lightmap with UNITY_SAMPLE_TEX2D

Shader "Sbin/Textures/vf19"{

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

			// sampler2D unity_Lightmap;

			float4 _MainTex_ST;

			// float4 unity_LightmapST;

			// float4 unity_LightmapST;

			struct v2f{

			float4 pos:POSITION;

			float2 uv:TEXCOORD0;

			float2 uv2:TEXCOORD1;

			};

			v2f vert(appdata_full v)
			{
				v2f o;

				float4x4 mvp=UNITY_MATRIX_MVP;

				o.pos=mul(mvp,v.vertex);

				//o.uv=v.texcoord.xy* _MainTex_ST.xy + _MainTex_ST.zw;

				o.uv=TRANSFORM_TEX(v.texcoord,_MainTex)

				o.uv2=v.texcoord1.xy*unity_LightmapST.xy + unity_LightmapST.zw;

				return o;
			}

			fixed4 frag(v2f IN):COLOR
			{
				//return fixed4(1,1,1,1);

				//fixed4 color=tex2D(_MainTex,float2(0.5,0.7));

				//fixed4 color=tex2D(_MainTex,float2(1,1));

				//fixed4 color=tex2D(_MainTex,float2(1,1));

				//fixed4 color=tex2D(_MainTex,float2(_U,0.1));

				float3 lm=DecodeLightmap(UNITY_SAMPLE_TEX2D(unity_Lightmap,IN.uv2));

				fixed4 color=tex2D(_MainTex,IN.uv);

				color.rgb*=lm*2;

				return color;
			}

			ENDCG
		}

	}

}