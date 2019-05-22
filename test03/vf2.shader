Shader "Sbin/vf2" {
	 SubShader{
	 	pass{
	 		CGPROGRAM
	 		#pragma vertex vert
	 		#pragma fragment frag



	 		void vert(in float2 objPos:POSITION,out float4 pos:POSITION,out float4 col:COLOR)
			{

				pos=float4(objPos,0,1);


			 	if(pos.x<0)
			 	{
			 		col=float4(1,0,0,1);

			 	
			 	}
			 	else
			 	{
			 		col=float4(0,1,0,1);

			 	}
				//col=pos;
			}

			void frag(inout float4 col:COLOR)
			{
			 	int i=0;

			 	while(i<10)
			 	{
			 		i++;
			 	}

			 	if(i==10)
			 		col=float4(0,0,0,1);

			 	i=0;

			 	do{
			 		i++;
			 	}while(i<10);

			 	if(i==10)
			 		col=float4(1,1,1,1);

			 	for(i=0;i<1000000;i++)
			 	{

			 	}

			 	if(i==1000000)
			 		col=float4(0.5f,0.5f,0,1);
			}

			ENDCG
	 	}
	 }
}
