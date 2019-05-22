// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Sbin/vf12"{

properties
{
	_SpecularColor("SpecularColor",color)=(1,1,1,1)
	_Shininess("Shininess",range(1,32))=8
}

SubShader{

	pass
	{
		tags{"LightMode"="ForwardBase"}
		
		CGPROGRAM

		#pragma vertex vert
		#pragma fragment frag

		#include "unitycg.cginc"

		#include "lighting.cginc"

		float4 _SpecularColor;
		float _Shininess;


		struct v2f{
			float4 pos:POSITION;
			float3 normal:TEXCOORD1;
			float4 vertex:COLOR;
		};

		v2f vert(appdata_base v)
		{
			v2f o;

			float4x4 mvp=UNITY_MATRIX_MVP;

			o.pos=mul(mvp,v.vertex);

			o.normal=v.normal;

			o.vertex=v.vertex;

			return o;
		}

		fixed4 frag(v2f IN):COLOR
		{

			fixed4 col = UNITY_LIGHTMODEL_AMBIENT;

			float3 N = UnityObjectToWorldNormal(IN.normal);

			float3 L=normalize(WorldSpaceLightDir(IN.vertex));

			//float diffuseScale=saturate(dot(IN.normal,IN.lightDir));

			float diffuseScale= saturate(dot(N,L));

			col += _LightColor0 * diffuseScale;

			float3 V=normalize(WorldSpaceViewDir(IN.vertex));

			float3 R= 2* dot(N,L)*N-L;

			float specularScale=saturate(dot(R,V));

			col+= _SpecularColor * pow(specularScale,_Shininess);

			float3 wpos=mul(unity_ObjectToWorld,IN.vertex).xyz;

			col.rgb += Shade4PointLights(
						unity_4LightPosX0,unity_4LightPosY0,unity_4LightPosZ0,
						unity_LightColor[0].rgb,unity_LightColor[1].rgb,unity_LightColor[2].rgb,unity_LightColor[3].rgb,
						unity_4LightAtten0,
						wpos,N
			);

			return col;
		}

		ENDCG
	}
}

}