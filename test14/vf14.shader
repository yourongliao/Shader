// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Sbin/vf14"{

properties
 {
 	_Scale("Scale",range(1,8))=2
 }

SubShader
 {

 	tags{"queue"="transparent"}

	pass
	{
		blend srcAlpha oneMinussrcalpha

		zwrite off

		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag

		#include "unitycg.cginc"

		float _Scale;

		struct v2f{
			float4 pos: POSITION;

			float3 normal:TEXCOORD0;

			float4 vertex:TEXCOORD1;
		};

		v2f vert(appdata_base v)
		{
			v2f o;

			o.pos=UnityObjectToClipPos(v.vertex);

			o.vertex=v.vertex;

			o.normal=v.normal;

			return o;
		}

		fixed4 frag(v2f IN):COLOR
		{
			//return fixed4(1,1,1,1);

			float3 N= mul(IN.normal,(float3x3)unity_WorldToObject);

			N=normalize(N);

			float3 worldPos= mul(unity_ObjectToWorld,IN.vertex).xyz;

			float3 V= _WorldSpaceCameraPos.xyz-worldPos;

			V=normalize(V);

			float bright=1- saturate(dot(N,V));

			bright=pow(bright,_Scale);

			return fixed4(1,1,1,1)*bright;
		}

		ENDCG
	}
 }

}