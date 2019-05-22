// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Sbin/Textures/vf22"{

	properties{
		_MainTex("MainTex",2D)=""{}

		_F("F",range(1,30))=10

		_A("A",range(0,0.1))=0.01

		_R("R",range(0,1))=0
	}

	SubShader{

		pass{

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#include "unitycg.cginc"

			sampler2D _MainTex;

			float4 _MainTex_ST;

			float _F;

			float _A;

			float _R;

			struct v2f{

			float4 pos:POSITION;

			float2 uv:TEXCOORD0;

			float z:TEXCOORD1;

			};

			v2f vert(appdata_base v)
			{
				v2f o;

				float4x4 mvp=UNITY_MATRIX_MVP;

				o.pos=mul(mvp,v.vertex);


				o.uv=TRANSFORM_TEX(v.texcoord,_MainTex)

				o.z=mul(unity_ObjectToWorld,v.vertex).z;


				return o;
			}

			fixed4 frag(v2f IN):COLOR
			{
				//float offset_uv=0.05;

				//float2 uv=IN.uv;

				//fixed4 color=tex2D(_MainTex,uv);

				//uv.x=IN.uv.x + offset_uv;

				//color.rgb+= tex2D(_MainTex,uv);

				//uv.x=IN.uv.x - offset_uv;

				//color.rgb+= tex2D(_MainTex,uv);

				//uv.y=IN.uv.y + offset_uv;

				//color.rgb+= tex2D(_MainTex,uv);

				//uv.y=IN.uv.y - offset_uv;

				//color.rgb+= tex2D(_MainTex,uv);

				//color.rgb /=5;

				//fixed4 color=tex2D(_MainTex,IN.uv,float2(0.01,0.01),float2(0.01,0.01));



				//float dx=ddx(IN.uv.x)*10;

				//float2 dsdx=float2(dx,dx);

				//float dy=ddy(IN.uv.y)*10;

				//float2 dsdy=float2(dy,dy);


				float2 dsdx=ddx(IN.z)*10;

				float2 dsdy=ddy(IN.z)*10;


				fixed4 color=tex2D(_MainTex,IN.uv,dsdx,dsdy);

				return color;
			}

			ENDCG
		}

	}

}