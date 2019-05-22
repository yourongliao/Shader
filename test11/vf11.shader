// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "Sbin/vf11"{

properties
{
	_SpecularColor("Specular",color)=(1,1,1,1)

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
			fixed4 color:COLOR;
		};

		v2f vert(appdata_base v)
		{
			v2f o;

			float4x4 mvp=UNITY_MATRIX_MVP;

			o.pos=mul(mvp,v.vertex);

			float3 L=normalize(WorldSpaceLightDir(v.vertex));

			float3 N=UnityObjectToWorldNormal(v.normal);

			float3 V=normalize(WorldSpaceViewDir(v.vertex));

			o.color= UNITY_LIGHTMODEL_AMBIENT;

			float ndotl=saturate(dot(N,L));

			o.color+= _LightColor0 * ndotl;

			float3 H=L+V;

			H=normalize(H);

			float specularScale=pow(saturate(dot(H,N)),_Shininess);

			o.color.rgb+=_SpecularColor * specularScale;

			return o;
		}

		fixed4 frag(v2f IN):COLOR
		{
			//return IN.color;

			return IN.color;
		}

		ENDCG
	}
}

}