﻿Shader "Sbin/ff2" {
	Properties {
		_Color("Main Color",color)=(1,1,1,1)

		_Ambient("Ambient",color)=(0.3,0.3,0.3,0.3)

		_Specular("Specular",color)=(1,1,1,1)

		_Shininess("Shininess",range(0,8))=4

		_Emission("Emission",color)=(1,1,1,1)

		_Constant("ConstantColor",color)=(1,1,1,0.3)

		_MainTex("MainTex",2d)=""

		_SecondTex("SecondTex",2d)=""


	}
	SubShader {

		Tags {"Queue" = "Transparent"}
		
		pass
		{

			Blend SrcAlpha OneMinusSrcAlpha

			material
			{
				diffuse[_Color]
				ambient[_Ambient]
				specular[_Specular]
				shininess[_Shininess]
				emission[_Emission]
			}

			lighting on

			separatespecular on

			settexture[_MainTex]
			{
				combine texture * primary 
			}

			settexture [_SecondTex]
			{	
				constantColor[_Constant]
				combine texture * previous,texture * constant
			}
		}
	}
	
}
