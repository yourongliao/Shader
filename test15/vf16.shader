Shader "Sbin/vf16"{

	properties
	{
		_MainColor("MainColor",color)=(1,1,1,1)

		_SecondColor("SecondColor",color)=(1,1,1,1)

		_Center("Center",range(-0.7,0.8))=0

		_R("R",range(0,0.5))=0.2
	}

	SubShader
	{

		pass{

			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag
			#include "unitycg.cginc"

			float4 _MainColor;

			float4 _SecondColor;

			float _R;

			float _Center;

			struct v2f{

			float4 pos:POSITION;
			//float4 col:COLOR;
			//float y:COLOR;
			float y:TEXCOORD0;

			};

			v2f vert(appdata_base v)
			{
				v2f o;

				float4x4 mvp=UNITY_MATRIX_MVP;

				o.pos=mul(mvp,v.vertex);

				o.y= v.vertex.y;

				//if(v.vertex.y<0)
				//o.col=_MainColor;
				//else
				//o.col=_SceondColor;

				return o;
			}

			fixed4 frag(v2f IN):COLOR
			{

				if(IN.y>_Center+_R)
				{
					return _MainColor;
				}
				else if(IN.y>_Center && IN.y<_Center+_R)
				{
					float d=IN.y-_Center;

					d=(1-d/_R)-0.5;

					d=saturate(d);

					return lerp(_MainColor,_SecondColor,d);
				}


				if(IN.y<=_Center-_R)
				{
					return _SecondColor;
				}
				else if(IN.y<_Center && IN.y>_Center-_R)
				{
					float d=_Center-IN.y;

					d=(1-d/_R)-0.5;

					d=saturate(d);

					return lerp(_MainColor,_SecondColor,1-d);
				}

				return lerp(_MainColor,_SecondColor,0.5);



				//return _MainColor;

				//return IN.col;

				//if(IN.y>_Center)
					//return _MainColor;
				//else
					//return _SecondColor;
	

				//float d = IN.y - _Center;

				//d=d/abs(d);

				//d=d/2+0.5;

				//return lerp(_MainColor,_SecondColor,d);

			}

			ENDCG
		}
	
	}

}