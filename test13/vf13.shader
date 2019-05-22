// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Sbin/vf13"{

SubShader{

	//pass
	//{
	//	tags{"lightmode"="shadowcaster"}
	//}

	pass
	{
		tags{"LightMode"="ForwardBase"}

		//tags{"LightMode"="Vertex"}
		
		CGPROGRAM
// Upgrade NOTE: excluded shader from DX11; has structs without semantics (struct v2f members wpos)
		//#pragma exclude_renderers d3d11

		#pragma vertex vert
		#pragma fragment frag
		#pragma multi_compile_fwdbase

		#include "unitycg.cginc"

		#include "lighting.cginc"

		#include "AutoLight.cginc"

		struct v2f{
			float4 pos:POSITION;
			fixed4 color:COLOR;
			//unityShadowCoord3 _LightCoord : TEXCOORD0;
			//unityShadowCoord3 _ShadowCoord : TEXCOORD1;
			//float3 wpos;
			LIGHTING_COORDS(0,1)
		};

		v2f vert(appdata_base v)
		{
			v2f o;

			float4x4 mvp=UNITY_MATRIX_MVP;



			o.pos=mul(mvp,v.vertex);
			//o.color=fixed4(0,0,1,1);

			float3 N=normalize(v.normal);

			float3 L=normalize(_WorldSpaceLightPos0);

			//L=mul(unity_WorldToObject,float4(L,0)).xyz;

			//N=mul(unity_ObjectToWorld,float4(N,0)).xyz;

			N=mul(float4(N,0),unity_WorldToObject).xyz;

			N=normalize(N);

			float ndotl=saturate(dot(N,L));

			o.color=_LightColor0*ndotl;

			float3 wpos=mul(unity_ObjectToWorld,v.vertex).xyz;

			//o.wpos=wpos;

			//o.color.rgb=ShadeVertexLights(v.vertex,v.normal);

			o.color.rgb+=Shade4PointLights(unity_4LightPosX0,unity_4LightPosY0,unity_4LightPosZ0,
											unity_LightColor[0].rgb,unity_LightColor[1].rgb,
											unity_LightColor[2].rgb,unity_LightColor[3].rgb,
											unity_4LightAtten0,
											wpos,N);

			TRANSFER_VERTEX_TO_FRAGMENT(o)
			return o;
		}

		fixed4 frag(v2f IN):COLOR
		{
			
			float atten= LIGHT_ATTENUATION(IN);

			//UNITY_LIGHT_ATTENUATION(atten,IN,IN.wpos)

			fixed4 col=(IN.color + UNITY_LIGHTMODEL_AMBIENT);

			col.rgb *=atten;

			return col;
		}

		ENDCG
	}

	pass
	{
		tags{"LightMode"="ForwardAdd"}

		blend one one

		//tags{"LightMode"="Vertex"}
		
		CGPROGRAM

		#pragma vertex vert
		#pragma fragment frag
		#pragma multi_compile_fwdadd_fullshadows

		#include "unitycg.cginc"

		#include "lighting.cginc"

		#include "AutoLight.cginc"

		struct v2f{
			float4 pos:POSITION;
			fixed4 color:COLOR;
			//unityShadowCoord3 _LightCoord : TEXCOORD0;
			//unityShadowCoord3 _ShadowCoord : TEXCOORD1;
			LIGHTING_COORDS(0,1)
		};

		v2f vert(appdata_base v)
		{
			v2f o;

			float4x4 mvp=UNITY_MATRIX_MVP;



			o.pos=mul(mvp,v.vertex);
			//o.color=fixed4(0,0,1,1);

			float3 N=normalize(v.normal);

			float3 L=normalize(_WorldSpaceLightPos0);

			//L=mul(unity_WorldToObject,float4(L,0)).xyz;

			//N=mul(unity_ObjectToWorld,float4(N,0)).xyz;

			N=mul(float4(N,0),unity_WorldToObject).xyz;

			N=normalize(N);

			float ndotl=saturate(dot(N,L));

			o.color=_LightColor0*ndotl;

			float3 wpos=mul(unity_ObjectToWorld,v.vertex).xyz;

			//o.color.rgb=ShadeVertexLights(v.vertex,v.normal);

			o.color.rgb+=Shade4PointLights(unity_4LightPosX0,unity_4LightPosY0,unity_4LightPosZ0,
											unity_LightColor[0].rgb,unity_LightColor[1].rgb,
											unity_LightColor[2].rgb,unity_LightColor[3].rgb,
											unity_4LightAtten0,
											wpos,N);

			TRANSFER_VERTEX_TO_FRAGMENT(o)
			return o;
		}

		fixed4 frag(v2f IN):COLOR
		{
			
			float atten= LIGHT_ATTENUATION(IN);

			fixed4 col=(IN.color);

			col.rgb *=atten;

			return col;
		}

		ENDCG
	}
}

	fallback "Diffuse"

}