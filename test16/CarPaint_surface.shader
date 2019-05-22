Shader "Sbin/CarPaint_Surface"{

	Properties{
		_MainColor("MainColor",color)=(1,1,1,1)

		_SecondColor("SecondColor",color)=(1,1,1,1)

		_Center("Center",range(-1.0,1.0))=0

		_R("R",range(0,0.5))=0.2

		_Glossiness ("Smoothness",Range(0,1))=0.5

		_Metallic ("Metallic",Range(0,1))=0.0

		_Cube("Cubemap",cube)=""{}
	}

	SubShader{

		Tags {"RenderType"="Opaque"}


		CGPROGRAM

		#pragma surface surf Standard vertex:vert
		#pragma target 3.0

		//sampler2D _MainTex;

		samplerCUBE _Cube;

		half _Glossiness;

		half _Metallic;

		float4 _MainColor;

		float4 _SecondColor;

		float _R;

		float _Center;

		struct Input{
			//float2 uv_MainTex;

			float3 worldRefl;

			float x;
		};

		void vert(inout appdata_full v,out Input o)
		{
			//o.uv_MainTex= v.texcoord.xy;

			float3 V=-WorldSpaceViewDir(v.vertex);

			float3 N=mul(v.normal,(float3x3)unity_WorldToObject);

			N=normalize(N);

			o.worldRefl=reflect(V,N);

			o.x= v.vertex.x;
		}

		void surf(Input IN,inout SurfaceOutputStandard o){
			 //fixed4 c= tex2D (_MainTex,IN.uv_MainTex);

			 fixed4 c= texCUBE(_Cube,IN.worldRefl);

			 o.Albedo=c.rgb;

			 o.Metallic= _Metallic;

			 o.Smoothness= _Glossiness;

			 o.Alpha=c.a;

			 float d= IN.x-_Center;
			 float s=abs(d);

			 d=d/s;

			 float f= s/_R;

			 f=saturate(f);

			 d*=f;

			 d= d/2+0.5;

			 o.Albedo*=lerp(_MainColor,_SecondColor,d);
		}

		ENDCG

	}

	FallBack "Diffuse"

}