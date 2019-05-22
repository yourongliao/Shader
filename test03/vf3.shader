Shader "Sbin/vf3" {
	SubShader{
	 	pass{
	 		CGPROGRAM
	 		#pragma vertex vert
	 		#pragma fragment frag

	 		#include "sbin/sbin.cginc"

	 		struct v2f{
	 			float4 pos:POSITION;
	 			float2 objPos:TEXCOORD0;

	 			float4 col:COLOR;
	 		};

	 		v2f vert(in float2 objPos:POSITION,in float4 pos:TEXCOORD0)
			{
				v2f o;

				pos=float4(objPos,0,1);


			 	if(pos.x<0)
			 	{
			 		o.col=float4(1,0,0,1);

			 	
			 	}else
			 	{
			 		o.col=float4(0,1,0,1);
			 	}
				//pos=float4(objPos,0,1);

				o.pos=float4(objPos,0,1);

				//o.objPos=objPos;

				o.objPos=float2(1,0);

				//o.col=float4(1,1,0,1);

				return o;
				//Func(pos);
			}

			fixed4 frag(v2f IN):COLOR
			{
				return IN.col;

				//return fixed4(opos,0,1);
			 	//Func(col);

			 	//float arr[]={0.5,0.5};

			 	//col.x=Func2(arr);



			 	//return col;
			}



			ENDCG
	 	}
	 }
}
