using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Replace : MonoBehaviour {

	// Use this for initialization
	void Start () {
		Camera.main.SetReplacementShader (Shader.Find ("Sbin/vf30"), "rendertype");
	}
	
	// Update is called once per frame
	void Update () {
		
	}
}
