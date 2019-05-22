Shader "Sbin/vf" {
	SubShader {
		pass{
			CGPROGRAM
// Upgrade NOTE: excluded shader from OpenGL ES 2.0 because it uses non-square matrices
#pragma exclude_renderers gles
// Upgrade NOTE: excluded shader from DX11; has structs without semantics (struct v2f members pos,uv)
#pragma exclude_renderers d3d11
				#pragma vertex vert
				#pragma fragment frag

				#define MACROFL FL4(fl4.ab,fl3.zy);

				typedef float4 FL4;

				struct v2f{
					float4 pos;
					float2 uv;
				};

				void vert(in float2 objPos:POSITION,out float4 pos:POSITION,float4 col:COLOR)
				{
					pos=float4(objPos,0,1);

					col=pos;

				}

				void frag(inout float4 col:COLOR)
				{
					//col=float4(1,0,0,1);

					fixed r=1;
					fixed g=0;
					fixed b=0;
					fixed a=1;

					col=float4(r,g,b,a);

					bool bl=true;

					col=bl? col:fixed4(0,1,0,1);

					float2 fl2=float2(1,0);

					float3 fl3=float3(1,0,1);

					float4 fl4=float4(1,1,0,1);

					//float4 fl=float4(fl2.xy,0,1);

					//float4 fl=float4(fl4.wzyx);

					//float4 fl=float4(fl3.xyzx);

					//float4 fl=float4(fl4.ab,fl3.zy);

					//float4 fl=FL4(fl4.ab,fl3.zy);

					FL4 fl=MACROFL

					col=fl;


					//float2x4 M2x4={0,0,1,1, 0,1,0,1};

					//float2x4 M2x4={{0,0,1,1}, {0,1,0,1}};

					float2x4 M2x4={fl4, 0,1,0,1};

					col=M2x4[0];

					float arr[4]={1,0.5,0.5,1};

					col=float4(arr[0],arr[1],arr[2],arr[3]);

					v2f o;

					o.pos=fl4;

					o.uv=fl2;

				}

			ENDCG
		}
	}
}
