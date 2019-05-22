// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "Sbin/vf31"{

	properties{
		_Cube("Cubemap",cube)=""{}
	}

	SubShader{

		pass{

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "unitycg.cginc"

			samplerCUBE _Cube;

			struct v2f{
				float4 pos:POSITION;
				float3 R:TEXCOORD0;
			};

			v2f vert(appdata_base v)
			{
				v2f o;

				float4x4 mvp=UNITY_MATRIX_MVP;

				o.pos=mul(mvp,v.vertex);

				float3 V=-WorldSpaceViewDir(v.vertex);

				float3 N=mul(v.normal,(float3x3)unity_WorldToObject);

				N=normalize(N);

				o.R=reflect(V,N);

				return o;
			}

			fixed4 frag(v2f IN):COLOR
			{
				fixed4 color=texCUBE(_Cube,IN.R);

				return color;
			}

			ENDCG
		}

	}

}